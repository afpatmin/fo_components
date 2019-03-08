import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_components/material_icon/material_icon.dart';

import '../fo_dropdown_list/fo_dropdown_list_component.dart';
import '../fo_dropdown_list/fo_dropdown_option.dart';

@Component(
    selector: 'fo-dropdown-select',
    templateUrl: 'fo_dropdown_select_component.html',
    styleUrls: ['fo_dropdown_select_component.css'],
    directives: [FoDropdownListComponent, MaterialIconComponent, NgIf])
class FoDropdownSelectComponent implements OnInit, OnDestroy {
  @Input()
  String label;

  @Input()
  Map<String, List<FoDropdownOption>> options;

  final StreamController<Object> _selectedIdController =
      StreamController<Object>();
  final dom.Element _host;
  bool dropdownVisible = false;
  FoDropdownOption selectedOption;

  FoDropdownSelectComponent(this._host);

  @Input('selectedId')
  // ignore: avoid_setters_without_getters
  set selectedId(Object id) {
    selectedOption = null;

    if (options != null) {
      for (final category in options.keys) {
        if (options[category] != null) {
          selectedOption = options[category]
              .firstWhere((e) => e.id == id, orElse: () => null);

          if (selectedOption != null) {
            return;
          }
        }
      }
    }
  }

  int get dropdownWidth => _host?.getBoundingClientRect()?.width?.toInt();

  @Output('selectedIdChange')
  Stream<Object> get selectedIdChange => _selectedIdController.stream;

  @override
  void ngOnDestroy() {
    _selectedIdController.close();
  }

  void onSelect(FoDropdownOption event) {
    dropdownVisible = false;
    selectedOption = event;
    _selectedIdController.add(event.id);
  }

  @override
  void ngOnInit() {
    // This will select first option with id == null if it exists        
    selectedId = selectedOption?.id;
  }
}
