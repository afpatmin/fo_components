// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular_forms/angular_forms.dart';
import 'package:angular/angular.dart';
import 'package:fo_model/fo_model.dart';
import '../fo_select/fo_select_component.dart';

@Component(
    selector: 'fo-time-input',
    styleUrls: const ['fo_time_input_component.css'],
    templateUrl: 'fo_time_input_component.html',
    directives: const [coreDirectives, FoSelectComponent],
    pipes: const [])
class FoTimeInputComponent implements ControlValueAccessor<String> {
  FoTimeInputComponent(@Self() @Optional() NgControl cd) {
    if (cd != null) cd.valueAccessor = this;
  }

  @override
  void registerOnTouched(TouchFunction f) {}

  ChangeFunction<String> _onChange;

  @override
  void writeValue(String obj) {
    if (obj == null) {
      _hour = '00';
      _minute = '00';
    } else {
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

  set selectedHour(String hour) {
    _hour = hour;
    if (_onChange != null) _onChange('$_hour:$_minute');
  }

  set selectedMinute(String minute) {
    _minute = minute;
    if (_onChange != null) _onChange('$_hour:$_minute');
  }

  String _hour = '00';
  String _minute = '00';

  @Input()
  bool disabled = false;

  @Input()
  String label = 'time';

  final List<FoModel> hourOptions = [
    new FoModel()..id = '00',
    new FoModel()..id = '01',
    new FoModel()..id = '02',
    new FoModel()..id = '03',
    new FoModel()..id = '04',
    new FoModel()..id = '05',
    new FoModel()..id = '06',
    new FoModel()..id = '07',
    new FoModel()..id = '08',
    new FoModel()..id = '09',
    new FoModel()..id = '10',
    new FoModel()..id = '11',
    new FoModel()..id = '12',
    new FoModel()..id = '13',
    new FoModel()..id = '14',
    new FoModel()..id = '15',
    new FoModel()..id = '16',
    new FoModel()..id = '17',
    new FoModel()..id = '18',
    new FoModel()..id = '19',
    new FoModel()..id = '20',
    new FoModel()..id = '21',
    new FoModel()..id = '22',
    new FoModel()..id = '23'
  ];

  final List<FoModel> minuteOptions = [
    new FoModel()..id = '00',
    new FoModel()..id = '01',
    new FoModel()..id = '02',
    new FoModel()..id = '03',
    new FoModel()..id = '04',
    new FoModel()..id = '05',
    new FoModel()..id = '06',
    new FoModel()..id = '07',
    new FoModel()..id = '08',
    new FoModel()..id = '09',
    new FoModel()..id = '10',
    new FoModel()..id = '11',
    new FoModel()..id = '12',
    new FoModel()..id = '13',
    new FoModel()..id = '14',
    new FoModel()..id = '15',
    new FoModel()..id = '16',
    new FoModel()..id = '17',
    new FoModel()..id = '18',
    new FoModel()..id = '19',
    new FoModel()..id = '20',
    new FoModel()..id = '21',
    new FoModel()..id = '22',
    new FoModel()..id = '23',
    new FoModel()..id = '24',
    new FoModel()..id = '25',
    new FoModel()..id = '26',
    new FoModel()..id = '27',
    new FoModel()..id = '28',
    new FoModel()..id = '29',
    new FoModel()..id = '30',
    new FoModel()..id = '31',
    new FoModel()..id = '32',
    new FoModel()..id = '33',
    new FoModel()..id = '34',
    new FoModel()..id = '35',
    new FoModel()..id = '36',
    new FoModel()..id = '37',
    new FoModel()..id = '38',
    new FoModel()..id = '39',
    new FoModel()..id = '40',
    new FoModel()..id = '41',
    new FoModel()..id = '42',
    new FoModel()..id = '43',
    new FoModel()..id = '44',
    new FoModel()..id = '45',
    new FoModel()..id = '46',
    new FoModel()..id = '47',
    new FoModel()..id = '48',
    new FoModel()..id = '49',
    new FoModel()..id = '50',
    new FoModel()..id = '51',
    new FoModel()..id = '52',
    new FoModel()..id = '53',
    new FoModel()..id = '54',
    new FoModel()..id = '55',
    new FoModel()..id = '56',
    new FoModel()..id = '57',
    new FoModel()..id = '58',
    new FoModel()..id = '59'
  ];

  @override
  void onDisabledChanged(bool isDisabled) {}
}
