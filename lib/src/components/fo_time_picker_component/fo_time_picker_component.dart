// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'dart:math';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'fo-time-picker',
    styleUrls: const ['fo_time_picker_component.css'],
    templateUrl: 'fo_time_picker_component.html',
    directives: const [],
    changeDetection: ChangeDetectionStrategy.OnPush)

class FoTimePickerComponent implements OnDestroy, AfterViewInit
{
  FoTimePickerComponent();

  void ngOnDestroy()
  {
    _onTimeChangeController.close();
  }

  void ngAfterViewInit()
  {

  }

  String calcHourLeft(String hour)
  {
    int degrees = 30 * int.parse(hour) - 90;
    double left = 40 * cos(degrees.toDouble() * (PI / 180)) + 50;
    return "${left}%";
  }

  String calcHourTop(String hour)
  {
    int degrees = 30 * int.parse(hour) - 90;
    double top = 40 * sin(degrees.toDouble() * (PI / 180)) + 50;
    return "${top}%";
  }

  String calcMinuteLeft(String minute)
  {
    int degrees = (6 * int.parse(minute) - 90);
    double left = 40 * cos(degrees.toDouble() * (PI / 180)) + 50;
    return "${left}%";
  }

  String calcMinuteTop(String minute)
  {
    int degrees = (6 * int.parse(minute) - 90);
    double top = 40 * sin(degrees.toDouble() * (PI / 180)) + 50;
    return "${top}%";
  }

  bool get amMode => _amMode;
  String get strHour => _strHour;
  String get strMinute => _strMinute;

  void set amMode(bool value)
  {
    _amMode = value;

    int hourIndex = int.parse(_strHour);
    if (hourIndex >= 12) hourIndex -= 12;

    _strHour = (_amMode) ? amHours[hourIndex] : pmHours[hourIndex];

    _onTimeChangeController.add((strHour == null || strMinute == null) ? null : "$_strHour:$_strMinute");
  }

  void set strHour(String value)
  {
    _strHour = value;
  }

  void set strMinute(String value)
  {
    _strMinute = value;
    if (_amMode == false && _strHour != null) _strHour = (int.parse(_strHour) + 12).toString();

    _onTimeChangeController.add((_strHour == null || _strMinute == null) ? null : "$_strHour:$_strMinute");
  }

  // Check if time is currently AM or PM
  void _evalAmPm()
  {
    if (_strHour != null)
    {
      int hour = int.parse(_strHour);
      _amMode = hour <= 12;
    }
  }

  final StreamController<String> _onTimeChangeController = new StreamController();
  final List<String> amHours = ["00","01","02","03","04","05","06","07","08","09","10","11"];
  final List<String> pmHours = ["12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"];
  final List<String> minutes = ["00","05","10","15","20","25","30","35","40","45","50","55"];
  String _strHour;
  String _strMinute;
  bool _amMode = false;

  @Input('label')
  String label = "Time";

  @Input('time')
  void set time(String value)
  {
    if (value == null)
    {
      _strMinute = null;
      _strHour = null;
    }
    else
    {
      RegExp r = new RegExp(r"[0-9]{2}:[0-9]{2}");
      String strMatch = r.stringMatch(value);

      if (strMatch == null || strMatch.compareTo(value) != 0) throw new FormatException("Invalid time format (must be HH:MM)");

      List<String> split = value.split(":");
      _strHour = split.first;
      _strMinute = split.last;

      _evalAmPm();
    }
  }

  @Output('timeChange')
  Stream<String> get onTimeChangeOutput => _onTimeChangeController.stream;
}
