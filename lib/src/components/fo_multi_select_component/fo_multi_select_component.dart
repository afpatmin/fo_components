// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController, StreamSubscription;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/src/models/data_table_model.dart';

@Component(
    selector: 'fo-multi-select',
    styleUrls: const ['fo_multi_select_component.css'],
    templateUrl: 'fo_multi_select_component.html',
    directives: const [materialDirectives],
    changeDetection: ChangeDetectionStrategy.OnPush
)
class FoMultiSelectComponent implements OnInit, OnChanges, OnDestroy
{
  FoMultiSelectComponent();

  void ngOnInit()
  {
    _selectionChangeListener = selectionModel.selectionChanges.listen((List<SelectionChangeRecord<DataTableModel>> e)
    {
      _onSelectedModelsChangeController.add((e.isEmpty) ? [] : selectionModel.selectedValues.toList(growable: false));
    });
  }

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("selectedModels"))
    {
      _selectionChangeListener?.cancel();
      selectedModels.forEach(selectionModel.select);
      _selectionChangeListener = selectionModel.selectionChanges.listen((List<SelectionChangeRecord<DataTableModel>> e)
      {
        _onSelectedModelsChangeController.add((e.isEmpty) ? [] : selectionModel.selectedValues.toList(growable: false));
      });
    }
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedModelsChangeController.close();
    _selectionChangeListener?.cancel();
  }

  String get selectedValues => selectionModel.selectedValues.isEmpty ? nullSelectionButtonText : selectionModel.selectedValues.map((d) => d.toString()).join(", ");

  bool get visible => _visible;

  bool _visible = false;
  SelectionOptions<DataTableModel> selectionOptions;
  SelectionModel<DataTableModel> selectionModel = new SelectionModel.withList(allowMulti: true);
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<List<DataTableModel>> _onSelectedModelsChangeController = new StreamController();
  StreamSubscription<List<SelectionChangeRecord<DataTableModel>>> _selectionChangeListener;

  @Input('closeOnSelect')
  bool closeOnSelect = true;

  @Input('label')
  String label = "";

  @Input('nullSelectionButtonText')
  String nullSelectionButtonText = "-";

  @Input('options')
  void set options(List<DataTableModel> value)
  {
    selectionOptions = (value == null) ? null : new SelectionOptions<DataTableModel>([new OptionGroup(value)]);
  }

  @Input('selectedModels')
  List<DataTableModel> selectedModels;

  @Output('selectedModelsChange')
  Stream<List<DataTableModel>> get onSelectedModelsChangeOutput => _onSelectedModelsChangeController.stream;

  @Input('visible')
  void set visible(bool value) { _visible = value; }

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}
