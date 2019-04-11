import 'dart:async';

import 'package:angular/angular.dart';
import 'package:collection/collection.dart';
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
class FoDropdownSelectMultiComponent<T>
    implements OnInit, AfterChanges, OnDestroy {
  final String msgAdd = Intl.message('add', name: 'add');
  final StreamController<List<T>> selectionChangeController =
      StreamController<List<T>>();

  final _equal = const ListEquality().equals;

  @Input()
  String label;

  @Input()
  bool disabled = false;

  List<T> _selectedIds = [];

  bool _selectedIdsChanged = true;

  @Input('options')
  Map<String, List<FoDropdownOptionRenderable>> allOptions;
  @Input()

  /// Make sure options doesn't extend beyond the viewport
  bool constrainToViewPort = true;

  @Input()
  bool showSearch = false;

  @Input()
  bool materialIcons = true;

  Map<String, List<FoDropdownOptionRenderable>> filteredOptions = {};

  Object selectedId;

  List<FoDropdownOptionRenderable> addedOptions = [];
  List<T> get selectedIds => _selectedIds;

  @Input('selectedIds')
  set selectedIds(List<T> value) {
    _selectedIdsChanged = !_equal(value, _selectedIds);
    _selectedIds = value;
  }

  @Output('selectedIdsChange')
  Stream<List<T>> get selectedIdsChange => selectionChangeController.stream;

  @override
  void ngAfterChanges() {
    if (_selectedIdsChanged == true) {
      addedOptions = [];
      selectedIds?.forEach(onAdd);
    }
  }

  @override
  void ngOnDestroy() {
    selectionChangeController.close();
  }

  @override
  void ngOnInit() {
    _updateFilteredOptions();
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
    filteredOptions = <String, List<FoDropdownOptionRenderable>>{};
    for (final category in allOptions.keys) {
      filteredOptions[category] = allOptions[category].toList();
    }

    // Remove any options found in addedOptions list
    final addedOptionIds = addedOptions.map((o) => o.renderId);
    for (final category in filteredOptions.keys) {
      filteredOptions[category]
          .removeWhere((option) => addedOptionIds.contains(option.renderId));
    }

    selectionChangeController
        .add(addedOptionIds.toList().cast<T>());
  }
}
