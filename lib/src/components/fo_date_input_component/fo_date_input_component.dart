// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-date-input',
    templateUrl: 'fo_date_input_component.html',
    styleUrls: const ['fo_date_input_component.scss.css'],
    directives: const [CORE_DIRECTIVES, materialDirectives],
    pipes: const [PhrasePipe],
    visibility: Visibility.none,
    changeDetection: ChangeDetectionStrategy.OnPush)
class DateInputComponent implements OnDestroy
{
  DateInputComponent()
  {
    strDate = formatter.format(new DateTime.now());
  }

  void ngOnDestroy()
  {
    onValueChangeController.close();
  }

  void onValueChange(String date)
  {
    try
    {
      onValueChangeController.add(DateTime.parse(date));
    }
    catch (e)
    {
      print(e);
      onValueChangeController.add(null);
    }
  }

  String strDate;
  final StreamController<DateTime> onValueChangeController = new StreamController();
  final DateFormat formatter = new DateFormat("Y-m-d");

  @Input('label')
  String label = "date";

  @Input('value')
  void set value(DateTime dt)
  {
    try
    {
      strDate = formatter.format(dt);
    }
    on FormatException catch (e)
    {
      print(e);
      strDate = null;
    }
  }

  @Output('valueChange')
  Stream<DateTime> get onValueChangeOutput => onValueChangeController.stream;
}
