import 'dart:async';
import 'package:intl/intl.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fo_model/fo_model.dart';
import '../../services/fo_messages_service.dart';
import '../fo_select/fo_select_component.dart';

@Component(
    selector: 'fo-social-number-input',
    templateUrl: 'fo_social_number_input_component.html',
    styleUrls: const ['fo_social_number_input_component.css'],
    directives: const [FoSelectComponent, materialDirectives, formDirectives],
    providers: const [],
    pipes: const [],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoSocialNumberInputComponent implements OnInit, OnDestroy {
  FoSocialNumberInputComponent(this.msg);

  @override
  void ngOnInit() {
    digitsControl = (required)
        ? new Control('',
            Validators.compose([Validators.required, Validators.maxLength(4)]))
        : new Control('', Validators.compose([Validators.maxLength(4)]));
  }

  @override
  void ngOnDestroy() {
    _socialNumberOutputController.close();
  }

  void onBirthYearChange(String year) {
    selectedYear = year;
    if (selectedDay != null && selectedMonth != null) {
      final birthdate = new DateTime(int.parse(selectedYear),
          int.parse(selectedMonth), int.parse(selectedDay));

      _value = socialNumberDigits?.length == 4
          ? '${ssnFormat.format(birthdate)}$socialNumberDigits'
          : '${ssnFormat.format(birthdate)}0000';

      _socialNumberOutputController.add(_value);
    }
  }

  void onBirthMonthChange(String month) {
    selectedMonth = month;
    if (selectedDay != null && selectedYear != null) {
      final birthdate = new DateTime(int.parse(selectedYear),
          int.parse(selectedMonth), int.parse(selectedDay));
      _value = socialNumberDigits?.length == 4
          ? '${ssnFormat.format(birthdate)}$socialNumberDigits'
          : '${ssnFormat.format(birthdate)}0000';

      _socialNumberOutputController.add(_value);
    }
  }

  void onBirthDayChange(String day) {
    selectedDay = day;
    if (selectedYear != null && selectedMonth != null) {
      final birthdate = new DateTime(int.parse(selectedYear),
          int.parse(selectedMonth), int.parse(selectedDay));

      _value = socialNumberDigits?.length == 4
          ? '${ssnFormat.format(birthdate)}$socialNumberDigits'
          : '${ssnFormat.format(birthdate)}0000';

      _socialNumberOutputController.add(_value);
    }
  }

  void onSocialNumberDigitsChange(String digits) {
    socialNumberDigits = digits;
    final birthdate = new DateTime(int.parse(selectedYear),
        int.parse(selectedMonth), int.parse(selectedDay));
      _value = socialNumberDigits?.length == 4
          ? '${ssnFormat.format(birthdate)}$socialNumberDigits'
          : '${ssnFormat.format(birthdate)}0000';

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
  String socialNumberDigits;
  String _value;

  String get value => _value;

  @Input()
  set value(String v) {
    _value = v;
    if (_value?.length == 12) {
      selectedYear = _value.substring(0, 4);
      selectedMonth = _value.substring(4, 6);
      selectedDay = _value.substring(6, 8);
      socialNumberDigits = _value.substring(8, 12);
    } else {
      selectedYear = null;
      selectedMonth = null;
      selectedDay = null;
      socialNumberDigits = null;
    }
  }

  @Input()
  bool required = false;

  @Output('valueChange')
  Stream<String> get socialNumberChange => _socialNumberOutputController.stream;

  Control digitsControl;
}
