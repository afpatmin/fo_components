// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController, StreamSubscription;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/fo_components.dart' show FoModel, PhrasePipe;

@Component(
    selector: 'fo-multi-select',
    styleUrls: const ['fo_multi_select_component.css'],
    templateUrl: 'fo_multi_select_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives],
    pipes: const [PhrasePipe],
    changeDetection: ChangeDetectionStrategy.OnPush
)
class FoMultiSelectComponent implements OnChanges, OnDestroy
{
  FoMultiSelectComponent()
  {
    _selectionChangeListener = selectionModel.selectionChanges.listen((List<SelectionChangeRecord<FoModel>> e)
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
      _selectionChangeListener = selectionModel.selectionChanges.listen((List<SelectionChangeRecord<FoModel>> e)
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

  SelectionModel<FoModel> selectionModel = new SelectionModel.withList(allowMulti: true);
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<List<FoModel>> _onSelectedModelsChangeController = new StreamController();
  StreamSubscription<List<SelectionChangeRecord<FoModel>>> _selectionChangeListener;

  @Input('label')
  String label = "";

  @Input('nullSelectionButtonText')
  String nullSelectionButtonText = "-";

  @Input('options')
  StringSelectionOptions<FoModel> options = new StringSelectionOptions([]);

  @Input('selectedModels')
  List<FoModel> selectedModels;

  @Input('showSearch')
  bool showSearch = false;

  @Input('visible')
  bool visible = false;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;

  @Output('selectedModelsChange')
  Stream<List<FoModel>> get onSelectedModelsChangeOutput => _onSelectedModelsChangeController.stream;

}
