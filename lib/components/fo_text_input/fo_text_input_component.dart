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

@Component(
    selector: 'fo-text-input',
    templateUrl: 'fo_text_input_component.html',
    styleUrls: const ['fo_text_input_component.css'],
    directives: const [
      FoButtonComponent,
      FoDropdownListComponent,
      formDirectives,
      MaterialIconComponent,
      NgClass,
      NgIf
    ],
    pipes: const [NamePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoTextInputComponent
    implements AfterViewInit, ControlValueAccessor<String>, OnDestroy {
  @Input()
  String actionButtonLabel;

  @Input()
  String label;

  @Input()
  String leadingIcon;

  @Input()
  String placeholder;

  @Input()
  Map<String, List<FoDropdownOption>> options;

  @Input()
  bool disabled = false;

  String value;
  ChangeFunction<String> _onChange;
  NgControl control;  
  final FoMessagesService msg;
  final StreamController _actionButtonController =
      StreamController<FoButtonEvent>();
  final StreamController _selectionChangeController =
      StreamController<FoDropdownOption>();
  bool dropdownVisible = false;
  int dropdownWidth;

  @ViewChild('input')
  html.InputElement inputElement;

  FoTextInputComponent(
      @Self() @Optional() this.control, this.msg) {
    if (control != null) control.valueAccessor = this;
  }

  String get errorMessage {
    if (control.errors.containsKey('required')) {
      return msg.error_required();
    }
    if (control.errors.containsKey('error')) {
      return control.errors['error'];
    } else if (control.errors.containsKey('minlength')) {
      return msg
          .error_min_length(control.errors['minlength']['requiredLength']);
    } else if (control.errors.containsKey('maxlength')) {
      return msg
          .error_max_length(control.errors['maxlength']['requiredLength']);
    } else if (control.errors.containsKey('pattern')) {
      return msg
          .error_invalid_pattern(control.errors['pattern']['requiredPattern']);
    }
    return control.errors == null ? null : control.errors.toString();
  }

  @Output('selectionChange')
  Stream<FoDropdownOption> get selectionChange =>
      _selectionChangeController.stream;

  @Output('actionButtonTrigger')
  Stream<FoButtonEvent> get actionButtonTrigger =>
      _actionButtonController.stream;

  void onActionButtonTrigger(FoButtonEvent event) {
    _actionButtonController.add(event);
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
    dropdownWidth = inputElement.getBoundingClientRect().width.toInt();
    dropdownVisible = true;    
    if (_onChange != null) {
      _onChange(value);
    }
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
  void registerOnTouched(TouchFunction f) {
    // TODO: implement registerOnTouched
  }

  @override
  void writeValue(String obj) {
    value = obj;
  }

  @override
  void ngOnDestroy() {
    _actionButtonController.close();
    _selectionChangeController.close();
  }

  @override
  void ngAfterViewInit() {        
    html.window.onResize.forEach((_) {
      dropdownWidth = inputElement.getBoundingClientRect().width.toInt();    
    });    
  }
}
