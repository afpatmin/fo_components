// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular_forms/angular_forms.dart';
import 'package:angular/angular.dart';
import 'package:fo_model/fo_model.dart';
import '../fo_select/fo_select_component.dart';

@Component(
    selector: 'fo-time-input',
    styleUrls: ['fo_time_input_component.css'],
    templateUrl: 'fo_time_input_component.html',
    directives: [coreDirectives, FoSelectComponent],
    pipes: [],
    changeDetection: ChangeDetectionStrategy.OnPush)
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
      final regexp = RegExp(r'([01]\d|2[0-3]):?([0-5]\d)');

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
    FoModel()..id = '00',
    FoModel()..id = '01',
    FoModel()..id = '02',
    FoModel()..id = '03',
    FoModel()..id = '04',
    FoModel()..id = '05',
    FoModel()..id = '06',
    FoModel()..id = '07',
    FoModel()..id = '08',
    FoModel()..id = '09',
    FoModel()..id = '10',
    FoModel()..id = '11',
    FoModel()..id = '12',
    FoModel()..id = '13',
    FoModel()..id = '14',
    FoModel()..id = '15',
    FoModel()..id = '16',
    FoModel()..id = '17',
    FoModel()..id = '18',
    FoModel()..id = '19',
    FoModel()..id = '20',
    FoModel()..id = '21',
    FoModel()..id = '22',
    FoModel()..id = '23'
  ];

  final List<FoModel> minuteOptions = [
    FoModel()..id = '00',
    FoModel()..id = '01',
    FoModel()..id = '02',
    FoModel()..id = '03',
    FoModel()..id = '04',
    FoModel()..id = '05',
    FoModel()..id = '06',
    FoModel()..id = '07',
    FoModel()..id = '08',
    FoModel()..id = '09',
    FoModel()..id = '10',
    FoModel()..id = '11',
    FoModel()..id = '12',
    FoModel()..id = '13',
    FoModel()..id = '14',
    FoModel()..id = '15',
    FoModel()..id = '16',
    FoModel()..id = '17',
    FoModel()..id = '18',
    FoModel()..id = '19',
    FoModel()..id = '20',
    FoModel()..id = '21',
    FoModel()..id = '22',
    FoModel()..id = '23',
    FoModel()..id = '24',
    FoModel()..id = '25',
    FoModel()..id = '26',
    FoModel()..id = '27',
    FoModel()..id = '28',
    FoModel()..id = '29',
    FoModel()..id = '30',
    FoModel()..id = '31',
    FoModel()..id = '32',
    FoModel()..id = '33',
    FoModel()..id = '34',
    FoModel()..id = '35',
    FoModel()..id = '36',
    FoModel()..id = '37',
    FoModel()..id = '38',
    FoModel()..id = '39',
    FoModel()..id = '40',
    FoModel()..id = '41',
    FoModel()..id = '42',
    FoModel()..id = '43',
    FoModel()..id = '44',
    FoModel()..id = '45',
    FoModel()..id = '46',
    FoModel()..id = '47',
    FoModel()..id = '48',
    FoModel()..id = '49',
    FoModel()..id = '50',
    FoModel()..id = '51',
    FoModel()..id = '52',
    FoModel()..id = '53',
    FoModel()..id = '54',
    FoModel()..id = '55',
    FoModel()..id = '56',
    FoModel()..id = '57',
    FoModel()..id = '58',
    FoModel()..id = '59'
  ];

  @override
  void onDisabledChanged(bool isDisabled) {}
}
