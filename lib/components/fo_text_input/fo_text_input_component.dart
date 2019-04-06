import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/focus/focus.dart';
import 'package:angular_components/material_datepicker/module.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:intl/intl.dart';

import '../../pipes/capitalize_pipe.dart';
import '../fo_button/fo_button_component.dart';
import '../fo_button/fo_button_event.dart';
import '../fo_dropdown_list/fo_dropdown_list_component.dart';
import '../fo_dropdown_list/fo_dropdown_option.dart';
import '../fo_label/fo_label_component.dart';
import 'fo_error_output_component.dart';

@Component(
    selector: 'fo-text-input',
    templateUrl: 'fo_text_input_component.html',
    styleUrls: ['fo_text_input_component.css'],
    directives: [
      AutoFocusDirective,
      FoButtonComponent,
      FoDropdownListComponent,
      FoErrorOutputComponent,
      FoLabelComponent,
      formDirectives,
      MaterialIconComponent,
      NgClass,
      NgIf
    ],
    pipes: [CapitalizePipe],
    providers: [datepickerBindings],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoTextInputComponent implements ControlValueAccessor<String>, OnDestroy {
  @Input()
  String actionButtonLabel;

  @Input()
  bool autoFocus = false;

  @Input()
  String label;

  @Input()
  String leadingIcon;

  @Input()
  bool clearIcon;

  @Input()
  String placeholder;

  @Input()
  Map<String, List<FoDropdownOptionRenderable>> options;

  @Input()
  bool disabled = false;

  @Input()
  String type = 'text';

  String value;
  ChangeFunction<String> _onChange;
  NgControl control;
  final ChangeDetectorRef _changeDetectorRef;
  final StreamController<FoButtonEvent> actionButtonController =
      StreamController<FoButtonEvent>();
  final StreamController<html.Event> changeController =
      StreamController<html.Event>();
  final StreamController<FoDropdownOptionRenderable>
      _selectionChangeController =
      StreamController<FoDropdownOptionRenderable>();
  final StreamController<html.FocusEvent> _focusController =
      StreamController<html.FocusEvent>();
  final StreamController<String> _blurController = StreamController<String>();
  bool dropdownVisible = false;
  @ViewChild('input')
  html.InputElement inputElement;

  bool hasFocus = false;

  FoTextInputComponent(
      @Self() @Optional() this.control, this._changeDetectorRef) {
    if (control != null) control.valueAccessor = this;
  }

  @Output('actionButtonTrigger')
  Stream<FoButtonEvent> get actionButtonTrigger =>
      actionButtonController.stream;

  @Output('blur')
  Stream<String> get blur => _blurController.stream;

  int get dropdownWidth =>
      inputElement?.getBoundingClientRect()?.width?.toInt();

  String get errorMessage {
    final errors = control?.errors;
    if (errors == null) {
      return null;
    } else if (errors.containsKey('required')) {
      return Intl.message('this field is required', name: 'error_required');
    } else if (errors.containsKey('error')) {
      return errors['error'];
    } else if (errors.containsKey('minlength')) {
      return Intl.message(
          'enter at least ${errors['minlength']['requiredLength']} characters',
          args: [errors['minlength']['requiredLength']],
          name: 'error_min_length');
    } else if (errors.containsKey('maxlength')) {
      return Intl.message(
          'enter max ${errors['maxlength']['requiredLength']} characters',
          args: [errors['maxlength']['requiredLength']],
          name: 'error_max_length');
    } else if (errors.containsKey('pattern')) {
      return Intl.message(
          'invalid pattern, required: ${errors['pattern']['requiredPattern']}',
          args: [errors['pattern']['requiredPattern']],
          name: 'error_invalid_pattern');
    } else {
      return errors.toString();
    }
  }

  @Output('focus')
  Stream<html.FocusEvent> get focus => _focusController.stream;

  @Output('selectionChange')
  Stream<FoDropdownOptionRenderable> get selectionChange =>
      _selectionChangeController.stream;

  @override
  void ngOnDestroy() {
    actionButtonController?.close();
    changeController.close();
    _selectionChangeController.close();
    _focusController.close();
    _blurController.close();
  }

  void onBlur(html.Event event) {
    hasFocus = false;
    _blurController.add(value);
  }

  void onClear(html.Event event) {
    // Prevent the input from gaining focus
    event.preventDefault();
    value = '';
    dropdownVisible = false;
    if (_onChange != null) {
      _onChange(value);
    }
  }

  @override
  void onDisabledChanged(bool isDisabled) {
    disabled = isDisabled;
  }

  void onFilterSelect(FoDropdownOptionRenderable event) {
    value = event.renderLabel;
    dropdownVisible = false;
    if (_onChange != null) {
      _onChange(value);
    }
    _selectionChangeController.add(event);
  }

  void onFocus(html.FocusEvent event) {
    hasFocus = true;
    _focusController.add(event);
  }

  void onValueChange(String event) {
    value = event;
    if (_onChange != null) {
      _onChange(value);
    }

    dropdownVisible = options != null && value?.isEmpty == false;
  }

  @override
  void registerOnChange(ChangeFunction<String> f) {
    _onChange = f;
  }

  void onKeyUp(html.Event event) {
    if (event is html.KeyboardEvent &&
        (actionButtonLabel != null && event?.keyCode == html.KeyCode.ENTER ||
            event?.keyCode == html.KeyCode.MAC_ENTER &&
                value?.isEmpty == false)) { 
      actionButtonController.add(FoButtonEvent());
    }
  }

  @override
  void registerOnTouched(TouchFunction f) {}

  @override
  void writeValue(String obj) {
    value = obj;
    _changeDetectorRef.markForCheck();
  }
}
