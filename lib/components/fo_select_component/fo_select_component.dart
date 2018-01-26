// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../fo_modal_component/fo_modal_component.dart';
import '../../pipes/phrase_pipe.dart';
import '../../models/fo_model.dart';

@Component(
    selector: 'fo-select',
    styleUrls: const ['fo_select_component.scss.css'],
    templateUrl: 'fo_select_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives, FoModalComponent],
    pipes: const [PhrasePipe],
    visibility: Visibility.none
)
class FoSelectComponent implements OnChanges, OnDestroy
{
  FoSelectComponent();

  void onSelect(String id)
  {
    selectedId = id;
    _onSelectedIdChangeController.add(id);
  }

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("options"))
    {
      if (options == null) selectionOptions = new StringSelectionOptions([]);
      else
      {
        var prev = changes["options"].previousValue;
        var cur = changes["options"].currentValue;

        /// List equality check, skip if equal contents
        if (prev == null || cur == null || prev.length != cur.length || prev.where(cur.contains).length != cur.length)
        {
          /// Convert List<FoModel> to StringSelectionOptions<FoModel>
          selectionOptions = new StringSelectionOptions(options.toList(growable: false), shouldSort: sort);
        }
      }
    }
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedIdChangeController.close();
    onActionButtonTriggerController.close();
  }

  void setVisible(bool flag) => visible = (disabled) ? visible : flag;

  FoModel get selectedModel => selectionOptions.optionsList.firstWhere((o) => o.id == selectedId, orElse: () => null);

  StringSelectionOptions<FoModel> selectionOptions = new StringSelectionOptions<FoModel>([]);

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

  @Input('icon')
  bool icon = false;

  @Input('options')
  Iterable<FoModel> options = [];

  @Input('selectedId')
  String selectedId;

  @Input('showActionButton')
  bool showActionButton = false;

  @Input('showSearch')
  bool showSearch = false;

  @Input('sort')
  bool sort = true;

  @Input('tooltip')
  String tooltip;

  @Input('visible')
  bool visible = false;

  @Output('selectedIdChange')
  Stream<String> get onSelectedIdChange => _onSelectedIdChangeController.stream;

  @Output('actionButtonTrigger')
  Stream<String> get onActionButtonTrigger => onActionButtonTriggerController.stream;

  @Output('visibleChange')
  Stream<bool> get onVisibleChange => _onVisibleChangeController.stream;
}