// Copyright (c) 2017, Minoch AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as dom;
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../models/fo_model.dart';
import '../../pipes/phrase_pipe.dart';
import '../../pipes/range_pipe.dart';
import '../../services/phrase_service.dart';
import '../fo_modal/fo_modal_component.dart';
import '../fo_select/fo_select_component.dart';

/// Callback function for evaluated columns
typedef String EvaluateColumnFn(FoModel model);

@Component(
    selector: 'fo-data-table',
    styleUrls: const <String>['fo_data_table_component.scss.css'],
    templateUrl: 'fo_data_table_component.html',
    directives: const <dynamic>[
      CORE_DIRECTIVES,
      FoModalComponent,
      FoSelectComponent,
      materialDirectives,
      MaterialIconComponent
    ],
    pipes: const <Type>[PhrasePipe, RangePipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    visibility: Visibility.local)

/// A data table component displaying FoModels. Has built in filters, sort
/// pagination and many other features. class FoDataTableComponent
class FoDataTableComponent
    implements OnChanges, OnInit, AfterViewInit, OnDestroy {
  FoDataTableComponent(this.phraseService);

  @override
  void ngOnInit() {
    selectedRowOptionId = rowOptions
        .firstWhere((r) => r['count'] == rows, orElse: () => rowOptions.first)
        .id;
    firstIndex = 0;
    lastIndex = _selectedRowOption.count;

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
          .firstWhere((r) => r['count'] == rows, orElse: () => rowOptions.first)
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
    _onSortController.close();
    _onBatchOperationController.close();
    _onWindowResizeListener.cancel();
  }

  bool isBool(Object value) => value is bool;

  void step(int steps) {
    setIndices(firstIndex + (steps * _selectedRowOption.count));
  }

  void onSearchKeyUp(dom.KeyboardEvent e) {
    if (data.length < liveSearchThreshold) {
      onSearch();
    } else if (e.keyCode == dom.KeyCode.ENTER ||
        e.keyCode == dom.KeyCode.MAC_ENTER) {
      onSearch();
    }
  }

  void onSearch() {
    if (searchPhrase != null && searchPhrase.isNotEmpty) {
      bool find(FoModel model, List<String> keywords) {
        bool allKeywords;
        for (final keyword in keywords) {
          allKeywords = false;
          for (final col in columns) {
            final data = model[col]?.toString();
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

    setIndices(0);
  }

  void onSort(String column) {
    if (!disabled) {
      sortColumn = column;
      sortOrder = (sortOrder == 'ASC') ? 'DESC' : 'ASC';

      searchPhrase = null;
      _filteredKeys = null;

      if (internalSort || evaluatedColumns.containsKey(column))

      /// Evaluated columns are always sorted internally {
      if (sortOrder != null && sortColumn != null && sortColumn.isNotEmpty) {
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
            values.sort((a, b) =>
                sort(a[sortColumn].toString(), b[sortColumn].toString()));
          else if (evaluatedColumns.containsKey(sortColumn))
            values.sort((a, b) => sort(evaluatedColumns[sortColumn](a),
                evaluatedColumns[sortColumn](b)));
          _filteredKeys = values.map((model) => model['id']);
        }
      }
    } else
      _onSortController.add({'column': sortColumn, 'order': sortOrder});
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

        final properties = columns.map((col) => model[col].toString()).toList()
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
    if (inFirstIndex <= -_selectedRowOption.count ||
        inFirstIndex >= data.length) return;

    firstIndex = max(0, inFirstIndex);
    if (searchPhrase != null && searchPhrase.isNotEmpty)
      firstIndex = max(
          0, min(firstIndex, filteredKeys.length - _selectedRowOption.count));
    lastIndex = firstIndex + _selectedRowOption.count;

    currentPage = (data.isEmpty)
        ? 0
        : (firstIndex.toDouble() / _selectedRowOption.count).ceil() + 1;
  }

  int get totalPages =>
      (filteredKeys.length.toDouble() / _selectedRowOption.count).ceil();

  final List<RowOption> rowOptions = [
    new RowOption('5', 5),
    new RowOption('10', 10),
    new RowOption('15', 15),
    new RowOption('20', 20),
    new RowOption('25', 25),
    new RowOption('50', 50),
    new RowOption('100', 100),
  ];

  void onCheckedChange(String id, bool state) {
    if (state)
      selectedRows.add(id);
    else
      selectedRows.remove(id);
    onSelectedRowsController.add(selectedRows);
  }

  void onBatchOperationTrigger(String event) {
    _onBatchOperationController
        .add(new BatchOperationEvent(event, selectedRows));
  }

  void onAllCheckedChange(bool state) {
    if (state == true)
      selectedRows = filteredKeys.toSet();
    else
      selectedRows.clear();
  }

  void _evaluateLayout() {
    final dom.DivElement container = tableContainer.nativeElement;
    final dom.TableElement table = container.querySelector('table');

    table.classes.remove('fixed-layout');
    if (container.getBoundingClientRect().width <
        table.getBoundingClientRect().width) {
      table.classes.add('fixed-layout');
    }
  }

  String get filterLabel =>
      (data == null || (data.length < liveSearchThreshold))
          ? 'filter'
          : 'filter_enter';

  Iterable<String> get filteredKeys =>
      _filteredKeys == null ? data.keys : _filteredKeys;

  String get selectedRowOptionId => _selectedRowOption?.id;

  set selectedRowOptionId(String value) {
    _selectedRowOption = rowOptions.firstWhere((row) => row.id == value,
        orElse: () => rowOptions.first);
  }

  RowOption _selectedRowOption;
  String deleteBufferId;
  int firstIndex = 0;
  int lastIndex = 1;
  int currentPage = 1;
  String searchPhrase = '';
  Iterable<String> _filteredKeys;
  bool infoModalOpen = false;

  StreamSubscription _onWindowResizeListener;
  final int liveSearchThreshold = 500;
  final PhraseService phraseService;
  final StreamController<String> onAddController = new StreamController();
  final StreamController<Set<String>> onSelectedRowsController =
      new StreamController();
  final StreamController<String> onDeleteController = new StreamController();
  final StreamController<String> onRowClickController = new StreamController();
  final StreamController<Map<String, String>> _onSortController =
      new StreamController();
  final StreamController<BatchOperationEvent> _onBatchOperationController =
      new StreamController();

  @ViewChild('tableContainer')
  ElementRef tableContainer;

  @Input()
  bool internalSort = true;

  @Input('large-hidden-col')
  List<String> largeHiddenCol = [];

  @Input('small-hidden-col')
  List<String> smallHiddenCol = [];

  @Input('medium-hidden-col')
  List<String> mediumHiddenCol = [];

  @Input()
  String sortColumn = '';

  @Input()
  String sortOrder = 'DESC';

  @Input()
  Map<String, FoModel> data = {};

  @Input()
  List<String> columns = [];

  @Input()
  Map<String, EvaluateColumnFn> evaluatedColumns = {};

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
  Set<String> selectedRows = new Set();

  @Input()
  int rows = 10;

  @Input()
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
  Stream<BatchOperationEvent> get onBatchOperationOutput =>
      _onBatchOperationController.stream;
}

/// RowOption is a model used in the FoDataTable to represent how many rows should be displayed at once
class RowOption extends FoModel {
  /// Default constructor
  RowOption(String id, this.count)
  {
    super.id = id;
  }

  @override
  Map<String, dynamic> toJson() => {'id': id, 'count': count};

  @override
  String toString() => count.toString();

  /// The number of rows to display
  final int count;
}

/// Batch Operation Event, spawned as output whenever the user performs a batch action on the table
class BatchOperationEvent {
  /// Default constructor
  BatchOperationEvent(this.operation, this.selectedIds);

  /// The operation name
  final String operation;

  /// Selected ids whenever the user invoked batch operation
  final Set<String> selectedIds;
}
