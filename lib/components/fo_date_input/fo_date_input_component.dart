// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-date-input',
    templateUrl: 'fo_date_input_component.html',
    styleUrls: const ['fo_date_input_component.css'],
    directives: const [coreDirectives],
    pipes: const [PhrasePipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    visibility: Visibility.local)
class FoDateInputComponent implements OnChanges, ControlValueAccessor<DateTime>
{
  /// Constructor
  FoDateInputComponent(@Self() @Optional() this.control, this._hostElement)
  {
    if (control != null)
      control.valueAccessor = this;
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    input = _hostElement.querySelector('input');
    if (value != null)
    {
      /**
       * Always assume noon for consistency
       */
      value = new DateTime(value.year, value.month, value.day, 12);
      input.valueAsDate = value;
    }
  }

  void onValueChange()
  {
    //value = input.valueAsDate;
    try
    {
      value = DateTime.parse(input.value);
    }
    on FormatException {
      value = new DateTime(0, 0, 0, 12);
    }
    _onChange(value);
  }

  @override
  void registerOnTouched(TouchFunction f) {}

  @override
  void writeValue(DateTime obj)
  {
    value = obj;
  }

  @override
  void registerOnChange(ChangeFunction<DateTime> f) => _onChange = f;

  ChangeFunction<DateTime> _onChange;
  NgControl control;
  DateTime value;
  html.DateInputElement input;

  @Input()
  bool disabled = false;

  @Input()
  String label = 'date';


  html.Element _hostElement;

  @override
  void onDisabledChanged(bool isDisabled) {
  }
}
