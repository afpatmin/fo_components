// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController, StreamSubscription;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/data_table_model.dart';

@Component(
    selector: 'fo-select',
    styleUrls: const ['fo_select_component.css'],
    templateUrl: 'fo_select_component.html',
    directives: const [materialDirectives]
)
class FoSelectComponent implements AfterContentInit, OnDestroy
{
  FoSelectComponent();

  void ngAfterContentInit()
  {
    if (selectionOptions == null) return;

    if (selectedModel != null) selectedId = selectedModel.id;
    if (selectedId != null)
    {
      if (selectionOptions == null || selectionOptions.optionsList.isEmpty || selectedId == null) selectionModel.clear();
      else
      {
        selectedModel = selectionOptions.optionsList.firstWhere((model) => model.id == selectedId, orElse: () => null);
        selectionModel.select((selectedModel == null) ? selectionOptions.optionsList.first : selectedModel);
      }
    }
    selectionChangeListener = selectionModel.selectionChanges.listen(onSelectionChanges);
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedModelChangeController.close();
    _onSelectedIdChangeController.close();
    selectionChangeListener.cancel();
  }

  void onSelectionChanges(List<SelectionChangeRecord<DataTableModel>> e)
  {
    if (e.isEmpty) return;

    SelectionChangeRecord scr = e.first;

    if (allowNullSelection == false
        && scr.added.isEmpty
        && scr.removed.isNotEmpty
        && selectionOptions.optionsList.contains(scr.removed.first))
    {
      selectedModel = scr.removed.first;
      selectionChangeListener.cancel();
      selectionModel.select(selectedModel);
      selectionChangeListener = selectionModel.selectionChanges.listen(onSelectionChanges);
    }
    else if (scr.added.isNotEmpty)
    {
      selectedModel = scr.added.first;
      selectedId = selectedModel.id;
    }
    else if (allowNullSelection == true) selectedModel = selectedId = null;

    _onSelectedModelChangeController.add(selectedModel);
    _onSelectedIdChangeController.add(selectedId);
  }

  bool get visible => _visible;

  bool _visible = false;
  SelectionOptions<DataTableModel> selectionOptions;
  SelectionModel<DataTableModel> selectionModel = new SelectionModel.withList(allowMulti: false);
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<DataTableModel> _onSelectedModelChangeController = new StreamController();
  final StreamController<String> _onSelectedIdChangeController = new StreamController();
  StreamSubscription<List<SelectionChangeRecord<DataTableModel>>> selectionChangeListener;

  @Input('allowNullSelection')
  bool allowNullSelection = false;

  @Input('label')
  String label = "";

  @Input('nullSelectionButtonText')
  String nullSelectionButtonText = "-";

  @Input('options')
  void set options(List<DataTableModel> value) { selectionOptions = new SelectionOptions<DataTableModel>([new OptionGroup(value)]); }

  @Input('selectedId')
  String selectedId;

  @Input('selectedModel')
  DataTableModel selectedModel;

  @Output('selectedIdChange')
  Stream<String> get onSelectedIdChangeOutput => _onSelectedIdChangeController.stream;

  @Output('selectedModelChange')
  Stream<DataTableModel> get onSelectedModelChangeOutput => _onSelectedModelChangeController.stream;

  @Input('visible')
  void set visible(bool value) { _visible = value; }

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}
