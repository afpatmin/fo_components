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
    directives: const [materialDirectives],
    changeDetection: ChangeDetectionStrategy.OnPush
)
class FoSelectComponent implements AfterContentInit, OnChanges, OnDestroy
{
  FoSelectComponent()
  {
    _selectionChangeListener = selectionModel.selectionChanges.listen(_onSelectionChanges);
  }

  void ngAfterContentInit()
  {
    if (selectedModel != null) selectedId = selectedModel.id;
    if (selectedId != null)
    {
      selectedModel = selectionOptions.optionsList.firstWhere((m) => m.id.compareTo(selectedId) == 0, orElse: () => null);
    }
  }


  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("options") && selectedModel != null && !selectionOptions.optionsList.contains(selectedModel))
    {
      if (selectedModel != null && !selectionOptions.optionsList.contains(selectedModel) && selectionOptions.isNotEmpty)
      {
        selectionModel.select(selectionOptions.optionsList.first);
      }
      else if (allowNullSelection) selectionModel.clear();
    }
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedModelChangeController.close();
    _onSelectedIdChangeController.close();
    _selectionChangeListener.cancel();
  }

  void _onSelectionChanges(List<SelectionChangeRecord<DataTableModel>> e)
  {
    if (e.isEmpty) return;

    if (allowNullSelection)
    {
      if (e.first.added.isEmpty) selectedModel = selectedId = null;
      else
      {
        selectedModel = e.first.added.first;
        selectedId = selectedModel.id;
      }
    }
    else if (!allowNullSelection && e.first.added.isNotEmpty)
    {
      selectedModel = e.first.added.first;
      selectedId = selectedModel.id;
    }

    _onSelectedModelChangeController.add(selectedModel);
    _onSelectedIdChangeController.add(selectedId);
  }

  SelectionOptions<DataTableModel> selectionOptions = new SelectionOptions<DataTableModel>([]);
  SelectionModel<DataTableModel> selectionModel = new SelectionModel.withList(allowMulti: false);
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<DataTableModel> _onSelectedModelChangeController = new StreamController();
  final StreamController<String> _onSelectedIdChangeController = new StreamController();
  StreamSubscription<List<SelectionChangeRecord<DataTableModel>>> _selectionChangeListener;

  @Input('allowNullSelection')
  bool allowNullSelection = false;

  @Input('label')
  String label = "";

  @Input('nullSelectionButtonText')
  String nullSelectionButtonText = "-";

  @Input('fullWidth')
  bool fullWidth = false;

  @Input('options')
  void set options(List<DataTableModel> value) { selectionOptions = new SelectionOptions<DataTableModel>([new OptionGroup(value)]); }

  @Input('selectedId')
  String selectedId;

  @Input('selectedModel')
  DataTableModel selectedModel;

  @Input('visible')
  bool visible = false;

  @Output('selectedIdChange')
  Stream<String> get onSelectedIdChangeOutput => _onSelectedIdChangeController.stream;

  @Output('selectedModelChange')
  Stream<DataTableModel> get onSelectedModelChangeOutput => _onSelectedModelChangeController.stream;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}
