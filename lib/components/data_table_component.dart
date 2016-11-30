// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library data_table_component;

import 'package:angular2/core.dart';
import 'package:fo_components/pipes/map_to_keys_pipe.dart';
import 'package:fo_components/pipes/map_to_values_pipe.dart';


@Component(
    selector: 'fo-data-table',
    styleUrls: const ['style/data_table_component.css'],
    templateUrl: 'html/data_table_component.html',
    preserveWhitespace: false,
    pipes: const [MapToKeysPipe, MapToValuesPipe])

class DataTableComponent extends ComponentState
{
  DataTableComponent();


  @Input()
  void set data(List<Map<String, String>> value)
  {
    setState(() => _data = value);
  }

  void onRowSelect(Map<String, String> data)
  {
    setState(()
    {
      _selectedRow = data;
      foRowClick.emit(data);
    });
  }

  @Output()
  final EventEmitter<String> foCellClick = new EventEmitter();

  @Output()
  final EventEmitter<Map<String, String>> foRowClick = new EventEmitter();

  Map<String, String> get selectedRow => _selectedRow;
  Map<String, String> _selectedRow;

  List<Map<String, String>> get data =>  _data;
  List<Map<String, String>> _data;
}
