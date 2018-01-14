// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController, StreamSubscription;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../pipes/phrase_pipe.dart';
import '../../model/fo_model.dart';
import '../../model/option_model.dart';
import '../../services/phrase_service.dart';

@Component(
    selector: 'fo-multi-select',
    styleUrls: const ['fo_multi_select_component.scss.css'],
    templateUrl: 'fo_multi_select_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives],
    pipes: const [PhrasePipe],
    changeDetection: ChangeDetectionStrategy.Default,
    visibility: Visibility.none
)
class FoMultiSelectComponent implements OnInit, OnChanges, OnDestroy
{
  FoMultiSelectComponent(this._phraseService);

  void ngOnInit()
  {
    /// Convert List<FoModel> to StringSelectionOptions<OptionModel>, and translate labels
    if (options != null)
    {
      Iterable<OptionModel> models = options.map((FoModel model) => new OptionModel(model.id, _phraseService.get(model.toString())));
      selectionOptions = new StringSelectionOptions(models.toList(growable: false), shouldSort: true);
    }
    /*
    if (selectedIds != null)
    {
      for (String id in selectedIds)
      {
        OptionModel model = selectionOptions.optionsList.firstWhere((m) => m.id == id, orElse: () => null);
        if (model != null) selectionModel.select(model);
      }
    }
    */
    if (_selectionChangeListener == null)
    {
      _selectionChangeListener = selectionModel.selectionChanges.listen(_onSelectionChanges);
    }
  }

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("selectedIds"))
    {
      List<String> previous = changes["selectedIds"].previousValue;
      List<String> current = changes["selectedIds"].currentValue;

      /// List equality check, skip if equal contents
      if (previous == null || current != null || previous.length != current.length || previous.where(current.contains).length != current.length)
      {
        _selectionChangeListener?.cancel();
        selectionModel.clear();
        if (selectedIds != null)
        {
          for (String id in selectedIds)
          {
            OptionModel model = selectionOptions.optionsList.firstWhere((m) => m.id == id, orElse: () => null);
            if (model != null) selectionModel.select(model);
          }
        }
        _selectionChangeListener = selectionModel.selectionChanges.listen(_onSelectionChanges);
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
    /*
    OptionModel sourceModel = selectedModels.elementAt(event.sourceIndex);
    selectedModels.removeAt(event.sourceIndex);
    selectedModels.insert(event.destIndex, sourceModel);
    selectedIds = selectedModels.map((model) => model['id']).toList();

    selectionModel.clear();
    selectedModels.forEach(selectionModel.select);
    */
  }

  void _onSelectionChanges(List<SelectionChangeRecord<OptionModel>> e)
  {
    _onSelectedIdsChangeController.add((e.isEmpty) ? [] : selectionModel.selectedValues.map((model) => model.id).toList());
  }

  SelectionModel<OptionModel> selectionModel = new SelectionModel.withList(allowMulti: true);
  StringSelectionOptions<OptionModel> selectionOptions = new StringSelectionOptions<OptionModel>([]);
  final PhraseService _phraseService;
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<List<String>> _onSelectedIdsChangeController = new StreamController();
  StreamSubscription<List<SelectionChangeRecord<OptionModel>>> _selectionChangeListener;

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

  /// Warning: options cannot change during runtime
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
