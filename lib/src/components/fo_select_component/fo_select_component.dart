// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../fo_modal_component/fo_modal_component.dart';
import '../../pipes/phrase_pipe.dart';
import '../../model/fo_model.dart';

@Component(
    selector: 'fo-select',
    styleUrls: const ['fo_select_component.scss.css'],
    templateUrl: 'fo_select_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives, FoModalComponent],
    pipes: const [PhrasePipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    visibility: Visibility.none
)
class FoSelectComponent implements OnDestroy
{
  FoSelectComponent()
  {
    _selectionChangeListener = selectionModel.selectionChanges.listen(_onSelectionChanges);
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

  FoModel get selectedModel => selectionModel.selectedValues.isEmpty ? null : selectionModel.selectedValues.first;

  SelectionModel<FoModel> selectionModel = new SelectionModel.withList(allowMulti: false);
  StreamSubscription<List<SelectionChangeRecord<FoModel>>> _selectionChangeListener;
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<String> _onSelectedIdChangeController = new StreamController();
  final StreamController<FoModel> onActionButtonTriggerController = new StreamController();

  bool tooltipModalVisible = false;

  @Input('actionButtonIcon')
  String actionButtonIcon = "add";

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
  StringSelectionOptions<FoModel> options = new StringSelectionOptions<FoModel>([]);

  @Input('selectedId')
  void set selectedId(String value)
  {

    print("selectedId:$value");
    _selectionChangeListener.cancel();

    if (value == null) selectionModel.clear();
    else if (options != null)
    {
      FoModel model = options.optionsList.firstWhere(((model) => model.id == value), orElse: () => null);
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
  Stream<FoModel> get onActionButtonTriggerOutput => onActionButtonTriggerController.stream;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}