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
import 'package:angular_components/model/selection/string_selection_options.dart';
import 'package:intl/intl.dart';
import '../../models/fo_model.dart';
import '../../pipes/capitalize_pipe.dart';
import '../fo_modal/fo_modal_component.dart';

@Component(
    selector: 'fo-select',
    styleUrls: ['fo_select_component.css'],
    templateUrl: 'fo_select_component.html',
    directives: [
      coreDirectives,
      DarkThemeDirective,
      FoModalComponent,
      MaterialButtonComponent,
      MaterialDropdownSelectComponent,
      MaterialIconComponent,
      MaterialSelectDropdownItemComponent,
      MaterialSelectSearchboxComponent,
    ],
    pipes: [CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
@Deprecated('Please use FoDropdownSelectComponent instead')
class FoSelectComponent implements AfterChanges, OnDestroy {
  FoSelectComponent();

  final String msgInformation =
      Intl.message('information', name: 'information');
  final String msgSearch = Intl.message('search', name: 'search');

  void onSelect(Object id) {
    selectedId = id;
    _onSelectedIdChangeController.add(id);
  }

  @override
  void ngAfterChanges() {
    if (options == null) {
      selectionOptions = StringSelectionOptions([]);
    } else if (options.length != _optionsCount) {
      selectionOptions =
          StringSelectionOptions(options.toList(), shouldSort: sort);
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
      StringSelectionOptions<FoModel>([]);

  final StreamController<bool> _onVisibleChangeController = StreamController();
  final StreamController<Object> _onSelectedIdChangeController =
      StreamController();
  final StreamController<Object> onActionButtonTriggerController =
      StreamController();

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
