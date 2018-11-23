// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/material_checkbox/material_checkbox.dart';
import 'package:angular_components/material_chips/material_chip.dart';
import 'package:angular_components/material_chips/material_chips.dart';
import 'package:angular_components/material_select/material_dropdown_select.dart';
import 'package:angular_components/material_select/material_select_dropdown_item.dart';
import 'package:angular_components/material_select/material_select_searchbox.dart';
import 'package:angular_components/model/selection/string_selection_options.dart';
import 'package:fo_model/fo_model.dart';
import '../../pipes/fo_name_pipe.dart';
import '../../services/fo_messages_service.dart';

@Component(
    selector: 'fo-multi-select',
    styleUrls: const ['fo_multi_select_component.css'],
    templateUrl: 'fo_multi_select_component.html',
    directives: const [
      coreDirectives,
      MaterialCheckboxComponent,
      MaterialChipComponent,
      MaterialChipsComponent,
      MaterialDropdownSelectComponent,
      MaterialSelectDropdownItemComponent,
      MaterialSelectSearchboxComponent
    ],
    pipes: const [NamePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoMultiSelectComponent implements AfterChanges, OnDestroy {
  FoMultiSelectComponent(this.msg) {
    buttonText = msg.select();
  }

  @override
  void ngAfterChanges() {
    if (options == null) {
      selectionOptions = new StringSelectionOptions([]);
    } else if (options.length != _optionsCount) {
      selectionOptions = new StringSelectionOptions(
          options.toList(growable: false),
          shouldSort: sort);
    }
    _optionsCount = selectionOptions.optionsList.length;
  }

  @override
  void ngOnDestroy() {
    _onVisibleChangeController.close();
    _onSelectedIdsChangeController.close();
  }

  void onToggle(Object id, bool status) {
    if (id == null || disabled) return;
    if (status == true) {
      selectedIds.add(id);
    } else {
      selectedIds.remove(id);
    }
    _onSelectedIdsChangeController.add(selectedIds);
  }

  FoModel getModel(Object id) => options == null
      ? null
      : options.firstWhere((model) => model.id == id, orElse: () => null);

  StringSelectionOptions<FoModel> selectionOptions =
      new StringSelectionOptions([]);

  final StreamController<bool> _onVisibleChangeController =
      new StreamController();
  final StreamController<List<Object>> _onSelectedIdsChangeController =
      new StreamController();

  final FoMessagesService msg;

  int _optionsCount = 0;

  @Input()
  String buttonText;

  @Input()
  bool disabled = false;

  @Input()
  bool fullWidth = false;

  @Input()
  String label = '';

  @Input()
  String nullSelectionButtonText = '-';

  @Input()
  Iterable<FoModel> options;

  @Input()
  List<Object> selectedIds = [];

  @Input()
  bool sort = true;

  @Input()
  bool showSearch = false;

  @Input()
  bool visible = false;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;

  @Output('selectedIdsChange')
  Stream<List<Object>> get onSelectedIdsChangeOutput =>
      _onSelectedIdsChangeController.stream;
}
