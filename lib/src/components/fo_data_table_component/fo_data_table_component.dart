// Copyright (c) 2017, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'dart:html' as dom;
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../fo_modal_component/fo_modal_component.dart';
import '../fo_select_component/fo_select_component.dart';
import '../../models/fo_model.dart';
import '../../pipes/phrase_pipe.dart';
import '../../pipes/range_pipe.dart';
import '../../services/phrase_service.dart';

@Component(
    selector: 'fo-data-table',
    styleUrls: const ['fo_data_table_component.scss.css'],
    templateUrl: 'fo_data_table_component.html',
    directives: const [CORE_DIRECTIVES, FoModalComponent, FoSelectComponent, materialDirectives, MaterialIconComponent],
    pipes: const [PhrasePipe, RangePipe],
    changeDetection: ChangeDetectionStrategy.Default,
    visibility: Visibility.none)

class DataTableComponent implements OnChanges, OnInit, OnDestroy
{
  DataTableComponent(this._phraseService);

  void ngOnInit()
  {
    selectedRowOption = rowOptions.optionsList.firstWhere((r) => r.count == rows, orElse: () => rowOptions.optionsList.first);
    firstIndex = 0;
    lastIndex = selectedRowOption.count;

    if (modelRegistry == null) modelRegistry = new Map();
  }

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("rows") || changes.containsKey("data"))
    {
      if (modelRegistry == null) modelRegistry = new Map();
      selectedRowOption = rowOptions.optionsList.firstWhere((r) => r.count == rows, orElse: () => rowOptions.optionsList.first);
      onSearch();
      setIndices(0);
    }
  }

  void ngOnDestroy()
  {
    onCellClickController.close();
    onDeleteController.close();
    onRowClickController.close();
    onSelectedRowsController.close();
    _onSortController.close();
  }

  void step(int steps)
  {
    setIndices(firstIndex + (steps * selectedRowOption.count));
  }

  void onSearchKeyUp(dom.KeyboardEvent e)
  {
    if (modelRegistry.length < 500) onSearch();
    else if (e.keyCode == dom.KeyCode.ENTER || e.keyCode == dom.KeyCode.MAC_ENTER) onSearch();
  }

  void onSearch()
  {
    sortColumn = null;

    if (searchPhrase != null && searchPhrase.isNotEmpty)
    {
      bool find(FoModel model, List<String> keywords)
      {
        bool allKeywords;
        for (String keyword in keywords)
        {
          allKeywords = false;
          for (String col in model.tableColumns)
          {
            if (model.getProperty(col).contains(keyword))
            {
              allKeywords = true;
              break;
            }
          }
          if (allKeywords == false) return false;
        }
        return true;
      }
      List<String> keywords = searchPhrase.toLowerCase().split(" ");
      _filteredKeys = modelRegistry.values.where((model) => find(model, keywords)).map((value) => modelRegistry.keys.firstWhere((key) => modelRegistry[key] == value));
    }
    else _filteredKeys = null;

    setIndices(0);
  }

  void onSort(String column)
  {
    if (!disabled)
    {
      sortColumn = column;
      sortOrder = (sortOrder == "ASC") ? "DESC" : "ASC";

      if (sortOrder != null && sortColumn != null && sortColumn.isNotEmpty)
      {
        int sort(String a, String b)
        {
          if (a == null) a = "-";
          if (b == null) b = "-";

          try
          {
            // Number comparison
            num numA = num.parse(a);
            num numB = num.parse(b);
            return (sortOrder == "ASC") ? (numA - numB).toInt() : (numB - numA).toInt();
          }
          on FormatException
          {
            try
            {
              // Date comparison
              DateTime dateA = DateTime.parse(a);
              DateTime dateB = DateTime.parse(b);
              return (sortOrder == "ASC") ? (dateA.difference(dateB)).inMinutes : (dateB.difference(dateA)).inMinutes;
            }
            on FormatException
            {
              // Default String comparison
              String colA = a.toLowerCase();
              String colB = b.toLowerCase();

              return (sortOrder == "ASC") ? colA.compareTo(colB) : colB.compareTo(colA);
            }
          }
        }

        List<FoModel> values = filteredKeys.map((key) => modelRegistry[key]).toList(growable: false);
        values.sort((FoModel a, FoModel b) => sort(a.getProperty(sortColumn), b.getProperty(sortColumn)));

        _filteredKeys = values.map((model) => model.id);
      }
    }
  }

  void onDownloadDataCSV()
  {
    if (modelRegistry.isNotEmpty)
    {
      /**
       * Generate CSV string (Property1;Property2;Property3;Property4;Property5\n)
       */
      StringBuffer sb = new StringBuffer();

      String columns = modelRegistry.values.first.tableColumns.map(_phraseService.get).join(";");
      sb.writeln(columns);

      for (String key in filteredKeys)
      {
        FoModel model = modelRegistry[key];

        List<String> properties = model.tableColumns.map(model.getProperty).toList(growable: false);

        /// Add "'"-character if ¨the cell has a leading '0'-character. This will stop Excel from skipping leading 0
        for (String property in properties)
        {
          try
          {
            num.parse(property);
            if (property.startsWith("0")) property = '="' + property + '"';
          }
          catch (e) { /* Not a number, continue */ }
        }
        sb.writeln(properties.join(";"));
      }

      String csv = Uri.encodeComponent(sb.toString());
      /* \uFEFF: UTF-8 BOM */
      new dom.AnchorElement(href:"data:text/csv;charset=utf-8,\uFEFF$csv")
        ..setAttribute("download", "data.csv")
        ..click();
    }
  }

  void setIndices(int first_index)
  {
    if (first_index < 0 || first_index >= modelRegistry.length) return;

    int rowCount = selectedRowOption.count;

    firstIndex = first_index;
    if (searchPhrase != null && searchPhrase.isNotEmpty) firstIndex = max(0, min(firstIndex, filteredKeys.length - rowCount));
    lastIndex = firstIndex + rowCount;

    currentPage = (modelRegistry.isEmpty) ? 0 : (firstIndex.toDouble() / rowCount).ceil() + 1;
  }

  Iterable<String> get col => modelRegistry.isEmpty ? [] : modelRegistry.values.first.tableColumns;

  int get totalPages => (filteredKeys.length.toDouble() / selectedRowOption.count).ceil();

  final StringSelectionOptions<RowOption> rowOptions = new StringSelectionOptions(
  [
    new RowOption(5, "5"),
    new RowOption(10, "10"),
    new RowOption(15, "15"),
    new RowOption(20, "20"),
    new RowOption(25, "25"),
    new RowOption(50, "50"),
    new RowOption(100, "100"),
  ]);

  void onCheckedChange(String id, bool state)
  {
    if (state) selectedRows.add(id);
    else selectedRows.remove(id);
    onSelectedRowsController.add(selectedRows);
  }

  void onAllCheckedChange(bool state)
  {
    if (state == true) selectedRows = filteredKeys.toList();
    else selectedRows.clear();
  }

  Iterable<String> get filteredKeys => _filteredKeys == null ? modelRegistry.keys : _filteredKeys;

  RowOption selectedRowOption;

  String deleteBufferId;
  int firstIndex = 0;
  int lastIndex = 1;
  int currentPage = 1;
  String sortColumn = "";
  String sortOrder = "DESC";
  String searchPhrase = "";
  Iterable<String> _filteredKeys;
  bool infoModalOpen = false;

  final StreamController<String> onCellClickController = new StreamController();
  final StreamController<List<String>> onSelectedRowsController = new StreamController();
  final StreamController<String> onDeleteController = new StreamController();
  final StreamController<String> onRowClickController = new StreamController();
  final StreamController<Map<String, String>> _onSortController = new StreamController();
  final PhraseService _phraseService;

  @Input('large-hidden-col')
  List<String> largeHiddenCol = [];

  @Input('small-hidden-col')
  List<String> smallHiddenCol = [];

  @Input('medium-hidden-col')
  List<String> mediumHiddenCol = [];

  @Input('models')
  Map<String, FoModel> modelRegistry = new Map();

  @Input('showCheckboxes')
  bool showCheckboxes = false;

  @Input('title')
  String title = "";

  @Input('description')
  String description;

  @Input('selectedRows')
  List<String> selectedRows = new List();

  @Input('rows')
  int rows = 10;

  @Input('disabled')
  bool disabled = false;

  @Input('showDeleteButtons')
  bool showDeleteButtons = false;

  @Input('showDownloadButton')
  bool showDownloadButton = true;

  @Output('cellclick')
  Stream<String> get onCellClickOutput => onCellClickController.stream;

  @Output('delete')
  Stream<String> get onDeleteOutput => onDeleteController.stream;

  @Output('rowclick')
  Stream<String> get onRowClickOutput => onRowClickController.stream;

  @Output('selectedRowsChange')
  Stream<List<String>> get selectedRowsChange => onSelectedRowsController.stream;

  @Output('sort')
  Stream<Map<String, String>> get onSortOutput => _onSortController.stream;
}

class RowOption extends FoModel
{
  RowOption(this.count, String id) : super(id);
  final int count;
}