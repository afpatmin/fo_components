import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../pipes/capitalize_pipe.dart';
import '../../services/fo_messages_service.dart';
import '../fo_label/fo_label_component.dart';
import 'fo_error_output_component.dart';

@Component(
    selector: 'fo-textarea-input',
    templateUrl: 'fo_textarea_input_component.html',
    styleUrls: const ['fo_textarea_input_component.css'],
    directives: const [
      FoErrorOutputComponent,
      FoLabelComponent,
      formDirectives,
      NgClass,
      NgIf
    ],
    pipes: const [CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoTextAreaInputComponent
    implements ControlValueAccessor<String>, OnDestroy {

  @Input()
  String label;

  @Input()
  String placeholder;

  @Input()
  bool disabled = false;

  @Input()
  int rows = 5;

  bool hasFocus = false;
  String value;
  ChangeFunction<String> _onChange;
  NgControl control;
  final FoMessagesService msg;
  final StreamController _focusController = StreamController<html.FocusEvent>();

  @ViewChild('textArea')
  html.TextAreaElement textAreaElement;

  FoTextAreaInputComponent(@Self() @Optional() this.control, this.msg) {
    if (control != null) control.valueAccessor = this;
  }

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

  @Output('focus')
  Stream<html.FocusEvent> get focus => _focusController.stream;

  void onValueChange(String event) {
    value = event;
    if (_onChange != null) {
      _onChange(value);
    }
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
  }

  @override
  void ngOnDestroy() {
    _focusController.close();
  }
}
