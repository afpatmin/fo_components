// Copyright (c) 2017, Minoch AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html' as dom;
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_components/material_checkbox/material_checkbox.dart';
import 'package:angular_components/material_spinner/material_spinner.dart';
import 'package:angular_components/material_tooltip/material_tooltip.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import '../../pipes/capitalize_pipe.dart';
import '../../pipes/range_pipe.dart';
import '../fo_button/fo_button_component.dart';
import '../fo_dropdown_list/fo_dropdown_option.dart';
import '../fo_dropdown_select/fo_dropdown_select_component.dart';
import '../fo_icon/fo_icon_component.dart';
import '../fo_modal/fo_modal_component.dart';
import '../fo_text_input/fo_text_input_component.dart';

typedef ErrorFn = String Function(Object model);

/// Callback function for evaluated columns
typedef EvaluateColumnFn = Object Function(Object model);

/// Batch Operation Event, spawned as output whenever the user performs a batch action on the table
class BatchOperationEvent {
  /// The operation name
  final String operation;

  /// Selected ids whenever the user invoked batch operation
  final Set<Object> selectedIds;

  /// Default constructor
  BatchOperationEvent(this.operation, this.selectedIds);
}

@Component(
    selector: 'fo-data-table',
    styleUrls: ['fo_data_table_component.css'],
    templateUrl: 'fo_data_table_component.html',
    directives: <dynamic>[
      coreDirectives,
      FoButtonComponent,
      FoDropdownSelectComponent,
      FoModalComponent,
      formDirectives,
      FoTextInputComponent,
      MaterialCheckboxComponent,
      FoIconComponent,
      MaterialSpinnerComponent,
      MaterialTooltipDirective
    ],
    pipes: [CapitalizePipe, RangePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoDataTableComponent implements AfterChanges, OnDestroy {
  final Function eq = const ListEquality().equals;

  final String msgFilter = Intl.message('filter', name: 'filter');
  final String msgNoResultsFound =
      Intl.message('no results found', name: 'no_results_found');
  final String msgDownloadCsv =
      Intl.message('download .CSV file', name: 'download_csv');
  final String msgAdd = Intl.message('add', name: 'add');
  final String msgGo = Intl.message('go', name: 'go');
  final String msgRows =
      Intl.plural(2, one: 'row', other: 'rows', args: [2], name: 'row');
  final String msgPage =
      Intl.plural(1, one: 'page', other: 'pages', args: [1], name: 'page');
  final String msgWithSeleced =
      Intl.message('with selected', name: 'with_selected');
  final String msgConfirm = Intl.message('confirm', name: 'confirm');
  final String msgConfirmDeleteResource = Intl.message(
      'Are you sure you want to delete this resource?',
      name: 'confirm_delete_resource');
  final String msgOk = Intl.message('ok', name: 'ok');
  final String msgCancel = Intl.message('cancel', name: 'cancel');
  final String msgInformation =
      Intl.message('information', name: 'information');

  final Map<String, List<FoDropdownOption>> rowOptions = {
    '': [
      FoDropdownOption()
        ..id = 5
        ..label = '5',
      FoDropdownOption()
        ..id = 10
        ..label = '10',
      FoDropdownOption()
        ..id = 15
        ..label = '15',
      FoDropdownOption()
        ..id = 20
        ..label = '20',
      FoDropdownOption()
        ..id = 25
        ..label = '25',
      FoDropdownOption()
        ..id = 50
        ..label = '50',
      FoDropdownOption()
        ..id = 100
        ..label = '100',
      FoDropdownOption()
        ..id = 1000
        ..label = '1000'
    ]
  };

  int selectedRowId;
  Object deleteBufferId;
  int firstIndex = 0;
  int lastIndex = 1;
  int currentPage = 1;
  String searchPhrase = '';
  List<Object> _filteredKeys;
  bool infoModalOpen = false;
  bool _allChecked;
  final int liveSearchThreshold = 500;

  int _rows = 10;
  bool _rowsChanged = false;  

  final StreamController<String> onAddController = StreamController();

  final StreamController<Set<Object>> onSelectedRowsController =
      StreamController();

  final StreamController<Object> onDeleteController = StreamController();

  final StreamController<String> _onFilterController = StreamController();

  final StreamController<Object> onRowClickController = StreamController();

  final StreamController<Map<String, dynamic>> _onSortController =
      StreamController();

  final StreamController<BatchOperationEvent> _onBatchOperationController =
      StreamController();

  final Map<Object, Map<String, Object>> _evaluatedColumnsBuffer = {};

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  @Input()
  bool internalSort = true;

  @Input()
  bool internalFilter = true;

  @Input()
  String sortColumn = '';

  @Input()
  String sortOrder = 'DESC';

  @Input()
  Map<Object, Object> data = {};

  @Input()
  Map<String, String> columns = {};

  @Input()
  Map<String, EvaluateColumnFn> evaluatedColumns = {};

  @Input()
  ErrorFn errorFunction;

  @Input()
  bool showAddButton = false;

  @Input()
  bool showCheckboxes = false;

  @Input()
  Map<String, List<FoDropdownOption>> batchOperations;

  @Input()
  bool showDeleteButtons = false;

  @Input()
  bool showDownloadButton = true;

  @Input()
  String label = '';

  @Input()
  String description;

  @Input()
  Set<Object> selectedRows = {};

  @Input()
  bool disabled = false;

  String selectedBatchOperation;

  FoDataTableComponent() {
    selectedRowId = rowOptions[''].first.id;
  }

  bool get allChecked => _allChecked;
  set allChecked(bool state) {
    _allChecked = state;
    if (_allChecked)
      selectedRows = filteredKeys
          .where((o) => errorFunction == null || errorFunction(data[o]) == null)
          .toSet();
    else
      selectedRows.clear();
  }

  List<Object> get filteredKeys =>
      _filteredKeys == null ? data.keys.toList() : _filteredKeys;

  bool get lazyFilter =>
      data == null || !internalFilter || data.length > liveSearchThreshold;

  @Output('add')
  Stream<String> get onAddOutput => onAddController.stream;

  @Output('batchOperation')
  Stream<BatchOperationEvent> get onBatchOperationOutput =>
      _onBatchOperationController.stream;

  @Output('delete')
  Stream<Object> get onDeleteOutput => onDeleteController.stream;

  @Output('filter')
  Stream<String> get onFilterOutput => _onFilterController.stream;

  @Output('rowclick')
  Stream<Object> get onRowClickOutput => onRowClickController.stream;

  @Output('sort')
  Stream<Map<String, dynamic>> get onSortOutput => _onSortController.stream;

  int get rows => _rows;

  @Input('rows')
  set rows(int value) {
    _rows = value;
    _rowsChanged = true;
  }

  @Output('selectedRowsChange')
  Stream<Set<Object>> get selectedRowsChange => onSelectedRowsController.stream;

  int get totalPages => (filteredKeys.length.toDouble() / selectedRowId).ceil();

  dynamic getCell(Object id, String column) {
    if (data == null || data[id] == null)
      return null;
    else {
      final model = data[id];
      final encoded = json.decode(json.encode(model));
      final cell = encoded[column];
      if (cell == null) return null;

      if (cell is String) {
        try {
          final date = DateTime.parse(cell).toLocal();
          // only format date if reasonable date
          return (date.year > 1900 && date.year < 2100)
              ? dateFormat.format(date)
              : cell;
        } on FormatException {
          return cell;
        }
      } else {
        return cell;
      }
    }
  }

  Object getEvaluatedColumn(Object row, String col) {
    if (_evaluatedColumnsBuffer[row] == null) {
      _evaluatedColumnsBuffer[row] = {};
    }

    if (_evaluatedColumnsBuffer[row][col] == null) {
      if (evaluatedColumns.containsKey(col)) {
        _evaluatedColumnsBuffer[row][col] = evaluatedColumns[col](data[row]);
      } else {
        _evaluatedColumnsBuffer[row][col] = null;
      }
    }
    return _evaluatedColumnsBuffer[row][col];
  }

  bool isBool(Object value) => value is bool;

  @override
  void ngAfterChanges() {
    _evaluatedColumnsBuffer.clear();
    data ??= {};

    if (_rowsChanged == true) {
      selectedRowId = rows;
      firstIndex = 0;
      lastIndex = selectedRowId;
      _rowsChanged = false;
    }
    if (_filteredKeys == null || !eq(data.keys.toList(), filteredKeys)) {
      _filteredKeys = List.from(data.keys);

      // Buffer sortproperties because they are cleared onSearch()
      final bufferSortColumn = sortColumn;
      final bufferSortOrder = sortOrder;

      if (internalFilter) {
        onFilter();
      }
      if (internalSort) {
        onSort(bufferSortColumn, bufferSortOrder);
      }
      if (filteredKeys.length < lastIndex) {
        setIndices(0);
      }
    }
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
  }

  void onActionButtonTrigger() {
    _onBatchOperationController
        .add(BatchOperationEvent(selectedBatchOperation, selectedRows.toSet()));
  }

  void onBatchOperationTrigger(String event) {
    _onBatchOperationController
        .add(BatchOperationEvent(event, Set.from(selectedRows)));

    allChecked = false;
  }

  void onCheckedChange(Object id, bool state) {
    if (state)
      selectedRows.add(id);
    else
      selectedRows.remove(id);
    onSelectedRowsController.add(selectedRows);
  }

  void onDeleteRow(Object key, dom.Event event) {
    if (disabled == false) {
      deleteBufferId = key;
    }
    event.stopPropagation();
  }

  void onDownloadDataCSV() {
    if (data.isNotEmpty) {
      /// Generate CSV string (Property1;Property2;Property3;Property4;Property5\n)
      final sb = StringBuffer();

      final colNames = List.from(columns.keys)..addAll(evaluatedColumns.keys);
      sb.writeln(colNames);

      for (final key in filteredKeys) {
        final model = data[key];
        if (model == null) continue;

        final row = json.decode(json.encode(model));
        final properties = columns.keys.map((col) => row[col]).toList()
          ..addAll(
              evaluatedColumns.keys.map((id) => evaluatedColumns[id](model)));

        /// Add "'"-character if ¨the cell has a leading '0'-character. This will stop Excel from skipping leading 0
        for (var property in properties) {
          try {
            var strProperty = property.toString();
            num.parse(strProperty);
            if (strProperty.startsWith('0')) {
              strProperty = '="$strProperty"';
            }
          } on FormatException {
            /* Not a number, continue */
          }
        }

        sb.writeln(properties.join(';'));
      }

      final csv = Uri.encodeComponent(sb.toString());

      /* UTF-8 BOM */
      dom.AnchorElement(href: 'data:text/csv;charset=utf-8,\uFEFF$csv')
        ..setAttribute('download', 'data.csv')
        ..click();
    }
  }

  void onFilter() {
    if (internalFilter && searchPhrase?.isNotEmpty == true) {
      bool find(Object key, Object model, List<String> keywords) {
        bool allKeywords;
        final row = json.decode(json.encode(model));
        for (final keyword in keywords) {
          allKeywords = false;
          for (final col in columns.keys) {
            final data = row[col]?.toString();
            if (data != null &&
                data.toString().toLowerCase().contains(keyword)) {
              allKeywords = true;
              break;
            }
          }
          for (final col in evaluatedColumns.keys) {
            final r = _evaluatedColumnsBuffer[key];

            final data = (r?.containsKey(col) == true) ? r[col] : null;
            if (data != null &&
                data.toString().toLowerCase().contains(keyword)) {
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

      sortColumn = null;
      sortOrder = null;

      _filteredKeys =
          data.keys.where((key) => find(key, data[key], keywords)).toList();
    } else
      _filteredKeys = null;

    _onFilterController.add(searchPhrase);
    setIndices(0);
  }

  void onFilterChange() {
    if (lazyFilter) {
      onFilter();
    }
  }

  void onFilterKeyUp(dom.KeyboardEvent e) {
    if (!lazyFilter) {
      onFilter();
    }
  }

  void onRowClick(Object event) {
    if (!disabled) {
      onRowClickController.add(event);
    }
  }

  Iterable<Object> onSort(String column, [String sort_order]) {
    if (column != null && (!disabled || internalSort)) {
      sortColumn = column;

      if (sort_order == null) {
        sortOrder = (sortOrder == 'ASC') ? 'DESC' : 'ASC';
      } else {
        sortOrder = sort_order;
      }

      _onSortController.add({
        'column': sortColumn,
        'order': sortOrder,
        'internal': internalSort || evaluatedColumns.containsKey(column)
      });

      if (searchPhrase?.isEmpty == true) {
        _filteredKeys = null;
      }

      /// Evaluated columns are always sorted internally
      if (internalSort || evaluatedColumns.containsKey(column)) {
        int sort(Object a, Object b) {
          final vA = a == null ? '-' : a.toString();
          final vB = b == null ? '-' : b.toString();
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
              final colA = a.toString().toLowerCase();
              final colB = b.toString().toLowerCase();

              return (sortOrder == 'ASC')
                  ? colA.compareTo(colB)
                  : colB.compareTo(colA);
            }
          }
        }

        final values = filteredKeys.map((key) => [key, data[key]]).toList();
        if (values != null) {
          if (columns.keys.contains(sortColumn)) {
            values.sort((a, b) => sort(
                json.decode(json.encode(a[1]))[sortColumn].toString(),
                json.decode(json.encode(b[1]))[sortColumn].toString()));
          } else if (evaluatedColumns.containsKey(sortColumn)) {
            values.sort((a, b) => sort(evaluatedColumns[sortColumn](a[1]),
                evaluatedColumns[sortColumn](b[1])));
          }

          _filteredKeys = values.map((row) => row[0]).toList();
        }
      }
    }
    return _filteredKeys;
  }

  void setIndices(int inFirstIndex) {
    if (inFirstIndex <= -selectedRowId || inFirstIndex >= data.length) return;

    firstIndex = max(0, inFirstIndex);
    if (searchPhrase != null && searchPhrase.isNotEmpty)
      firstIndex = max(0, min(firstIndex, filteredKeys.length - selectedRowId));
    lastIndex = firstIndex + selectedRowId;

    currentPage =
        (data.isEmpty) ? 0 : (firstIndex.toDouble() / selectedRowId).ceil() + 1;
  }

  void step(int steps) {
    if (!disabled) {
      setIndices(firstIndex + (steps * selectedRowId));
    }
  }
}
