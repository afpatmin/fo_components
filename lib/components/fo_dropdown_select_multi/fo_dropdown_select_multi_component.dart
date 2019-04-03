import 'dart:async';

import 'package:angular/angular.dart';
import 'package:fo_components/pipes/capitalize_pipe.dart';
import 'package:intl/intl.dart';

import '../fo_dropdown_list/fo_dropdown_option.dart';
import '../fo_dropdown_select/fo_dropdown_select_component.dart';

@Component(
    selector: 'fo-dropdown-select-multi',
    templateUrl: 'fo_dropdown_select_multi_component.html',
    styleUrls: ['fo_dropdown_select_multi_component.css'],
    directives: [FoDropdownSelectComponent, NgClass, NgFor],
    pipes: [CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoDropdownSelectMultiComponent implements OnInit, OnDestroy {
  final String msgAdd = Intl.message('add', name: 'add');
  final StreamController<List<Object>> selectionChangeController =
      StreamController<List<Object>>();

  @Input()
  String label;

  @Input()
  bool disabled = false;

  @Input()
  List<Object> selectedIds = [];

  @Input('options')
  Map<String, List<FoDropdownOptionRenderable>> allOptions;

  Map<String, List<FoDropdownOptionRenderable>> filteredOptions = {};

  Object selectedId;
  List<FoDropdownOptionRenderable> addedOptions = [];
  @Output('selectedIdsChange')
  Stream<List<Object>> get selectedIdsChange =>
      selectionChangeController.stream;

  @override
  void ngOnDestroy() {
    selectionChangeController.close();
  }

  @override
  void ngOnInit() {
    _updateFilteredOptions();
    selectedIds?.forEach(onAdd);
  }

  void onAdd(Object id) {
    if (disabled != true) {
      for (final category in allOptions.keys) {
        final match = allOptions[category]
            .firstWhere((option) => option.renderId == id, orElse: () => null);
        if (match != null) {
          addedOptions.add(match);
          _updateFilteredOptions();
          break;
        }
      }
    }
  }

  void onRemove(Object id) {
    if (disabled != true) {
      addedOptions.removeWhere((o) => o.renderId == id);
      _updateFilteredOptions();
    }
  }

  void _updateFilteredOptions() {
    // Reset filtered options to contain all options
    filteredOptions = {};
    for (final category in allOptions.keys) {
      filteredOptions[category] = List.from(allOptions[category]);
    }

    // Remove any options found in addedOptions list
    final addedOptionIds = addedOptions.map((o) => o.renderId);
    for (final category in filteredOptions.keys) {
      filteredOptions[category]
          .removeWhere((option) => addedOptionIds.contains(option.renderId));
    }

    selectionChangeController.add(addedOptionIds.toList(growable: false));
  }
}
