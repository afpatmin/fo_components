// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController, StreamSubscription;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-multi-select',
    styleUrls: const ['fo_multi_select_component.scss.css'],
    templateUrl: 'fo_multi_select_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives],
    pipes: const [PhrasePipe],
    changeDetection: ChangeDetectionStrategy.Default,
    visibility: Visibility.none
)
class FoMultiSelectComponent implements OnChanges, OnDestroy
{
  FoMultiSelectComponent()
  {
    _selectionChangeListener = selectionModel.selectionChanges.listen((List<SelectionChangeRecord<Map>> e)
    {
      _onSelectedIdsChangeController.add((e.isEmpty) ? [] : selectionModel.selectedValues.map((model) => model['id']).toList());
    });
  }

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("selectedModels"))
    {
      if (selectedModels == null || selectionModel.selectedValues.length == selectedModels.length) return;

      selectionModel.clear();
      selectedIds.clear();
      selectedModels.forEach(selectionModel.select);
      selectedIds = selectedModels.map((model) => model['id']).toList();
    }
    else if (changes.containsKey("selectedIds"))
    {
      if (selectedIds == null || selectionModel.selectedValues.length == selectedIds.length) return;

      selectionModel.clear();
      selectedModels.clear();
      for (String id in selectedIds)
      {
        Map model = options.optionsList.firstWhere((m) => m['id'] == id, orElse: () => null);
        if (model != null)
        {
          selectionModel.select(model);
          selectedModels.add(model);
        }
      }
    }
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedIdsChangeController.close();
    _selectionChangeListener?.cancel();
  }

  void onReorder(ReorderEvent event)
  {
    Map sourceModel = selectedModels.elementAt(event.sourceIndex);
    selectedModels.removeAt(event.sourceIndex);
    selectedModels.insert(event.destIndex, sourceModel);
    selectedIds = selectedModels.map((model) => model['id']).toList();

    selectionModel.clear();
    selectedModels.forEach(selectionModel.select);
  }

  SelectionModel<Map> selectionModel = new SelectionModel.withList(allowMulti: true);
  List<Map> selectedModels = new List();
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<List<String>> _onSelectedIdsChangeController = new StreamController();
  StreamSubscription<List<SelectionChangeRecord<Map>>> _selectionChangeListener;

  @Input('allowReorder')
  bool allowReorder = false;

  @Input('buttonText')
  String buttonText = 'select';

  @Input('disabled')
  bool disabled = false;

  @Input('fullWidth')
  bool fullWidth = false;

  @Input('label')
  String label = "";

  @Input('nullSelectionButtonText')
  String nullSelectionButtonText = "-";

  @Input('options')
  StringSelectionOptions<Map> options = new StringSelectionOptions([]);

  @Input('selectedIds')
  List<String> selectedIds = new List();

  @Input('showSearch')
  bool showSearch = false;

  @Input('visible')
  bool visible = false;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;

  @Output('selectedIdsChange')
  Stream<List<String>> get onSelectedIdsChangeOutput => _onSelectedIdsChangeController.stream;
}
