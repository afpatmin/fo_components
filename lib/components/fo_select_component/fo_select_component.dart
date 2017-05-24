// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/data_table_model.dart';

@Component(
    selector: 'fo-select',
    styleUrls: const ['fo_select_component.css'],
    templateUrl: 'fo_select_component.html',
    directives: const [materialDirectives]
)
class FoSelectComponent implements OnDestroy
{
  FoSelectComponent()
  {
    selectionModel.selectionChanges.listen((List<SelectionChangeRecord<DataTableModel>> e)
    {
      if (e.first.added.isEmpty) selectionModel.select(e.first.removed.first);
      else if (e.first.added.isNotEmpty && e.first.added != selectedModel)
      {
        _onSelectedModelChangeController.add(e.first.added.first);
      }
    });
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedModelChangeController.close();
  }

  DataTableModel get selectedModel
  {
    return selectionModel.selectedValues.isEmpty ? null : selectionModel.selectedValues.first;
  }

  bool get visible => _visible;

  bool _visible = false;
  SelectionOptions<DataTableModel> selectionOptions;
  SelectionModel<DataTableModel> selectionModel = new SelectionModel.withList(allowMulti: false);
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<DataTableModel> _onSelectedModelChangeController = new StreamController();

  @Input('label')
  String label = "";

  @Input('options')
  void set options(List<DataTableModel> value)
  {
    selectionOptions = new SelectionOptions<DataTableModel>([new OptionGroup(value)]);
  }

  @Input('selectedModel')
  void set selectedModelExternal(DataTableModel value)
  {
    if (selectionOptions != null)
    {
      if (value != null && selectionOptions.optionsList.contains(value)) selectionModel.select(value);
      else selectionModel.select(selectionOptions.optionsList.first);
    }
    else selectionModel.clear();
  }

  @Output('selectedModelChange')
  Stream<DataTableModel> get onSelectedModelChangeOutput => _onSelectedModelChangeController.stream;

  @Input('visible')
  void set visible(bool value) { _visible = value; }

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}
