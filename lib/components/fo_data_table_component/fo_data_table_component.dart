// Copyright (c) 2017, Minoch AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as dom;
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../fo_modal_component/fo_modal_component.dart';
import '../fo_select_component/fo_select_component.dart';
import '../../models/fo_model.dart';
import '../../pipes/phrase_pipe.dart';
import '../../pipes/range_pipe.dart';


typedef String EvaluateColumnFn(FoModel model);

@Component(
    selector: 'fo-data-table',
    styleUrls: const ['fo_data_table_component.scss.css'],
    templateUrl: 'fo_data_table_component.html',
    directives: const [CORE_DIRECTIVES, FoModalComponent, FoSelectComponent, materialDirectives, MaterialIconComponent],
    pipes: const [PhrasePipe, RangePipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    visibility: Visibility.none)

class DataTableComponent implements OnChanges, OnInit, AfterViewInit, OnDestroy
{
  DataTableComponent();

  void ngOnInit()
  {
    selectedRowOptionId = rowOptions.firstWhere((r) => (r as RowOption).count == rows, orElse: () => rowOptions.first).id;
    firstIndex = 0;
    lastIndex = _selectedRowOption.count;

    _onWindowResizeListener = dom.window.onResize.listen((_) => _evaluateLayout());
  }

  void ngAfterViewInit()
  {
    _evaluateLayout();
  }

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("rows") || changes.containsKey("data"))
    {
      if (data == null) data = new Map();
      selectedRowOptionId = rowOptions.firstWhere((r) => (r as RowOption).count == rows, orElse: () => rowOptions.first).id;
      onSearch();
      setIndices(0);
    }

    _evaluateLayout();
  }

  void ngOnDestroy()
  {
    onAddController.close();
    onDeleteController.close();
    onRowClickController.close();
    onSelectedRowsController.close();
    _onSortController.close();
    _onBatchOperationController.close();
    _onWindowResizeListener.cancel();
  }

  void step(int steps)
  {
    setIndices(firstIndex + (steps * _selectedRowOption.count));
  }

  void onSearchKeyUp(dom.KeyboardEvent e)
  {
    if (data.length < liveSearchThreshold) onSearch();
    else if (e.keyCode == dom.KeyCode.ENTER || e.keyCode == dom.KeyCode.MAC_ENTER) onSearch();
  }

  void onSearch()
  {
    if (searchPhrase != null && searchPhrase.isNotEmpty)
    {
      bool find(FoModel model, List<String> keywords)
      {
        bool allKeywords;
        for (String keyword in keywords)
        {
          allKeywords = false;
          for (String col in columns)
          {
            String data = model[col]?.toString();
            if (data != null && data.toLowerCase().contains(keyword))
            {
              allKeywords = true;
              break;
            }
          }
          for (String col in evaluatedColumns.keys)
          {
            String data = evaluatedColumns[col](model);
            if (data != null && data.toLowerCase().contains(keyword))
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
      _filteredKeys = data.keys.where((key) => find(data[key], keywords));
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

      searchPhrase = null;
      _filteredKeys = null;

      if (internalSort || evaluatedColumns.containsKey(column)) /// Evaluated columns are always sorted internally
      {
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
                return (sortOrder == "ASC") ? dateA.difference(dateB).inMilliseconds : dateB.difference(dateA).inMilliseconds;
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

          List<FoModel> values = data.keys.where(filteredKeys.contains).map((key) => data[key]).toList();
          if (values != null)
          {
            if (columns.contains(sortColumn)) values.sort((FoModel a, FoModel b) => sort(a[sortColumn].toString(), b[sortColumn].toString()));
            else if (evaluatedColumns.containsKey(sortColumn)) values.sort((FoModel a, FoModel b) => sort(evaluatedColumns[sortColumn](a), evaluatedColumns[sortColumn](b)));
            _filteredKeys = values.map((model) => model["id"]);
          }
        }
      }
      else _onSortController.add({"column":sortColumn, "order":sortOrder});
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

      List<String> colNames = columns..addAll(evaluatedColumns.keys);

      sb.writeln(colNames);



      for (String key in filteredKeys)
      {
        FoModel model = data[key];
        if (model == null) continue;

        List<String> properties = columns.map((col) => model[col].toString()).toList();
        properties.addAll(evaluatedColumns.keys.map((id) => evaluatedColumns[id](model)));

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
    if (first_index <= -_selectedRowOption.count || first_index >= data.length) return;

    firstIndex = max(0, first_index);
    if (searchPhrase != null && searchPhrase.isNotEmpty) firstIndex = max(0, min(firstIndex, filteredKeys.length - _selectedRowOption.count));
    lastIndex = firstIndex + _selectedRowOption.count;

    currentPage = (data.isEmpty) ? 0 : (firstIndex.toDouble() / _selectedRowOption.count).ceil() + 1;
  }

  int get totalPages => (filteredKeys.length.toDouble() / _selectedRowOption.count).ceil();

  final List<FoModel> rowOptions =
  [
    new RowOption("5", 5),
    new RowOption("10", 10),
    new RowOption("15", 15),
    new RowOption("20", 20),
    new RowOption("25", 25),
    new RowOption("50", 50),
    new RowOption("100", 100),
  ];

  void onCheckedChange(String id, bool state)
  {
    if (state) selectedRows.add(id);
    else selectedRows.remove(id);
    onSelectedRowsController.add(selectedRows);
  }

  void onBatchOperationTrigger(String event)
  {
    _onBatchOperationController.add(new BatchOperationEvent(event, selectedRows));
  }

  void onAllCheckedChange(bool state)
  {
    if (state == true) selectedRows = filteredKeys.toSet();
    else selectedRows.clear();
  }

  void _evaluateLayout()
  {
    dom.DivElement container = tableContainer.nativeElement;
    dom.TableElement table = container.querySelector("table");

    table.classes.remove("fixed-layout");
    if (container.getBoundingClientRect().width < table.getBoundingClientRect().width)
    {
      table.classes.add("fixed-layout");
    }
  }


  String get filterLabel => (data == null || (data.length < liveSearchThreshold)) ? "filter" : "filter_enter";
  Iterable<String> get filteredKeys => _filteredKeys == null ? data.keys : _filteredKeys;
  String get selectedRowOptionId => _selectedRowOption?.id;
  void set selectedRowOptionId(String value)
  {
    _selectedRowOption = rowOptions.firstWhere((row) => row.id == value, orElse: () => rowOptions.first);
  }

  RowOption _selectedRowOption;
  String deleteBufferId;
  int firstIndex = 0;
  int lastIndex = 1;
  int currentPage = 1;
  String searchPhrase = "";
  Iterable<String> _filteredKeys;
  bool infoModalOpen = false;

  StreamSubscription _onWindowResizeListener;
  final int liveSearchThreshold = 500;
  final StreamController<String> onAddController = new StreamController();
  final StreamController<Set<String>> onSelectedRowsController = new StreamController();
  final StreamController<String> onDeleteController = new StreamController();
  final StreamController<String> onRowClickController = new StreamController();
  final StreamController<Map<String, String>> _onSortController = new StreamController();
  final StreamController<BatchOperationEvent> _onBatchOperationController = new StreamController();

  @ViewChild('tableContainer')
  ElementRef tableContainer;

  @Input('internalSort')
  bool internalSort = true;

  @Input('large-hidden-col')
  List<String> largeHiddenCol = [];

  @Input('small-hidden-col')
  List<String> smallHiddenCol = [];

  @Input('medium-hidden-col')
  List<String> mediumHiddenCol = [];

  @Input('sortColumn')
  String sortColumn = "";

  @Input('sortOrder')
  String sortOrder = "DESC";

  @Input('data')
  Map<String, FoModel> data = new Map();

  @Input('columns')
  List<String> columns = new List();

  @Input('evaluatedColumns')
  Map<String, EvaluateColumnFn> evaluatedColumns = new Map();

  @Input('showAddButton')
  bool showAddButton = false;

  @Input('showCheckboxes')
  bool showCheckboxes = false;

  @Input('batchOperations')
  List<FoModel> batchOperations;

  @Input('showDeleteButtons')
  bool showDeleteButtons = false;

  @Input('showDownloadButton')
  bool showDownloadButton = true;

  @Input('label')
  String label = "";

  @Input('description')
  String description;

  @Input('selectedRows')
  Set<String> selectedRows = new Set();

  @Input('rows')
  int rows = 10;

  @Input('disabled')
  bool disabled = false;

  @Output('add')
  Stream<String> get onAddOutput => onAddController.stream;

  @Output('delete')
  Stream<String> get onDeleteOutput => onDeleteController.stream;

  @Output('rowclick')
  Stream<String> get onRowClickOutput => onRowClickController.stream;

  @Output('selectedRowsChange')
  Stream<Set<String>> get selectedRowsChange => onSelectedRowsController.stream;

  @Output('sort')
  Stream<Map<String, String>> get onSortOutput => _onSortController.stream;

  @Output('batchOperation')
  Stream<BatchOperationEvent> get onBatchOperationOutput => _onBatchOperationController.stream;
}

class RowOption implements FoModel
{
  RowOption(this.id, this.count);

  @override
  RowOption.fromMap(Map<dynamic, dynamic> map);

  @override
  dynamic operator[](Object key) => throw new UnsupportedError("Operator [] is not supported for RowOption");

  @override operator[]=(Object key, dynamic value) => throw new UnsupportedError("Operator []= is not supported for RowOption");

  @override
  String toString() => count.toString();

  @override
  Map<dynamic, dynamic> toMap() => throw new UnsupportedError("toMap() is not supported for RowOption");

  int count;
  @override String id;
}

class BatchOperationEvent
{
  BatchOperationEvent(this.operation, this.selectedIds);

  final String operation;
  final Set<String> selectedIds;
}