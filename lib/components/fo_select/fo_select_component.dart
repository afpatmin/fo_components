// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/theme/dark_theme.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'package:angular_components/material_select/material_dropdown_select.dart';
import 'package:angular_components/material_select/material_select_dropdown_item.dart';
import 'package:angular_components/material_select/material_select_searchbox.dart';
import 'package:fo_model/fo_model.dart';
import '../../pipes/fo_name_pipe.dart';
import '../../services/fo_messages_service.dart';
import '../fo_modal/fo_modal_component.dart';

@Component(
    selector: 'fo-select',
    styleUrls: const ['fo_select_component.css'],
    templateUrl: 'fo_select_component.html',
    directives: const [
      coreDirectives,
      DarkThemeDirective,
      FoModalComponent,
      MaterialButtonComponent,
      MaterialDropdownSelectComponent,
      MaterialIconComponent,
      MaterialSelectDropdownItemComponent,
      MaterialSelectSearchboxComponent,
    ],
    pipes: const [NamePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoSelectComponent implements AfterChanges, OnDestroy {
  FoSelectComponent(this.msg);

  void onSelect(Object id) {
    selectedId = id;
    _onSelectedIdChangeController.add(id);
  }

  @override
  void ngAfterChanges() {
    if (options == null) {
      selectionOptions = new StringSelectionOptions([]);      
    } else if (options.length != _optionsCount) {
      selectionOptions =
          new StringSelectionOptions(options.toList(), shouldSort: sort);      
    }
    _optionsCount = selectionOptions.optionsList.length;
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
  int _optionsCount = 0;

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
  bool darkTheme = false;

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
