import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:intl/intl.dart';

import '../../../src/components/fo_label/fo_label_component.dart';
import '../../pipes/capitalize_pipe.dart';
import 'fo_error_output_component.dart';

@Component(
  selector: 'fo-textarea-input',
  templateUrl: 'fo_textarea_input_component.html',
  styleUrls: ['fo_textarea_input_component.css'],
  directives: [
    FoErrorOutputComponent,
    FoLabelComponent,
    formDirectives,
    NgClass,
    NgIf
  ],
  pipes: [CapitalizePipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoTextAreaInputComponent
    implements ControlValueAccessor<String>, AfterViewInit, OnDestroy {
  final ChangeDetectorRef _changeDetectorRef;

  @Input()
  String? label;

  @Input()
  String? placeholder;

  @Input()
  bool disabled = false;

  @Input()
  bool canResize = false;

  @Input()
  int rows = 5;

  @Input()
  bool elastic = false;

  bool hasFocus = false;
  String value = '';
  ChangeFunction<String>? _onChange;
  NgControl? control;
  final StreamController<html.FocusEvent> _focusController =
      StreamController<html.FocusEvent>();
  final html.Element _host;
  late html.TextAreaElement inputElement;

  FoTextAreaInputComponent(
    @Self() @Optional() this.control,
    this._host,
    this._changeDetectorRef,
  ) {
    if (control != null) control?.valueAccessor = this;
  }

  String? get errorMessage {
    final errors = control?.errors;
    if (errors == null) {
      return null;
    } else if (errors.containsKey('required')) {
      return Intl.message('this field is required', name: 'error_required');
    } else if (errors.containsKey('error')) {
      return errors['error'] as String;
    } else if (errors.containsKey('minlength')) {
      return Intl.message(
          'enter at least ${errors['minlength']['requiredLength']} characters',
          args: [errors['minlength']['requiredLength'].toString()],
          name: 'error_min_length');
    } else if (errors.containsKey('maxlength')) {
      return Intl.message(
          'enter max ${errors['maxlength']['requiredLength']} characters',
          args: [errors['maxlength']['requiredLength'].toString()],
          name: 'error_max_length');
    } else if (errors.containsKey('pattern')) {
      return Intl.message(
          'invalid pattern, required: ${errors['pattern']['requiredPattern']}',
          args: [errors['pattern']['requiredPattern'].toString()],
          name: 'error_invalid_pattern');
    } else {
      return errors.toString();
    }
  }

  @Output('focus')
  Stream<html.FocusEvent> get focus => _focusController.stream;

  void onValueChange(String event) {
    value = event;
    if (elastic) {
      inputElement.style.minHeight = '1em';
      inputElement.style.minHeight =
          '${inputElement.scrollHeight + 2}px'; // +2 because border is not included in scrollHeight
    }

    if (_onChange != null) {
      _onChange!(value);
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
  void writeValue(String? obj) {
    value = obj ?? '';
    _changeDetectorRef.markForCheck();
  }

  @override
  void ngOnDestroy() {
    _focusController.close();
  }

  @override
  void ngAfterViewInit() {
    inputElement = _host.querySelector('textarea') as html.TextAreaElement;
    if (elastic) {
      inputElement.style.minHeight = '1em';
      inputElement.style.minHeight =
          '${inputElement.scrollHeight + 2}px'; // +2 because border is not included in scrollHeight
    }
  }
}
