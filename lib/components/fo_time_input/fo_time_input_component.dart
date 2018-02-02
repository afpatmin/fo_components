// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular_forms/angular_forms.dart';
import 'package:angular/angular.dart';
import '../../models/fo_model.dart';
import '../../pipes/phrase_pipe.dart';
import '../fo_select/fo_select_component.dart';

@Component(
    selector: 'fo-time-input',
    styleUrls: const ['fo_time_input_component.scss.css'],
    templateUrl: 'fo_time_input_component.html',
    directives: const [CORE_DIRECTIVES, FoSelectComponent],
    pipes: const [PhrasePipe],
    visibility: Visibility.local
)
class FoTimeInputComponent implements ControlValueAccessor<String>
{
  FoTimeInputComponent(@Self() @Optional() NgControl cd)
  {
    if (cd != null)
      cd.valueAccessor = this;
  }

  @override
  void registerOnTouched(TouchFunction f)
  {
    /**
     * onBlur really
     */

    //_onTouch = f;
  }

  ChangeFunction<String> _onChange;
  //TouchFunction _onTouch;

  @override
  void writeValue(String obj)
  {
    if (obj == null)
    {
      _hour = '00';
      _minute = '00';
    }
    else
    {
      final regexp = new RegExp(r'([01]\d|2[0-3]):?([0-5]\d)');

      if (regexp.allMatches(obj).length != 1)
        throw const FormatException('Value must be formatted as HH:MM');

      final split = obj.split(':');
      _hour = split.first;
      _minute = split.last;
    }
  }

  @override
  void registerOnChange(ChangeFunction<String> f) => _onChange = f;

  String get selectedHour => _hour;
  String get selectedMinute => _minute;

  set selectedHour(String hour)
  {
    _hour = hour;
    if (_onChange != null)
      _onChange('$_hour:$_minute');
  }

  set selectedMinute(String minute)
  {
    _minute = minute;
    if (_onChange != null)
      _onChange('$_hour:$_minute');
  }

  String _hour = '00';
  String _minute = '00';

  @Input()
  bool disabled = false;

  @Input()
  String label = 'time';

  final List<FoModel> hourOptions =
  [
    new TimeOptionModel('00'),
    new TimeOptionModel('01'),
    new TimeOptionModel('02'),
    new TimeOptionModel('03'),
    new TimeOptionModel('04'),
    new TimeOptionModel('05'),
    new TimeOptionModel('06'),
    new TimeOptionModel('07'),
    new TimeOptionModel('08'),
    new TimeOptionModel('09'),
    new TimeOptionModel('10'),
    new TimeOptionModel('11'),
    new TimeOptionModel('12'),
    new TimeOptionModel('13'),
    new TimeOptionModel('14'),
    new TimeOptionModel('15'),
    new TimeOptionModel('16'),
    new TimeOptionModel('17'),
    new TimeOptionModel('18'),
    new TimeOptionModel('19'),
    new TimeOptionModel('20'),
    new TimeOptionModel('21'),
    new TimeOptionModel('22'),
    new TimeOptionModel('23'),
  ];

  final List<FoModel> minuteOptions =
  [
    new TimeOptionModel('00'),
    new TimeOptionModel('01'),
    new TimeOptionModel('02'),
    new TimeOptionModel('03'),
    new TimeOptionModel('04'),
    new TimeOptionModel('05'),
    new TimeOptionModel('06'),
    new TimeOptionModel('07'),
    new TimeOptionModel('08'),
    new TimeOptionModel('09'),
    new TimeOptionModel('10'),
    new TimeOptionModel('11'),
    new TimeOptionModel('12'),
    new TimeOptionModel('13'),
    new TimeOptionModel('14'),
    new TimeOptionModel('15'),
    new TimeOptionModel('16'),
    new TimeOptionModel('17'),
    new TimeOptionModel('18'),
    new TimeOptionModel('19'),
    new TimeOptionModel('20'),
    new TimeOptionModel('21'),
    new TimeOptionModel('22'),
    new TimeOptionModel('23'),
    new TimeOptionModel('24'),
    new TimeOptionModel('25'),
    new TimeOptionModel('26'),
    new TimeOptionModel('27'),
    new TimeOptionModel('28'),
    new TimeOptionModel('29'),
    new TimeOptionModel('30'),
    new TimeOptionModel('31'),
    new TimeOptionModel('32'),
    new TimeOptionModel('33'),
    new TimeOptionModel('34'),
    new TimeOptionModel('35'),
    new TimeOptionModel('36'),
    new TimeOptionModel('37'),
    new TimeOptionModel('38'),
    new TimeOptionModel('39'),
    new TimeOptionModel('40'),
    new TimeOptionModel('41'),
    new TimeOptionModel('42'),
    new TimeOptionModel('43'),
    new TimeOptionModel('44'),
    new TimeOptionModel('45'),
    new TimeOptionModel('46'),
    new TimeOptionModel('47'),
    new TimeOptionModel('48'),
    new TimeOptionModel('49'),
    new TimeOptionModel('50'),
    new TimeOptionModel('51'),
    new TimeOptionModel('52'),
    new TimeOptionModel('53'),
    new TimeOptionModel('54'),
    new TimeOptionModel('55'),
    new TimeOptionModel('56'),
    new TimeOptionModel('57'),
    new TimeOptionModel('58'),
    new TimeOptionModel('59'),
  ];
}

class TimeOptionModel extends FoModel
{
  TimeOptionModel(String id) : super(id);

  @override
  String toString() => id;
}