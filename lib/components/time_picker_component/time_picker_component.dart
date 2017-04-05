// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';
import 'package:angular2/core.dart';
import 'package:fo_components/components/icon_component/icon_component.dart';

@Component(
    selector: 'fo-time-picker',
    styleUrls: const ['time_picker_component.css'],
    templateUrl: 'time_picker_component.html',
    preserveWhitespace: false,
    directives: const [IconComponent],
    changeDetection: ChangeDetectionStrategy.OnPush)
class TimePickerComponent
{
  TimePickerComponent();

  String selectedHour;
  String selectedMinute;

  String calcHourLeft(String hour, bool inner)
  {
    int degrees = 30 * int.parse(hour) - 90;
    double left = inner ? 0.7 * 50 * cos(degrees.toDouble() * (PI / 180)) + 50 : 50 * cos(degrees.toDouble() * (PI / 180)) + 50;
    return "${left}%";
  }

  String calcHourTop(String hour, bool inner)
  {
    int degrees = 30 * int.parse(hour) - 90;
    double top = inner ? 0.7 * 50 * sin(degrees.toDouble() * (PI / 180)) + 50 : 50 * sin(degrees.toDouble() * (PI / 180)) + 50;
    return "${top}%";
  }

  String calcMinuteLeft(String minute)
  {
    int degrees = (6 * int.parse(minute) - 90);
    double left = 50 * cos(degrees.toDouble() * (PI / 180)) + 50;
    return "${left}%";
  }

  String calcMinuteTop(String minute)
  {
    int degrees = (6 * int.parse(minute) - 90);
    double top = 50 * sin(degrees.toDouble() * (PI / 180)) + 50;
    return "${top}%";
  }

  bool isAfterMidnight(String hour)
  {
    int hourInt = int.parse(hour);
    return hourInt < 12;
  }

  final List<String> hours =
  [
    "00","01","02","03","04","05","06","07","08","09","10","11","12","13","14",
    "15","16","17","18","19","20","21","22","23",
  ];
  final List<String> minutes = ["00","05","10","15","20","25","30","35","40","45","50","55"];
}
