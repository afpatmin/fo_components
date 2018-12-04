import 'dart:async';
import 'package:intl/intl.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_components/model/date/date.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fo_model/fo_model.dart';
import '../../services/fo_messages_service.dart';
import '../../validators/fo_validators.dart';
import '../fo_select/fo_select_component.dart';

@Component(
    selector: 'fo-social-number-input',
    templateUrl: 'fo_social_number_input_component.html',
    styleUrls: const ['fo_social_number_input_component.css'],
    directives: const [
      formDirectives,
      FoSelectComponent,
      materialInputDirectives
    ],
    pipes: const [],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoSocialNumberInputComponent implements OnInit, OnDestroy {
  FoSocialNumberInputComponent(this.msg);

  @override
  void ngOnInit() {
    digitsControl = (required)
        ? new Control(
            '',
            Validators.compose([
              Validators.required,
              Validators.maxLength(4),
              FoValidators.numeric
            ]))
        : new Control(
            '',
            Validators.compose(
                [Validators.maxLength(4), FoValidators.numeric]));
  }

  @override
  void ngOnDestroy() {
    _socialNumberOutputController.close();
  }

  void onBirthYearChange(String year) {
    selectedYear = year;
    if (selectedDay != null && selectedMonth != null) {
      _evalValue();
    }
  }

  void onBirthMonthChange(String month) {
    selectedMonth = month;
    if (selectedDay != null && selectedYear != null) {
      _evalValue();
    }
  }

  void onBirthDayChange(String day) {
    selectedDay = day;
    if (selectedYear != null && selectedMonth != null) {
      _evalValue();
    }
  }

  void onSocialNumberDigitsChange(String digits) {
    socialNumberDigits = digits;
    if (socialNumberDigits.length > 4) {
      socialNumberDigits = socialNumberDigits.substring(0, 4);
    }
    _evalValue();
  }

  void _evalValue() {
    final birthdate = new DateTime(int.parse(selectedYear),
        int.parse(selectedMonth), int.parse(selectedDay));
    final digiLen = socialNumberDigits.length;
    final buffer = new StringBuffer();
    for (var i = 0; i < 4 - digiLen; i++) {
      buffer.write('x');
    }
    trailingText = buffer.toString();
    _value =
        '${ssnFormat.format(birthdate)}$socialNumberDigits${buffer.toString()}';
    _socialNumberOutputController.add(_value);
  }

  final FoMessagesService msg;

  final StreamController<String> _socialNumberOutputController =
      new StreamController();

  final DateFormat ssnFormat = new DateFormat('yyyyMMdd');

  final List<FoModel> yearOptions = new List.generate(
      100,
      (index) =>
          new FoModel()..id = Date.today().add(years: -index).year.toString());
  final List<FoModel> monthOptions = new List.generate(
      12,
      (index) => new FoModel()
        ..id = index + 1 < 10 ? '0${index + 1}' : '${index + 1}');
  final List<FoModel> dayOptions = new List.generate(
      31,
      (index) => new FoModel()
        ..id = index + 1 < 10 ? '0${index + 1}' : '${index + 1}');

  String selectedYear;
  String selectedMonth;
  String selectedDay;
  String socialNumberDigits = '';
  String _value;

  void selectAll() {
    Timer.run(digitsInput.selectAll);
  }

  String get value => _value;
  String trailingText;

  @Input()
  set value(String v) {
    _value = v;
    if (_value.length >= 12) {
      _value = _value.substring(0, 12);
      selectedYear = _value.substring(0, 4);
      selectedMonth = _value.substring(4, 6);
      selectedDay = _value.substring(6, 8);
      final digitsPart = value.substring(8, 12);
      final xIndex = digitsPart.indexOf('x');
      if (xIndex >= 0)
        socialNumberDigits = digitsPart.substring(0, xIndex);
      else
        socialNumberDigits = digitsPart;
    } else {
      selectedYear = null;
      selectedMonth = null;
      selectedDay = null;
      socialNumberDigits = '';
    }
  }

  @Input()
  bool disabled = false;

  @Input()
  bool required = false;

  @Output('valueChange')
  Stream<String> get socialNumberChange => _socialNumberOutputController.stream;

  @ViewChild('digitsInput')
  MaterialInputComponent digitsInput;

  Control digitsControl;
}
