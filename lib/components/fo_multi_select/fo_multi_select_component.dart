// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../models/fo_model.dart';
import '../../pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-multi-select',
    styleUrls: const ['fo_multi_select_component.scss.css'],
    templateUrl: 'fo_multi_select_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives],
    pipes: const [PhrasePipe],
    visibility: Visibility.local)
class FoMultiSelectComponent implements OnChanges, OnDestroy {
  FoMultiSelectComponent();

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    if (changes.containsKey('options') && options != null) {
      final prev = changes['options'].previousValue;
      final cur = changes['options'].currentValue;

      /// List equality check, skip if equal contents
      if (prev == null ||
          cur == null ||
          prev.length != cur.length ||
          prev.where(cur.contains).length != cur.length) {
        /// Convert List<FoModel> to StringSelectionOptions<FoModel>
        selectionOptions = new StringSelectionOptions(
            options.toList(growable: false),
            shouldSort: true);
      }
    }
  }

  @override
  void ngOnDestroy() {
    _onVisibleChangeController.close();
    _onSelectedIdsChangeController.close();
  }

  void onReorder(ReorderEvent event) {
    /*
    OptionModel sourceModel = selectedModels.elementAt(event.sourceIndex);
    selectedModels.removeAt(event.sourceIndex);
    selectedModels.insert(event.destIndex, sourceModel);
    selectedIds = selectedModels.map((model) => model['id']).toList();

    selectionModel.clear();
    selectedModels.forEach(selectionModel.select);
    */
  }

  void onToggle(String id, bool status) {
    if (status == true) {
      selectedIds.add(id);
    } else {
      selectedIds.remove(id);
    }
    _onSelectedIdsChangeController.add(selectedIds);
  }

  FoModel getModel(String id) => selectionOptions.optionsList
      .firstWhere((model) => model.id == id, orElse: () => null);

  StringSelectionOptions<FoModel> selectionOptions =
      new StringSelectionOptions([]);
  final StreamController<bool> _onVisibleChangeController =
      new StreamController();
  final StreamController<List<String>> _onSelectedIdsChangeController =
      new StreamController();

  @Input()
  bool allowReorder = false;

  @Input()
  String buttonText = 'select';

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
  List<String> selectedIds = [];

  @Input()
  bool showSearch = false;

  @Input()
  bool visible = false;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;

  @Output('selectedIdsChange')
  Stream<List<String>> get onSelectedIdsChangeOutput =>
      _onSelectedIdsChangeController.stream;
}
