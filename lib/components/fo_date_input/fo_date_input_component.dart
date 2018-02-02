// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../pipes/phrase_pipe.dart';

/// DateInputComponent is exactly what it name says it is
@Component(
    selector: 'fo-date-input',
    templateUrl: 'fo_date_input_component.html',
    styleUrls: const ['fo_date_input_component.scss.css'],
    directives: const [CORE_DIRECTIVES],
    pipes: const [PhrasePipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    visibility: Visibility.local)
class FoDateInputComponent implements OnChanges, ControlValueAccessor<DateTime>
{
  /// Constructor
  FoDateInputComponent(@Self() @Optional() this.control)
  {
    if (control != null)
      control.valueAccessor = this;
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    _inputElement = inputRef.nativeElement;
    if (value != null)
    {
      /**
       * Always assume noon for consistency
       */
      value = new DateTime(value.year, value.month, value.day, 12);
      _inputElement.valueAsDate = value;
    }
  }

  void onValueChange(DateTime dt)
  {
    value = dt;
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
  html.DateInputElement _inputElement;

  @Input()
  bool disabled = false;

  @Input()
  String label = 'date';


  @ViewChild('input')
  ElementRef inputRef;
}
