import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fo_components/src/components/fo_dropdown/fo_dropdown_component.dart';
import 'package:intl/intl.dart';

import '../../../components/fo_text_input/fo_text_input_component.dart';
import '../../../fo_dropdown_option.dart';
import '../../../pipes/capitalize_pipe.dart';
import 'fo_dropdown_option_component.dart';

@Component(
    selector: 'fo-dropdown-list',
    templateUrl: 'fo_dropdown_list_component.html',
    styleUrls: ['fo_dropdown_list_component.css'],
    directives: [
      NgClass,
      NgFor,
      NgIf,
      NgStyle,
      FoDropdownComponent,
      FoDropdownOptionComponent,
      formDirectives,
      FoTextInputComponent
    ],
    pipes: [CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoDropdownListComponent<T> implements AfterChanges, OnDestroy {
  @Input()
  num? width;

  @Input()
  bool visible = false;

  @Input()
  bool allowNullSelection = false;

  @Input()
  bool constrainToViewPort = true;

  @Input()
  bool showCategoryLabels = true;

  @Input()
  bool materialIcons = true;

  @Input()
  int? offsetTop;

  /// Horizontal offset in pixels
  @Input()
  int offsetHorizontal = 0;

  @Input()
  int? maxHeight;

  @ViewChild(FoDropdownComponent)
  FoDropdownComponent? dropdown;

  @Input()
  set options(Map<String, List<FoDropdownOption>> o) {
    _options = o;
    for (final category in _options.values) {
      for (final option in category) {
        if (option.image != null) {
          final image = html.ImageElement(src: option.image);
          image.onLoad.listen((_e) {
            dropdown?.evaluateHeight();
          });
        }
      }
    }
  }

  Map<String, List<FoDropdownOption>> get options => _options;

  Map<String, List<FoDropdownOption>> _options = {};

  @Input()
  String? filter;

  @Input()
  bool showSearch = false;

  final String msgFilter = Intl.message('filter', name: 'filter');
  final FoDropdownOption nullOption = FoDropdownOption(null, '-');

  final StreamController<bool> visibleController = StreamController<bool>();
  final StreamController<FoDropdownOption> _selectController =
      StreamController<FoDropdownOption>();
  Map<String, List<FoDropdownOption>> _filteredOptions = {};

  FoDropdownListComponent();

  Map<String, List<FoDropdownOption>> get filteredOptions => _filteredOptions;

  @Output('select')
  Stream<FoDropdownOption> get select => _selectController.stream;

  @Output('visibleChange')
  Stream<bool> get visibleChange => visibleController.stream;

  @override
  void ngAfterChanges() {
    if (visible == true) {
      updateFilteredOptions(filter);
      if (_filteredOptions.isEmpty) {
        visibleController.add(false);
      }
    }
  }

  @override
  void ngOnDestroy() {
    visibleController.close();
    _selectController.close();
  }

  void onSelect(html.Event event, FoDropdownOption option) {
    event
      ..preventDefault()
      ..stopPropagation();
    _selectController.add(option);
  }

  void updateFilteredOptions(String? value) {
    if (value == null || value.isEmpty) {
      _filteredOptions = Map.from(options);
    } else {
      _filteredOptions = {};
      for (final category in options.keys) {
        final v = value.toLowerCase();
        _filteredOptions[category] = options[category]!
            .where((option) =>
                option.label.toLowerCase().contains(v) ||
                (option.tags
                    .where((tag) => tag.toLowerCase().contains(v))
                    .isNotEmpty))
            .toList(growable: false);
        if (_filteredOptions[category]!.isEmpty) {
          _filteredOptions.remove(category);
        }
      }
    }
  }
}
