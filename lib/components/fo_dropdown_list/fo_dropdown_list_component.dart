import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:intl/intl.dart';

import '../../pipes/capitalize_pipe.dart';
import '../fo_dropdown/fo_dropdown_component.dart';
import '../fo_text_input/fo_text_input_component.dart';
import 'fo_dropdown_option.dart';
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
  set options(Map<String, List<FoDropdownOptionRenderable>> o) {
    _options = o;
    for (final category in _options.values) {
      for (final option in category) {
        if (option.renderImage != null) {
          final image = html.ImageElement(src: option.renderImage);
          image.onLoad.listen((_e) {
            dropdown?.evaluateHeight();
          });
        }
      }
    }
  }

  Map<String, List<FoDropdownOptionRenderable>> get options => _options;

  Map<String, List<FoDropdownOptionRenderable>> _options = {};

  @Input()
  String? filter;

  @Input()
  bool showSearch = false;

  final String msgFilter = Intl.message('filter', name: 'filter');
  final FoDropdownOption nullOption = FoDropdownOption()
    ..id = null
    ..label = '-';

  final StreamController<bool> visibleController = StreamController<bool>();
  final StreamController<FoDropdownOptionRenderable> _selectController =
      StreamController<FoDropdownOptionRenderable>();
  Map<String, List<FoDropdownOptionRenderable>> _filteredOptions = {};

  FoDropdownListComponent();

  Map<String, List<FoDropdownOptionRenderable>> get filteredOptions =>
      _filteredOptions;

  @Output('select')
  Stream<FoDropdownOptionRenderable> get select => _selectController.stream;

  @Input()
  bool shadow = true;

  @Input()
  bool square = false;

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

  void onSelect(html.Event event, FoDropdownOptionRenderable option) {
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
                option.renderLabel.toLowerCase().contains(v) ||
                (option.renderTags
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
