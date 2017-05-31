// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/data_table_model.dart';

@Component(
    selector: 'fo-multi-select',
    styleUrls: const ['fo_multi_select_component.css'],
    templateUrl: 'fo_multi_select_component.html',
    directives: const [materialDirectives]
)
class FoMultiSelectComponent implements OnDestroy
{
  FoMultiSelectComponent()
  {
    selectionModel.selectionChanges.listen((List<SelectionChangeRecord<DataTableModel>> e)
    {
      if (e.isEmpty) return;

      visible = !closeOnSelect;

      /// Value changed
      if (e.first.added.isNotEmpty || e.first.removed.isNotEmpty) _onSelectedModelsChangeController.add(selectionModel.selectedValues.toList(growable: false));
    });
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedModelsChangeController.close();
  }

  String get selectedValues
  => selectionModel.selectedValues.isEmpty ? nullSelectionButtonText : selectionModel.selectedValues.map((d) => d.toString()).join(", ");

  bool get visible => _visible;

  bool _visible = false;
  SelectionOptions<DataTableModel> selectionOptions;
  SelectionModel<DataTableModel> selectionModel = new SelectionModel.withList(allowMulti: true);
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<List<DataTableModel>> _onSelectedModelsChangeController = new StreamController();

  @Input('closeOnSelect')
  bool closeOnSelect = true;

  @Input('label')
  String label = "";

  @Input('nullSelectionButtonText')
  String nullSelectionButtonText = "-";

  @Input('options')
  void set options(List<DataTableModel> value)
  {
    if (value == null)
    {
      selectionOptions = null;
      return;
    }

    /// else
    selectionOptions = new SelectionOptions<DataTableModel>([new OptionGroup(value)]);

    /// Update selection based on current options (de-select any values not contained in options)
    List<DataTableModel> invalid = selectionModel.selectedValues.where((v) => !selectionOptions.optionsList.contains(v)).toList(growable: false);
    invalid.forEach(selectionModel.deselect);
  }

  @Input('selectedModels')
  void set selectedModelsExternal(List<DataTableModel> value)
  {
    if (selectionOptions == null || value == null || value.isEmpty) selectionModel.clear();
    else for (DataTableModel model in value) selectionModel.select(selectionOptions.optionsList.firstWhere((e) => e == model));



    //_onSelectedModelsChangeController.add(value);
    _visible = false;
  }

  @Output('selectedModelsChange')
  Stream<List<DataTableModel>> get onSelectedModelsChangeOutput => _onSelectedModelsChangeController.stream;

  @Input('visible')
  void set visible(bool value) { _visible = value; }

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}
