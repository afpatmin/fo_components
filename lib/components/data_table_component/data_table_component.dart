// Copyright (c) 2017, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library data_table_component;
import 'dart:math';
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

class DataTableComponent extends ComponentState
{
  DataTableComponent();

  void step(int steps)
  {
    if (!_disabled && (firstIndex + _rows < _data.length || steps < 0))
    {
      _setIndices(firstIndex + (steps * _rows));
    }
  }

  void onSort(String column)
  {
    if (!_disabled)
    {
      sortColumn = column;
      sortOrder = (sortOrder == "ASC") ? "DESC" : "ASC";
      foSort.add({"column":sortColumn, "order":sortOrder});
    }
  }

  @Input('data')
  void set data(Map<String, Map<String, String>> value)
  {
    setState(()
    {
      _data = value;
      _setIndices(0);
    });
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
    setState(() => _disabled = flag);
  }

  @Output('cellclick')
  final EventEmitter<String> foCellClick = new EventEmitter();

  @Output('rowclick')
  final EventEmitter<String> foRowClick = new EventEmitter();

  @Output('sort')
  final EventEmitter<Map<String, String>> foSort = new EventEmitter();

  void _setIndices(int first_index)
  {
    setState(()
    {
      firstIndex = max(0, first_index);
      lastIndex = min(firstIndex + _rows, _data.length);
    });
  }

  bool get disabled => _disabled;
  int get rows => _rows;

  Map<String, Map<String, String>> get data => _data;
  Map<String, Map<String, String>> _data = new Map();

  String sortColumn = "";
  String sortOrder = "DESC";
  String searchPhrase = "";

  int firstIndex = 0;
  int lastIndex = 1;
  int _rows = 1;
  bool _disabled = false;
}