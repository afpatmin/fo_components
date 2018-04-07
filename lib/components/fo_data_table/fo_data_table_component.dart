// Copyright (c) 2017, Minoch AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html' as dom;
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_model/fo_model.dart';
import '../../pipes/phrase_pipe.dart';
import '../../pipes/range_pipe.dart';
import '../../services/phrase_service.dart';
import '../fo_modal/fo_modal_component.dart';
import '../fo_select/fo_select_component.dart';

/// Callback function for evaluated columns
typedef Object EvaluateColumnFn(Object model);

@Component(
    selector: 'fo-data-table',
    styleUrls: const ['fo_data_table_component.css'],
    templateUrl: 'fo_data_table_component.html',
    directives: const <dynamic>[
      coreDirectives,
      FoModalComponent,
      FoSelectComponent,
      materialDirectives,
      MaterialIconComponent
    ],
    pipes: const <Type>[PhrasePipe, RangePipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    visibility: Visibility.local)
class FoDataTableComponent
    implements OnChanges, OnInit, AfterViewInit, OnDestroy {
  FoDataTableComponent(this.host, this.phraseService);

  @override
  void ngOnInit() {
    selectedRowOptionId = rowOptions
        .firstWhere((r) => r.id == rows, orElse: () => rowOptions.first)
        .id;
    firstIndex = 0;
    lastIndex = _selectedRowOption.id;

    _onWindowResizeListener =
        dom.window.onResize.listen((_) => _evaluateLayout());
  }

  @override
  void ngAfterViewInit() {
    _evaluateLayout();
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    if (changes.containsKey('rows') || changes.containsKey('data')) {
      data ??= {};
      selectedRowOptionId = rowOptions
          .firstWhere((r) => r.id == rows, orElse: () => rowOptions.first)
          .id;
      onSearch();
      setIndices(0);
    }

    _evaluateLayout();
  }

  @override
  void ngOnDestroy() {
    onAddController.close();
    onDeleteController.close();
    onRowClickController.close();
    onSelectedRowsController.close();
    _onFilterController.close();
    _onSortController.close();
    _onBatchOperationController.close();
    _onWindowResizeListener.cancel();
  }

  dynamic getCell(Object id, String column) =>
      (data[id] as FoModel).toJson()[column];

  bool isBool(Object value) => value is bool;

  void step(int steps) {
    setIndices(firstIndex + (steps * _selectedRowOption.id));
  }

  void onSearchKeyUp(dom.KeyboardEvent e) {
    if (!lazyFilter) {
      onSearch();
    } else if (e.keyCode == dom.KeyCode.ENTER ||
        e.keyCode == dom.KeyCode.MAC_ENTER) {
      onSearch();
    }
  }

  void onSearch() {
    if (internalFilter && searchPhrase != null && searchPhrase.isNotEmpty) {
      bool find(Object model, List<String> keywords) {
        bool allKeywords;
        final row = json.decode(json.encode(model));
        for (final keyword in keywords) {
          allKeywords = false;
          for (final col in columns) {
            final data = row[col]?.toString();
            if (data != null &&
                phraseService.get(data).toLowerCase().contains(keyword)) {
              allKeywords = true;
              break;
            }
          }
          for (final col in evaluatedColumns.keys) {
            final data = evaluatedColumns[col](model);
            if (data != null &&
                phraseService.get(data).toLowerCase().contains(keyword)) {
              allKeywords = true;
              break;
            }
          }
          if (allKeywords == false) {
            return false;
          }
        }
        return true;
      }

      final keywords = searchPhrase.toLowerCase().split(' ');
      _filteredKeys = data.keys.where((key) => find(data[key], keywords));
    } else
      _filteredKeys = null;

    _onFilterController.add(searchPhrase);
    setIndices(0);
  }

  void onSort(Object column) {
    if (!disabled && column != null) {
      sortColumn = column;
      sortOrder = (sortOrder == 'ASC') ? 'DESC' : 'ASC';
      _onSortController.add({'column': sortColumn, 'order': sortOrder});

      searchPhrase = null;
      _filteredKeys = null;

      /// Evaluated columns are always sorted internally
      if (internalSort || evaluatedColumns.containsKey(column)) {
        int sort(String a, String b) {
          final vA = a == null ? '-' : a;
          final vB = b == null ? '-' : b;
          try {
            // Number comparison
            final numA = num.parse(vA);
            final numB = num.parse(vB);
            return (sortOrder == 'ASC')
                ? (numA - numB).toInt()
                : (numB - numA).toInt();
          } on FormatException {
            try {
              // Date comparison
              final dateA = DateTime.parse(vA);
              final dateB = DateTime.parse(vB);
              return (sortOrder == 'ASC')
                  ? dateA.difference(dateB).inMilliseconds
                  : dateB.difference(dateA).inMilliseconds;
            } on FormatException {
              // Default String comparison
              final colA = a.toLowerCase();
              final colB = b.toLowerCase();

              return (sortOrder == 'ASC')
                  ? colA.compareTo(colB)
                  : colB.compareTo(colA);
            }
          }
        }

        final values = data.keys
            .where(filteredKeys.contains)
            .map((key) => data[key])
            .toList();

        if (values != null) {
          if (columns.contains(sortColumn))
            values.sort((a, b) => sort(
                json.decode(json.encode(a))[sortColumn].toString(),
                json.decode(json.encode(b))[sortColumn].toString()));
          else if (evaluatedColumns.containsKey(sortColumn))
            values.sort((a, b) => sort(evaluatedColumns[sortColumn](a),
                evaluatedColumns[sortColumn](b)));

          _filteredKeys =
              values.map((model) => json.decode(json.encode(model))['id']);
        }
      }
    }
  }

  void onDownloadDataCSV() {
    if (data.isNotEmpty) {
      /// Generate CSV string (Property1;Property2;Property3;Property4;Property5\n)
      final sb = new StringBuffer();

      final colNames = new List.from(columns)..addAll(evaluatedColumns.keys);
      sb.writeln(colNames);

      for (final key in filteredKeys) {
        final model = data[key];
        if (model == null) continue;

        final row = json.decode(json.encode(model));

        final properties = columns.map((col) => row[col]).toList()
          ..addAll(
              evaluatedColumns.keys.map((id) => evaluatedColumns[id](model)));

        /// Add "'"-character if ¨the cell has a leading '0'-character. This will stop Excel from skipping leading 0
        for (var property in properties) {
          try {
            num.parse(property);
            if (property.startsWith('0')) {
              property = '="$property"';
            }
          } on FormatException {
            /* Not a number, continue */
          }
        }

        sb.writeln(properties.join(';'));
      }

      final csv = Uri.encodeComponent(sb.toString());

      /* UTF-8 BOM */
      new dom.AnchorElement(href: 'data:text/csv;charset=utf-8,\uFEFF$csv')
        ..setAttribute('download', 'data.csv')
        ..click();
    }
  }

  void setIndices(int inFirstIndex) {
    if (inFirstIndex <= -(_selectedRowOption.id as int)||
        inFirstIndex >= data.length) return;

    firstIndex = max(0, inFirstIndex);
    if (searchPhrase != null && searchPhrase.isNotEmpty)
      firstIndex = max(
          0, min(firstIndex, filteredKeys.length - _selectedRowOption.id));
    lastIndex = firstIndex + _selectedRowOption.id;

    currentPage = (data.isEmpty)
        ? 0
        : (firstIndex.toDouble() / _selectedRowOption.id).ceil() + 1;
  }

  int get totalPages =>
      (filteredKeys.length.toDouble() / _selectedRowOption.id).ceil();

  bool get lazyFilter =>
      data == null || !internalFilter || data.length < liveSearchThreshold;

  final List<FoModel> rowOptions = [
    new FoModel()..id = 5,
    new FoModel()..id = 10,
    new FoModel()..id = 15,
    new FoModel()..id = 20,
    new FoModel()..id = 25,
    new FoModel()..id = 50,
    new FoModel()..id = 100,
  ];

  void onCheckedChange(Object id, bool state) {
    if (state)
      selectedRows.add(id);
    else
      selectedRows.remove(id);
    onSelectedRowsController.add(selectedRows);
  }

  void onBatchOperationTrigger(String event) {
    _onBatchOperationController
        .add(new BatchOperationEvent(event, selectedRows));

    allChecked = false;
  }

  bool get allChecked => _allChecked;

  set allChecked(bool state) {
    _allChecked = state;
    if (_allChecked)
      selectedRows = filteredKeys.toSet();
    else
      selectedRows.clear();
  }

  void _evaluateLayout() {
    final dom.DivElement container = host.querySelector('.table-container');
    final dom.TableElement table = container.querySelector('table');

    table.classes.remove('fixed-layout');
    if (container.getBoundingClientRect().width <
        table.getBoundingClientRect().width) {
      table.classes.add('fixed-layout');
    }
  }

  String get filterLabel => lazyFilter ? 'filter_enter' : 'filter';

  Iterable<Object> get filteredKeys =>
      _filteredKeys == null ? data.keys : _filteredKeys;

  int get selectedRowOptionId => _selectedRowOption?.id;

  set selectedRowOptionId(int value) {
    _selectedRowOption = rowOptions.firstWhere((row) => row.id == value,
        orElse: () => rowOptions.first);
  }

  FoModel _selectedRowOption;
  Object deleteBufferId;
  int firstIndex = 0;
  int lastIndex = 1;
  int currentPage = 1;
  String searchPhrase = '';
  Iterable<Object> _filteredKeys;
  bool infoModalOpen = false;
  bool _allChecked;

  StreamSubscription _onWindowResizeListener;
  final dom.Element host;
  final int liveSearchThreshold = 500;
  final PhraseService phraseService;
  final StreamController<String> onAddController = new StreamController();
  final StreamController<Set<Object>> onSelectedRowsController =
      new StreamController();
  final StreamController<Object> onDeleteController = new StreamController();
  final StreamController<String> _onFilterController = new StreamController();
  final StreamController<Object> onRowClickController = new StreamController();
  final StreamController<Map<String, dynamic>> _onSortController =
      new StreamController();
  final StreamController<BatchOperationEvent> _onBatchOperationController =
      new StreamController();

  @Input()
  bool internalSort = true;

  @Input()
  bool internalFilter = true;

  @Input('large-hidden-col')
  Iterable<Object> largeHiddenCol = [];

  @Input('small-hidden-col')
  Iterable<Object> smallHiddenCol = [];

  @Input('medium-hidden-col')
  Iterable<Object> mediumHiddenCol = [];

  @Input()
  Object sortColumn = '';

  @Input()
  String sortOrder = 'DESC';

  @Input()
  Map<Object, Object> data = {};

  @Input()
  Iterable<Object> columns = [];

  @Input()
  Map<Object, EvaluateColumnFn> evaluatedColumns = {};

  @Input()
  bool showAddButton = false;

  @Input()
  bool showCheckboxes = false;

  @Input()
  List<FoModel> batchOperations;

  @Input()
  bool showDeleteButtons = false;

  @Input()
  bool showDownloadButton = true;

  @Input()
  String label = '';

  @Input()
  String description;

  @Input()
  Set<Object> selectedRows = new Set();

  @Input()
  int rows = 10;

  @Input()
  bool disabled = false;

  @Output('add')
  Stream<String> get onAddOutput => onAddController.stream;

  @Output('delete')
  Stream<Object> get onDeleteOutput => onDeleteController.stream;

  @Output('filter')
  Stream<String> get onFilterOutput => _onFilterController.stream;

  @Output('rowclick')
  Stream<Object> get onRowClickOutput => onRowClickController.stream;

  @Output('selectedRowsChange')
  Stream<Set<Object>> get selectedRowsChange => onSelectedRowsController.stream;

  @Output('sort')
  Stream<Map<String, dynamic>> get onSortOutput => _onSortController.stream;

  @Output('batchOperation')
  Stream<BatchOperationEvent> get onBatchOperationOutput =>
      _onBatchOperationController.stream;
}

/// Batch Operation Event, spawned as output whenever the user performs a batch action on the table
class BatchOperationEvent {
  /// Default constructor
  BatchOperationEvent(this.operation, this.selectedIds);

  /// The operation name
  final String operation;

  /// Selected ids whenever the user invoked batch operation
  final Set<Object> selectedIds;
}
