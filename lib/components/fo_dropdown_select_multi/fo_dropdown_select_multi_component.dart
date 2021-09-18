import 'dart:async';
import 'dart:html' as dom;

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

  final dom.Element _host;

  @Input()
  String? label;

  @Input()
  bool disabled = false;

  @Input()
  String placeholder = '-';

  List<T> _selectedIds = [];

  bool _selectedIdsChanged = true;

  @Input('options')
  Map<String, List<FoDropdownOptionRenderable>> allOptions = {};

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

  Map<String, List<FoDropdownOptionRenderable>> filteredOptions = {};

  Object? selectedId;

  List<FoDropdownOptionRenderable> addedOptions = [];

  FoDropdownSelectMultiComponent(this._host);

  List<T> get selectedIds => _selectedIds;
  @Input('selectedIds')
  set selectedIds(List<T> value) {
    _selectedIdsChanged = !_equal(value, _selectedIds);
    _selectedIds = value;
  }

  @Output('selectedIdsChange')
  Stream<List<T>> get selectedIdsChange => selectionChangeController.stream;

  String? get square => _host.attributes.containsKey('square') ? '1' : null;

  String? get dense => _host.attributes.containsKey('dense') ? '1' : null;

  String? get noFocusShadow =>
      _host.attributes.containsKey('noFocusShadow') ? '1' : null;

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

  void onAdd(T id, {bool outputEvent = true}) {
    if (disabled != true) {
      for (final category in allOptions.keys) {
        try {
          final match = allOptions[category]!
              .firstWhere((option) => option.renderId == id);
          addedOptions.add(match);
          _updateFilteredOptions(outputEvent: outputEvent);
          break;
        } finally {}
      }
    }
  }

  void onRemove(Object id) {
    if (disabled != true) {
      addedOptions.removeWhere((o) => o.renderId == id);
      _updateFilteredOptions();
    }
  }

  void _updateFilteredOptions({bool outputEvent = true}) {
    // Reset filtered options to contain all options
    filteredOptions = <String, List<FoDropdownOptionRenderable>>{};
    for (final category in allOptions.keys) {
      filteredOptions[category] = allOptions[category]!.toList();
    }

    // Remove any options found in addedOptions list
    final addedOptionIds = addedOptions.map((o) => o.renderId);
    for (final category in filteredOptions.keys) {
      filteredOptions[category]!
          .removeWhere((option) => addedOptionIds.contains(option.renderId));
    }

    if (outputEvent == true) {
      selectionChangeController.add(addedOptionIds.toList().cast<T>());
    }
  }
}
