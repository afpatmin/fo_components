// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../pipes/phrase_pipe.dart';
import '../../models/fo_model.dart';

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
  FoMultiSelectComponent();

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("options") && options != null)
    {
      var prev = changes["options"].previousValue;
      var cur = changes["options"].currentValue;

      /// List equality check, skip if equal contents
      if (prev == null || cur == null || prev.length != cur.length || prev.where(cur.contains).length != cur.length)
      {
        /// Convert List<FoModel> to StringSelectionOptions<FoModel>
        selectionOptions = new StringSelectionOptions(options.toList(growable: false), shouldSort: true);
      }
    }
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedIdsChangeController.close();
  }


  void onReorder(ReorderEvent event)
  {
    /*
    OptionModel sourceModel = selectedModels.elementAt(event.sourceIndex);
    selectedModels.removeAt(event.sourceIndex);
    selectedModels.insert(event.destIndex, sourceModel);
    selectedIds = selectedModels.map((model) => model['id']).toList();

    selectionModel.clear();
    selectedModels.forEach(selectionModel.select);
    */
  }

  void onToggle(String id, bool status)
  {
    try
    {
      if (status == true)
      {
        selectedIds.add(id);
      }
      else
      {
        selectedIds.remove(id);
      }
      _onSelectedIdsChangeController.add(selectedIds);
    }
    on UnsupportedError catch (e)
    {
      print(e.toString());
      selectedIds = new List.from(selectedIds, growable: true);
      onToggle(id, status);
    }
  }

  FoModel getModel(String id) => selectionOptions.optionsList.firstWhere((model) => model.id == id, orElse: () => null);

  StringSelectionOptions<FoModel> selectionOptions = new StringSelectionOptions([]);
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<List<String>> _onSelectedIdsChangeController = new StreamController();

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
  Iterable<FoModel> options;

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
