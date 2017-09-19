// Copyright (c) 2017, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library data_table_component;

import 'dart:async' show Stream, StreamController;
import 'dart:html' as dom;
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/fo_components.dart';

@Component(
    selector: 'fo-data-table',
    styleUrls: const ['fo_data_table_component.css'],
    templateUrl: 'fo_data_table_component.html',
    directives: const [CORE_DIRECTIVES, FoModalComponent, FoSelectComponent, materialDirectives, MaterialIconComponent],
    pipes: const [PhrasePipe, RangePipe],
    changeDetection: ChangeDetectionStrategy.Default)

class DataTableComponent implements OnChanges, OnInit, OnDestroy
{
  DataTableComponent(this._phraseService);

  void ngOnInit()
  {
    selectedRowOption = rowOptions.optionsList.firstWhere((r) => r.count == rows, orElse: () => rowOptions.optionsList.first);
    firstIndex = 0;
    lastIndex = selectedRowOption.count;

    if (data == null) data = new Map();

    //_filteredKeys = data.keys;
  }

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("rows") || changes.containsKey("data"))
    {
      if (data == null) data = new Map();
      selectedRowOption = rowOptions.optionsList.firstWhere((r) => r.count == rows, orElse: () => rowOptions.optionsList.first);
      setIndices(0);
    }
    /*
    if (changes.containsKey("data"))
    {
      _filteredKeys = data.keys;
    }*/
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
    else _filteredKeys = data.keys;

    setIndices(0);
  }

  void onSearchKeyUp(dom.KeyboardEvent e)
  {
    if (e.keyCode == dom.KeyCode.ENTER || e.keyCode == dom.KeyCode.MAC_ENTER) onSearch();
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

      for (String key in _filteredKeys)
      {
        String row = data[key].toTableRow().values.join(";");
        sb.writeln(row);
      }

      String csv = Uri.encodeComponent(sb.toString());
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
    if (searchPhrase != null && searchPhrase.isNotEmpty) firstIndex = max(0, min(firstIndex, _filteredKeys.length - rowCount));
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
    if (state) selectedRows = _filteredKeys.toList();
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

  final StreamController<String> onCellClickController = new StreamController();
  final StreamController<List<String>> onSelectedRowsController = new StreamController();
  final StreamController<String> onDeleteController = new StreamController();
  final StreamController<String> onRowClickController = new StreamController();
  final StreamController<Map<String, String>> _onSortController = new StreamController();
  final PhraseService _phraseService;

  @Input('large-hidden-col')
  List<String> largeHiddencol = [];

  @Input('small-hidden-col')
  List<String> smallHiddencol = [];

  @Input('medium-hidden-col')
  List<String> mediumHiddencol = [];

  @Input('models')
  Map<String, FoModel> data = new Map();

  @Input('showCheckboxes')
  bool showCheckboxes = false;

  @Input('title')
  String title = "";

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