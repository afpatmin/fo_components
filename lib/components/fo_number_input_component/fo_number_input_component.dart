// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-number-input',
    styleUrls: const ['fo_number_input_component.scss.css'],
    templateUrl: 'fo_number_input_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives],
    pipes: const [PhrasePipe],
    visibility: Visibility.none
)
class FoNumberInputComponent implements OnChanges, OnDestroy, ControlValueAccessor<num>
{
  FoNumberInputComponent(@Self() @Optional() NgControl cd)
  {
    _mouseUpListener = html.document.onMouseUp.listen(onMouseUp);
    _touchEndListener = html.document.onTouchEnd.listen(onMouseUp);

    control = cd;
    if (control != null) control.valueAccessor = this;
  }

  @override
  void registerOnTouched(TouchFunction f) {}

  @override
  void writeValue(num obj)
  {
    value = obj;
  }

  @override
  void registerOnChange(ChangeFunction<num> f) => _onChange = f;

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("step"))
    {
      String strStep = step.toString();
      _precision = (strStep.contains(".")) ?
        strStep.length - strStep.indexOf(".") - 1 : 0;
    }
  }

  void ngOnDestroy()
  {
    _mouseUpListener.cancel();
    _touchEndListener.cancel();
  }

  void onMouseDown(num count)
  {
    add(count);

    autoAddTimer?.cancel();
    addStepTimer?.cancel();
    addStepTimer = null;

    autoAddTimer = new Timer(const Duration(milliseconds: 600), ()
    {
      autoAddTimer = null;
      addStepTimer?.cancel();
      addStepTimer = new Timer.periodic(const Duration(milliseconds: 20), (_) => add(count));
    });
  }

  void onMouseUp(html.Event e)
  {
    autoAddTimer?.cancel();
    addStepTimer?.cancel();
    autoAddTimer = null;
    addStepTimer = null;
  }
  
  String get formattedValue
  {
    if (value == null) return "0";
    else if (value is int) return value.toString();
    else return value.toStringAsFixed(_precision);
  }

  void add(num count)
  {
    if (value == null) value = (count is double) ? 0.0 : 0;

    if (value + count >= min && value + count <= max)
    {
      value += count;
      _onChange(value);
    }
  }

  ChangeFunction<num> _onChange;
  NgControl control;
  num value;
  StreamSubscription<html.MouseEvent> _mouseUpListener;
  StreamSubscription<html.TouchEvent> _touchEndListener;
  Timer autoAddTimer;
  Timer addStepTimer;
  int _precision = 0;

  @Input('disabled')
  bool disabled = false;

  @Input('label')
  String label = "value";

  @Input('leadingText')
  String leadingText = "";

  @Input('max')
  num max = 9999;

  @Input('min')
  num min = 0;

  @Input('step')
  num step = 1;

  @Input('trailingText')
  String trailingText = "";
}
