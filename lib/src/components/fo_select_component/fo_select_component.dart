// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../fo_modal_component/fo_modal_component.dart';
import '../../models/fo_model.dart';
import '../../pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-select',
    styleUrls: const ['fo_select_component.scss.css'],
    templateUrl: 'fo_select_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives, FoModalComponent],
    pipes: const [PhrasePipe],
    changeDetection: ChangeDetectionStrategy.OnPush
)
class FoSelectComponent implements OnChanges, OnDestroy
{
  FoSelectComponent()
  {
    _selectionChangeListener = selectionModel.selectionChanges.listen(_onSelectionChanges);
  }

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("selectedModel")) selectedId = selectedModel?.id;
    else if (changes.containsKey("selectedId"))
    {
      selectedModel = (selectedId == null) ? null : options.optionsList.firstWhere((m) => m.id == selectedId, orElse: () => null);
    }
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedIdChangeController.close();
    _onSelectedModelChangeController.close();
    _selectionChangeListener.cancel();
  }

  void setVisible(bool flag)
  {
    if (!disabled) visible = flag;
  }

  void _onSelectionChanges(List<SelectionChangeRecord<FoModel>> e)
  {
    if (e.isEmpty) return;
    if (e.first.added.isNotEmpty)
    {
      selectedModel = e.first.added.first;
      selectedId = selectedModel.id;
    }
    _onSelectedIdChangeController.add(selectedModel?.id);
    _onSelectedModelChangeController.add(selectedModel);
  }

  void clearSelection()
  {
    selectionModel.clear();
    selectedModel = null;
    selectedId = null;
    _onSelectedModelChangeController.add(null);
    _onSelectedIdChangeController.add(null);
  }

  SelectionModel<FoModel> selectionModel = new SelectionModel.withList(allowMulti: false);
  StreamSubscription<List<SelectionChangeRecord<FoModel>>> _selectionChangeListener;
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<String> _onSelectedIdChangeController = new StreamController();
  final StreamController<FoModel> _onSelectedModelChangeController = new StreamController();

  bool tooltipModalVisible = false;

  @Input('allowNullSelection')
  bool allowNullSelection = false;

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
  String selectedId;

  @Input('selectedModel')
  FoModel selectedModel;

  @Input('showSearch')
  bool showSearch = false;

  @Input('tooltip')
  String tooltip;

  @Input('visible')
  bool visible = false;

  @Output('selectedIdChange')
  Stream<String> get onSelectedIdChangeOutput => _onSelectedIdChangeController.stream;

  @Output('selectedModelChange')
  Stream<FoModel> get onSelectedModelChangeOutput => _onSelectedModelChangeController.stream;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}

class NullSelection extends FoModel
{
  NullSelection([this._label = "-"]) : super(null);

  @override
  String toString() => _label;

  final String _label;
}