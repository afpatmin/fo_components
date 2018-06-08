// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_model/fo_model.dart';
import '../../services/fo_messages_service.dart';
import '../fo_modal/fo_modal_component.dart';

@Component(
    selector: 'fo-select',
    styleUrls: const ['fo_select_component.css'],
    templateUrl: 'fo_select_component.html',
    directives: const [coreDirectives, materialDirectives, FoModalComponent],
    pipes: const [])
class FoSelectComponent implements OnChanges, OnDestroy {
  FoSelectComponent(this.msg);

  void onSelect(Object id) {
    selectedId = id;
    _onSelectedIdChangeController.add(id);
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    if (changes.containsKey('options')) {
      if (options == null)
        selectionOptions = new StringSelectionOptions([]);
      else if (selectionOptions.optionsList.length != options.length) {
        selectionOptions = new StringSelectionOptions(
            options.toList(),
            shouldSort: sort);
      }
    }
  }

  @override
  void ngOnDestroy() {
    _onVisibleChangeController.close();
    _onSelectedIdChangeController.close();
    onActionButtonTriggerController.close();
  }

  void setVisible(bool flag) => visible = (disabled) ? visible : flag;

  Object get selectedModel => selectionOptions.optionsList
      .firstWhere((o) => o.id == selectedId, orElse: () => null);

  StringSelectionOptions<FoModel> selectionOptions =
      new StringSelectionOptions<FoModel>([]);

  final FoMessagesService msg;
  final StreamController<bool> _onVisibleChangeController =
      new StreamController();
  final StreamController<Object> _onSelectedIdChangeController =
      new StreamController();
  final StreamController<Object> onActionButtonTriggerController =
      new StreamController();

  bool tooltipModalVisible = false;

  @Input()
  String actionButtonIcon;

  @Input()
  String actionButtonText;

  @Input()
  bool allowNullSelection = false;

  @Input()
  String nullSelectionButtonText = '-';

  @Input()
  String label = '';

  @Input()
  bool disabled = false;

  @Input()
  bool fullWidth = false;

  @Input()
  bool icon = false;

  @Input()
  Iterable<FoModel> options = [];

  @Input()
  Object selectedId;

  @Input()
  bool showActionButton = false;

  @Input()
  bool showSearch = false;

  @Input()
  bool sort = true;

  @Input()
  String tooltip;

  @Input()
  bool visible = false;

  @Output('selectedIdChange')
  Stream<Object> get onSelectedIdChange => _onSelectedIdChangeController.stream;

  @Output('actionButtonTrigger')
  Stream<Object> get onActionButtonTrigger =>
      onActionButtonTriggerController.stream;

  @Output('visibleChange')
  Stream<bool> get onVisibleChange => _onVisibleChangeController.stream;
}
