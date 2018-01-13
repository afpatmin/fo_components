// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../fo_modal_component/fo_modal_component.dart';
import '../../pipes/phrase_pipe.dart';
import '../../model/fo_model.dart';
import '../../model/option_model.dart';
import '../../services/phrase_service.dart';

@Component(
    selector: 'fo-select',
    styleUrls: const ['fo_select_component.scss.css'],
    templateUrl: 'fo_select_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives, FoModalComponent],
    pipes: const [PhrasePipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    visibility: Visibility.none
)
class FoSelectComponent implements OnChanges, OnDestroy
{
  FoSelectComponent(this._phraseService)
  {
    _selectionChangeListener = selectionModel.selectionChanges.listen(_onSelectionChanges);
  }

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    /***
     * Convert Input('options') List to StringSelectionOptions, and translate label
     */
    if (changes.containsKey("options"))
    {
      _selectionChangeListener.cancel();
      if (options == null) selectionOptions = new StringSelectionOptions([]);
      else
      {
        Iterable<OptionModel> models = options.map((FoModel model) => new OptionModel(model.id, _phraseService.get(model.toString())));
        selectionOptions = new StringSelectionOptions(models, shouldSort: true);
      }
      _selectionChangeListener = selectionModel.selectionChanges.listen(_onSelectionChanges);
    }
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedIdChangeController.close();
    onActionButtonTriggerController.close();
    _selectionChangeListener.cancel();
  }

  void setVisible(bool flag) => visible = (disabled) ? visible : flag;

  void _onSelectionChanges(List<SelectionChangeRecord<FoModel>> e)
  {
    // User deselected, skip this unless allowNullSelection
    if (e.isNotEmpty && e.first.removed.isNotEmpty && e.first.added.isEmpty && !allowNullSelection)
    {
      selectionModel.select(e.first.removed.first);
      return;
    }

    String id = selectionModel.selectedValues.isEmpty ? null : selectionModel.selectedValues.first.id;
    _onSelectedIdChangeController.add(id);
  }

  OptionModel get selectedModel => selectionModel.selectedValues.isEmpty ? null : selectionModel.selectedValues.first;

  StringSelectionOptions<OptionModel> selectionOptions = new StringSelectionOptions<OptionModel>([]);
  SelectionModel<OptionModel> selectionModel = new SelectionModel.withList(allowMulti: false);
  StreamSubscription<List<SelectionChangeRecord<OptionModel>>> _selectionChangeListener;
  final PhraseService _phraseService;
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<String> _onSelectedIdChangeController = new StreamController();
  final StreamController<String> onActionButtonTriggerController = new StreamController();

  bool tooltipModalVisible = false;

  @Input('actionButtonIcon')
  String actionButtonIcon;

  @Input('actionButtonText')
  String actionButtonText;

  @Input('allowNullSelection')
  bool allowNullSelection = false;

  @Input('componentRenderer')
  ComponentRenderer componentRenderer;

  @Input('nullSelectionButtonText')
  String nullSelectionButtonText = "-";

  @Input('label')
  String label = "";

  @Input('disabled')
  bool disabled = false;

  @Input('fullWidth')
  bool fullWidth = false;

  @Input('options')
  Iterable<FoModel> options;

  @Input('selectedId')
  void set selectedId(String value)
  {
    _selectionChangeListener.cancel();

    if (value == null) selectionModel.clear();
    else if (selectionOptions != null)
    {
      FoModel model = selectionOptions.optionsList.firstWhere(((model) => model.id == value), orElse: () => null);
      if (model == null) selectionModel.clear();
      else selectionModel.select(model);
    }
    _selectionChangeListener = selectionModel.selectionChanges.listen(_onSelectionChanges);
  }

  @Input('showActionButton')
  bool showActionButton = false;

  @Input('showSearch')
  bool showSearch = false;

  @Input('tooltip')
  String tooltip;

  @Input('visible')
  bool visible = false;

  @Output('selectedIdChange')
  Stream<String> get onSelectedIdChangeOutput => _onSelectedIdChangeController.stream;

  @Output('actionButtonTrigger')
  Stream<String> get onActionButtonTriggerOutput => onActionButtonTriggerController.stream;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}