// Copyright (c) 2017, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library data_table_component;

import 'dart:async' show Stream, StreamController;
import 'dart:math';
import 'dart:collection' show LinkedHashMap;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/pipes/range_pipe.dart';
import 'package:fo_components/data_table_model.dart';

@Component(
    selector: 'fo-data-table',
    styleUrls: const ['data_table_component.css'],
    templateUrl: 'data_table_component.html',
    directives: const [materialDirectives],
    changeDetection: ChangeDetectionStrategy.Default,
    pipes: const [UpperCasePipe, RangePipe])

class DataTableComponent implements OnChanges, OnDestroy
{
  DataTableComponent();

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("rows"))
    {
      _setIndices(0);
    }

  }

  void ngOnDestroy()
  {
    onCellClickController.close();
    onRowClickController.close();
    _onSortController.close();
  }

  void step(int steps)
  {
    if (!disabled) _setIndices(firstIndex + (steps * rows));
  }

  void onSort(String column)
  {
    if (!disabled)
    {
      sortColumn = column;
      sortOrder = (sortOrder == "ASC") ? "DESC" : "ASC";
      _sort();
    }
  }

  Map<String, DataTableModel> get data => _data;

  List<String> get filteredKeys
  {
    bool find(List<String> needles, DataTableModel model)
    {
      for (String needle in needles.where((v) => v.isNotEmpty && v != ""))
      {
        if (model.toTableRow().values.where((v) => v != null && v.toLowerCase().contains(needle.toLowerCase())).isNotEmpty) return true;
      }
      return false;
    }

    if (searchPhrase.isEmpty) return data.keys.toList(growable: false);
    else
    {
      List<String> keywordList = searchPhrase.split(" ");
      return data.keys.where((key) => find(keywordList, data[key])).toList(growable: false);
    }
  }

  void _sort()
  {
    int sortFn(Map<String, String> a, Map<String, String> b, String column, String order)
    {
      if (a[column] == null) a[column] = "-";
      if (b[column] == null) b[column] = "-";

      try
      {
        // Number comparison
        num numA = num.parse(a[column]);
        num numB = num.parse(b[column]);
        return (order == "ASC") ? (numA - numB).toInt() : (numB - numA).toInt();
      }
      on FormatException
      {
        try
        {
          // Date comparison
          DateTime dateA = DateTime.parse(a[column]);
          DateTime dateB = DateTime.parse(b[column]);
          return (order == "ASC") ? (dateA.difference(dateB)).inMinutes : (dateB.difference(dateA)).inMinutes;
        }
        on FormatException
        {
          // Default String comparison
          return (order == "ASC") ? a[column].compareTo(b[column]) : b[column].compareTo(a[column]);
        }
      }
    }

    LinkedHashMap<String, DataTableModel> bufferMap = new LinkedHashMap();
    List<DataTableModel> values = _data.values.toList(growable: false);

    values.sort((DataTableModel a, DataTableModel b) => sortFn(a.toTableRow(), b.toTableRow(), sortColumn, sortOrder));

    for (DataTableModel value in values)
    {
      bufferMap[_data.keys.firstWhere((key) => _data[key] == value)] = value;
    }
    _data = bufferMap;

    _onSortController.add({"column":sortColumn, "order":sortOrder});
  }

  @Input('models')
  void set models(Map<String, DataTableModel> value)
  {
    _data = (value == null) ? new Map() : value;
    if (_data.isNotEmpty && _data.values.first.toTableRow().isNotEmpty)
    {
      _columns = _data.values.first.toTableRow().keys.toList(growable: false);
    }
    _setIndices(firstIndex);
    if (sortColumn.isNotEmpty) _sort();
  }

  void _setIndices(int first_index)
  {
    if (first_index < 0 || first_index >= _data.length) return;

    firstIndex = first_index;
    if (searchPhrase.isNotEmpty) firstIndex = max(0, min(firstIndex, filteredKeys.length - rows));
    lastIndex = firstIndex + rows;

    currentPage = (filteredKeys.isEmpty) ? 0 : (firstIndex.toDouble() / rows).ceil() + 1;
  }

  List<String> get columns => _columns;

  int get totalPages => (filteredKeys.length.toDouble() / rows).ceil();

  Map<String, DataTableModel> _data = new Map();
  int firstIndex = 0;
  int lastIndex = 1;
  int currentPage = 1;

  List<String> _columns = [];
  final StreamController<String> onCellClickController = new StreamController();
  final StreamController<String> onRowClickController = new StreamController();
  final StreamController<Map<String, String>> _onSortController = new StreamController();

  String sortColumn = "";
  String sortOrder = "DESC";
  String searchPhrase = "";

  @Input('no-results-message')
  String noResultsMessage = "No results found";

  @Input('large-hidden-columns')
  List<String> largeHiddenColumns = [];

  @Input('small-hidden-columns')
  List<String> smallHiddenColumns = [];

  @Input('medium-hidden-columns')
  List<String> mediumHiddenColumns = [];

  @Input('title')
  String title = "";

  @Input('page-title')
  String pageTitle = "page";

  @Input('rows')
  int rows = 1;

  @Input('disabled')
  bool disabled = false;

  @Output('cellclick')
  Stream<String> get onCellClickOutput => onCellClickController.stream;

  @Output('rowclick')
  Stream<String> get onRowClickOutput => onRowClickController.stream;

  @Output('sort')
  Stream<Map<String, String>> get onSortOutput => _onSortController.stream;
}