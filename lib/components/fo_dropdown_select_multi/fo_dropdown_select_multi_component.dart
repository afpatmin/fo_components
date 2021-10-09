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
  directives: [FoDropdownSelectComponent, NgClass, NgFor, NgIf],
  pipes: [CapitalizePipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoDropdownSelectMultiComponent<T> implements AfterChanges, OnDestroy {
  final String msgAdd = Intl.message('add', name: 'add');
  final StreamController<List<T>> selectionChangeController =
      StreamController<List<T>>();

  final _equal = ListEquality().equals;

  @Input()
  String? label;

  @Input()
  bool disabled = false;

  @Input()
  String placeholder = '-';

  List<T> _selectedIds = [];

  bool _selectedIdsChanged = true;

  @Input()
  Map<String, List<FoDropdownOption>> options = {};

  /// Max height of the dropdown, in pixels
  @Input()
  int? dropdownMaxHeight;

  /// Make sure options doesn't extend beyond the viewport
  @Input()
  bool constrainToViewPort = true;

  @Input()
  bool showSearch = false;

  @Input()
  bool materialIcons = true;

  Map<String, List<FoDropdownOption>> filteredOptions = {};

  T? selectedId;

  List<FoDropdownOption> addedOptions = [];

  @Input()
  bool square = false;

  @Input()
  bool focusShadow = true;
  FoDropdownSelectMultiComponent();

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
    _updateFilteredOptions(outputEvent: false);
    if (_selectedIdsChanged == true) {
      addedOptions = [];
      for (final id in selectedIds) {
        onAdd(id, outputEvent: false);
      }
    }
  }

  @override
  void ngOnDestroy() {
    selectionChangeController.close();
  }

  void onAdd(T? id, {bool outputEvent = true}) {
    if (disabled != true) {
      for (final category in options.keys) {
        try {
          final match =
              options[category]!.firstWhere((option) => option.id == id);
          addedOptions.add(match);
          _updateFilteredOptions(outputEvent: outputEvent);
          break;
          // ignore: avoid_catching_errors, empty_catches
        } on StateError {}
      }
    }
  }

  void onRemove(Object id) {
    if (disabled != true) {
      addedOptions.removeWhere((o) => o.id == id);
      _updateFilteredOptions();
    }
  }

  void _updateFilteredOptions({bool outputEvent = true}) {
    // Reset filtered options to contain all options
    filteredOptions = <String, List<FoDropdownOption>>{};
    for (final category in options.keys) {
      filteredOptions[category] = options[category]!.toList();
    }

    // Remove any options found in addedOptions list
    final addedOptionIds = addedOptions.map((o) => o.id);
    for (final category in filteredOptions.keys) {
      filteredOptions[category]!
          .removeWhere((option) => addedOptionIds.contains(option.id));
    }

    if (outputEvent == true) {
      selectionChangeController.add(addedOptionIds.toList().cast<T>());
    }
  }
}
