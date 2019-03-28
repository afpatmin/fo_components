import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import '../../pipes/fo_name_pipe.dart';
import '../../services/fo_messages_service.dart';
import '../fo_button/fo_button_component.dart';
import '../fo_button/fo_button_event.dart';
import '../fo_dropdown_list/fo_dropdown_list_component.dart';
import '../fo_dropdown_list/fo_dropdown_option.dart';
import '../fo_label/fo_label_component.dart';
import 'fo_error_output_component.dart';

@Component(
    selector: 'fo-text-input',
    templateUrl: 'fo_text_input_component.html',
    styleUrls: const ['fo_text_input_component.css'],
    directives: const [
      FoButtonComponent,
      FoDropdownListComponent,
      FoErrorOutputComponent,
      FoLabelComponent,
      formDirectives,
      MaterialIconComponent,
      NgClass,
      NgIf
    ],
    pipes: const [NamePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoTextInputComponent implements ControlValueAccessor<String>, OnDestroy {
  @Input()
  String actionButtonLabel;

  @Input()
  String label;

  @Input()
  String leadingIcon;

  @Input()
  bool clearIcon;

  @Input()
  String placeholder;

  @Input()
  Map<String, List<FoDropdownOption>> options;

  @Input()
  bool disabled = false;

  String value;
  ChangeFunction<String> _onChange;
  NgControl control;
  final ChangeDetectorRef _changeDetectorRef;
  final FoMessagesService msg;
  final StreamController _actionButtonController =
      StreamController<FoButtonEvent>();
  final StreamController _selectionChangeController =
      StreamController<FoDropdownOption>();
  final StreamController _focusController = StreamController<html.FocusEvent>();
  bool dropdownVisible = false;
  int get dropdownWidth =>
      inputElement?.getBoundingClientRect()?.width?.toInt();

  @ViewChild('input')
  html.InputElement inputElement;

  FoTextInputComponent(
      @Self() @Optional() this.control, this._changeDetectorRef, this.msg) {
    if (control != null) control.valueAccessor = this;
  }

  bool hasFocus = false;

  String get errorMessage {
    final errors = control?.errors;
    if (errors == null) {
      return null;
    } else if (errors.containsKey('required')) {
      return msg.error_required();
    } else if (errors.containsKey('error')) {
      return errors['error'];
    } else if (errors.containsKey('minlength')) {
      return msg.error_min_length(errors['minlength']['requiredLength']);
    } else if (errors.containsKey('maxlength')) {
      return msg.error_max_length(errors['maxlength']['requiredLength']);
    } else if (errors.containsKey('pattern')) {
      return msg.error_invalid_pattern(errors['pattern']['requiredPattern']);
    } else {
      return errors.toString();
    }
  }

  @Output('selectionChange')
  Stream<FoDropdownOption> get selectionChange =>
      _selectionChangeController.stream;

  @Output('actionButtonTrigger')
  Stream<FoButtonEvent> get actionButtonTrigger =>
      _actionButtonController.stream;

  @Output('focus')
  Stream<html.FocusEvent> get focus => _focusController.stream;

  void onActionButtonTrigger(FoButtonEvent event) {
    _actionButtonController.add(event);
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

  void onFilterSelect(FoDropdownOption event) {
    value = event.label;
    dropdownVisible = false;
    if (_onChange != null) {
      _onChange(value);
    }
    _selectionChangeController.add(event);
  }

  void onValueChange(String event) {
    value = event;
    if (_onChange != null) {
      _onChange(value);
    }

    dropdownVisible = options != null && value?.isEmpty == false;
  }

  void onFocus(html.FocusEvent event) {
    hasFocus = true;
    _focusController.add(event);
  }

  @override
  void onDisabledChanged(bool isDisabled) {
    disabled = isDisabled;
  }

  @override
  void registerOnChange(ChangeFunction<String> f) {
    _onChange = f;
  }

  @override
  void registerOnTouched(TouchFunction f) {}

  @override
  void writeValue(String obj) {
    value = obj;
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      dropdownVisible = options != null && value?.isEmpty == false;
      _changeDetectorRef.markForCheck();
    });
  }

  @override
  void ngOnDestroy() {
    _actionButtonController.close();
    _selectionChangeController.close();
    _focusController.close();
  }
}
