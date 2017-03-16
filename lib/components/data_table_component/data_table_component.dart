// Copyright (c) 2017, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library data_table_component;
import 'dart:math';
import 'dart:collection' show LinkedHashMap;
import 'package:angular2/core.dart';
import 'package:fo_components/components/icon_component/icon_component.dart';
import 'package:fo_components/pipes/range_pipe.dart';
import 'package:fo_components/pipes/uppercase_pipe.dart';

@Component(
    selector: 'fo-data-table',
    styleUrls: const ['data_table_component.css'],
    templateUrl: 'data_table_component.html',
    directives: const [IconComponent],
    providers: const [],
    preserveWhitespace: false,
    pipes: const [UppercasePipe, RangePipe])

class DataTableComponent
{
  DataTableComponent()
  {
    updateFilter();
  }

  void step(int steps)
  {
    if (!_disabled && (firstIndex + _rows < _data.length || steps < 0)) _setIndices(firstIndex + (steps * _rows));
  }

  void onSort(String column)
  {
    if (!_disabled)
    {
      sortColumn = column;
      sortOrder = (sortOrder == "ASC") ? "DESC" : "ASC";
      _sort();
    }
  }

  void updateFilter()
  {
    _filteredData.clear();
    if (searchPhrase.isEmpty) _filteredData = new Map.from(_data);
    else
    {
      List<String> keywordList = searchPhrase.split(" ");
      for (String key in _data.keys)
      {
        if (_find(keywordList, _data[key])) _filteredData[key] = _data[key];
      }
    }
  }

  void _sort()
  {
    int sortFn(Map<String, String> a, Map<String, String> b, String column, String order)
    {
      try
      {
        num numA = num.parse(a[column]);
        num numB = num.parse(b[column]);
        return (order == "ASC") ? (numA - numB).toInt() : (numB - numA).toInt();
      }
      on FormatException
      {
        return (order == "ASC") ? a[column].compareTo(b[column]) : b[column].compareTo(a[column]);
      }
    }

    LinkedHashMap<String, Map<String, String>> bufferMap = new LinkedHashMap();
    List<Map<String, String>> values = _filteredData.values.toList(growable: false);
    values.sort((Map<String, String> a, Map<String, String> b) => sortFn(a, b, sortColumn, sortOrder));

    for (Map<String, String> value in values)
    {
      bufferMap[_filteredData.keys.firstWhere((key) => _filteredData[key] == value)] = value;
    }
    _filteredData = bufferMap;

    foSort.add({"column":sortColumn, "order":sortOrder});
  }

  @Input('data')
  void set data(Map<String, Map<String, String>> value)
  {
    _data = (value == null) ? new Map() : value;
    _setIndices(firstIndex);
    updateFilter();
    if (sortColumn.isNotEmpty) _sort();
  }

  @Input('rows')
  void set rows(int value)
  {
    _rows = value;
    _setIndices(0);
  }

  @Input('disabled')
  void set disabled(bool flag)
  {
    _disabled = flag;
  }

  bool _find(List<String> needles, Map<String, String> haystack)
  {
    for (String needle in needles.where((v) => v.isNotEmpty && v != ""))
    {
      if (haystack.values.where((v) => v is String && v.toLowerCase().contains(needle.toLowerCase())).isNotEmpty) return true;
    }
    return false;
  }

  void _setIndices(int first_index)
  {
    firstIndex = max(0, first_index);
    lastIndex = firstIndex + _rows;
  }

  bool get disabled => _disabled;
  int get rows => _rows;

  @Output('cellclick')
  final EventEmitter<String> foCellClick = new EventEmitter();

  @Output('rowclick')
  final EventEmitter<String> foRowClick = new EventEmitter();

  @Output('sort')
  final EventEmitter<Map<String, String>> foSort = new EventEmitter();

  Map<String, Map<String, String>> _data = new Map();
  Map<String, Map<String, String>> _filteredData = new Map();
  Map<String, Map<String, String>> get filteredData => _filteredData;

  String sortColumn = "";
  String sortOrder = "DESC";
  String searchPhrase = "";

  int firstIndex = 0;
  int lastIndex = 1;
  int _rows = 1;
  bool _disabled = false;
}