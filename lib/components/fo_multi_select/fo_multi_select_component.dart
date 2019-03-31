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
import 'package:intl/intl.dart';
import '../../models/fo_model.dart';
import '../../pipes/capitalize_pipe.dart';

@Component(
    selector: 'fo-multi-select',
    styleUrls: ['fo_multi_select_component.css'],
    templateUrl: 'fo_multi_select_component.html',
    directives: [
      coreDirectives,
      MaterialCheckboxComponent,
      MaterialChipComponent,
      MaterialChipsComponent,
      MaterialDropdownSelectComponent,
      MaterialSelectDropdownItemComponent,
      MaterialSelectSearchboxComponent
    ],
    pipes: [CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
@Deprecated('This component will eventually be replaced by an extension of FoDropdownSelect')
class FoMultiSelectComponent implements AfterChanges, OnDestroy {
  final String msgSearch = Intl.message('search', name: 'search');

  StringSelectionOptions<FoModel> selectionOptions = StringSelectionOptions([]);

  final StreamController<bool> _onVisibleChangeController = StreamController();

  final StreamController<List<Object>> _onSelectedIdsChangeController =
      StreamController();

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

  FoMultiSelectComponent() {
    buttonText = Intl.message('select', name: 'select');
  }

  @Output('selectedIdsChange')
  Stream<List<Object>> get onSelectedIdsChangeOutput =>
      _onSelectedIdsChangeController.stream;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;

  FoModel getModel(Object id) => options == null
      ? null
      : options.firstWhere((model) => model.id == id, orElse: () => null);

  @override
  void ngAfterChanges() {
    if (options == null) {
      selectionOptions = StringSelectionOptions([]);
    } else if (options.length != _optionsCount) {
      selectionOptions = StringSelectionOptions(options.toList(growable: false),
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
}
