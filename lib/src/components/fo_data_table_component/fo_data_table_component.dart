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

    if (data == null) data = new Map();
  }

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("rows") || changes.containsKey("data"))
    {
      if (data == null) data = new Map();
      selectedRowOption = rowOptions.optionsList.firstWhere((r) => r.count == rows, orElse: () => rowOptions.optionsList.first);

      //_filteredKeys = data.keys;
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

  void onSearch()
  {
    sortColumn = null;

    if (searchPhrase != null && searchPhrase.isNotEmpty)
    {
      bool find(FoModel model, List<String> keywords)
      {
        return (model.toTableRow().values.firstWhere((value) => (keywords.firstWhere((keyword) =>
            value.toString().toLowerCase().contains(keyword), orElse: () => null) != null), orElse: () => null) != null);
      }

      List<String> keywords = searchPhrase.toLowerCase().split(" ");
      _filteredKeys = data.values.where((model) => find(model, keywords)).map((value) => data.keys.firstWhere((key) => data[key] == value));
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
        int sort(Map<String, String> a, Map<String, String> b)
        {
          if (a[sortColumn] == null) a[sortColumn] = "-";
          if (b[sortColumn] == null) b[sortColumn] = "-";

          try
          {
            // Number comparison
            num numA = num.parse(a[sortColumn]);
            num numB = num.parse(b[sortColumn]);
            return (sortOrder == "ASC") ? (numA - numB).toInt() : (numB - numA).toInt();
          }
          on FormatException
          {
            try
            {
              // Date comparison
              DateTime dateA = DateTime.parse(a[sortColumn]);
              DateTime dateB = DateTime.parse(b[sortColumn]);
              return (sortOrder == "ASC") ? (dateA.difference(dateB)).inMinutes : (dateB.difference(dateA)).inMinutes;
            }
            on FormatException
            {
              // Default String comparison
              String colA = a[sortColumn].toString().toLowerCase();
              String colB = b[sortColumn].toString().toLowerCase();

              return (sortOrder == "ASC") ? colA.compareTo(colB) : colB.compareTo(colA);
            }
          }
        }

        List<FoModel> values = filteredKeys.map((key) => data[key]).toList(growable: false);
        values.sort((FoModel a, FoModel b) => sort(a.toTableRow(), b.toTableRow()));

        _filteredKeys = values.map((model) => model.id);
      }
    }
  }

  void onDownloadDataCSV()
  {
    if (data.isNotEmpty)
    {
      /**
       * Generate CSV string (Property1;Property2;Property3;Property4;Property5\n)
       */
      StringBuffer sb = new StringBuffer();

      String columns = data.values.first.toTableRow().keys.map(_phraseService.get).join(";");
      sb.writeln(columns);

      for (String key in filteredKeys)
      {
        Map<String, String> dataRow = data[key].toTableRow();

        /// Add "'"-character if ¨the cell has a leading '0'-character. This will stop Excel from skipping leading 0
        for (String key in dataRow.keys)
        {
          try
          {
            num.parse(dataRow[key]);
            if (dataRow[key].startsWith("0")) dataRow[key] = '="' + dataRow[key] + '"';
          }
          catch (e) { /* Not a number, continue */ }
        }
        sb.writeln(dataRow.values.join(";"));
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
    if (first_index < 0 || first_index >= data.length) return;

    int rowCount = selectedRowOption.count;

    firstIndex = first_index;
    if (searchPhrase != null && searchPhrase.isNotEmpty) firstIndex = max(0, min(firstIndex, filteredKeys.length - rowCount));
    lastIndex = firstIndex + rowCount;

    currentPage = (data.isEmpty) ? 0 : (firstIndex.toDouble() / rowCount).ceil() + 1;
  }

  Iterable<String> get col => data.isEmpty ? [] : data.values.first.toTableRow().keys;

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

  Iterable<String> get filteredKeys => _filteredKeys == null ? data.keys : _filteredKeys;

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
  Map<String, FoModel> data = new Map();

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