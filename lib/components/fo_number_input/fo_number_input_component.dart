// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'dart:math' as math;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fo_components/components/fo_button/fo_button_component.dart';
import 'package:fo_components/components/fo_label/fo_label_component.dart';
import 'package:fo_components/components/fo_text_input/fo_text_input_component.dart';
import 'package:intl/intl.dart';

import '../../pipes/capitalize_pipe.dart';

@Component(
    selector: 'fo-number-input',
    styleUrls: ['fo_number_input_component.css'],
    templateUrl: 'fo_number_input_component.html',
    directives: [
      coreDirectives,
      FoButtonComponent,
      FoLabelComponent,
      FoTextInputComponent,
      formDirectives,
    ],
    pipes: [CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoNumberInputComponent implements OnDestroy, ControlValueAccessor<int> {

  ChangeFunction<int> _onChange;
  NgControl control;
  int value;
  StreamSubscription<html.KeyboardEvent> _keyUpListener;
  StreamSubscription<html.MouseEvent> _mouseUpListener;
  StreamSubscription<html.TouchEvent> _touchEndListener;
  final ChangeDetectorRef _changeDetectorRef;
  Timer autoAddTimer;
  Timer addStepTimer;
  bool popupVisible = false;
  String tabIndex = '0';
  int tabIndexNum = 0;

  final String msgEnterValue = Intl.message('enter value', name: 'enter_value');

  @Input()
  bool disabled = false;

  @Input()
  String label = 'value';

  @Input()
  int max = 9999;

  @Input()
  int min = 0;

  @Input()
  int step = 1;

  @Input()
  String trailingText = '';

  FoNumberInputComponent(@Self() @Optional() this.control,
      @Attribute('tabindex') this.tabIndex, this._changeDetectorRef) {
    try {
      tabIndexNum = tabIndex == null ? null : int.parse(tabIndex);
    } on FormatException catch (e) {
      print(e.message);
    }

    _mouseUpListener = html.document.onMouseUp.listen(onMouseUp);
    _touchEndListener = html.document.onTouchEnd.listen(onMouseUp);
    _keyUpListener = html.document.onKeyUp.listen(onMouseUp);

    if (control != null) control.valueAccessor = this;
  }

  String get tabIndexSub => tabIndexNum == null ? null : '${tabIndexNum - 1}';
  String get tabIndexAdd => tabIndexNum == null ? null : '${tabIndexNum + 1}';

  String get formattedValue => value == null ? '-' : value.toString();

  void add(int count) {
    value ??= (count is double) ? 0.0 : 0;

    if (value + count >= min && value + count <= max) {
      value += count;
      if (_onChange != null) {
        _onChange(value);
      }
      _changeDetectorRef.markForCheck();
    }
  }

  @override
  void ngOnDestroy() {
    _mouseUpListener.cancel();
    _touchEndListener.cancel();
    _keyUpListener.cancel();
  }

  @override
  void onDisabledChanged(bool isDisabled) {}

  void onKeyDown(html.KeyboardEvent event, int count) {
    if (event.keyCode == html.KeyCode.ENTER ||
        event.keyCode == html.KeyCode.MAC_ENTER ||
        event.keyCode == html.KeyCode.SPACE) {
      onMouseDown(count);
    }
  }

  void onMouseDown(int count) {
    if (disabled) return;
    add(count);

    autoAddTimer?.cancel();
    addStepTimer?.cancel();
    addStepTimer = null;

    autoAddTimer = Timer(const Duration(milliseconds: 600), () {
      autoAddTimer = null;
      addStepTimer?.cancel();
      addStepTimer =
          Timer.periodic(const Duration(milliseconds: 10), (_) => add(count));
    });
  }

  void onMouseUp(html.Event e) {
    autoAddTimer?.cancel();
    addStepTimer?.cancel();
    autoAddTimer = null;
    addStepTimer = null;
  }

  void onInputBlur(String v) {
    if (v == null) {
      value = 0;
    } else {
      var newValue = 0;
      try {
        newValue = int.parse(v);
        if (newValue > max) throw const FormatException('Value too large!');
        if (newValue < min) throw const FormatException('Value too small');
        value = newValue;
      } on FormatException catch (e) {
        print(e);
        
        // Reset the value
        if (value > min) {
          if (value == max) {
            value = min;
            Future.delayed(const Duration(milliseconds: 0)).then((_) {
              value = max;
            });
          }
          else value = max;          
        } else {
          if (value == min) {
            value = max;
            Future.delayed(const Duration(milliseconds: 0)).then((_) {
              value = min;
            });
          }
          else {
            value = min;
          }          
        }
      }
    }
  }

  @override
  void registerOnChange(ChangeFunction<int> f) => _onChange = f;

  @override
  void registerOnTouched(TouchFunction f) {}

  void setValueClamped(String v) {
    if (v == null || v.isEmpty)
      value = 0;
    else {
      try {
        value = int.parse(v);
      } on FormatException {
        value ??= 0;
      }
      value = math.min(max, math.max(min, value));
    }

    if (_onChange != null) {
      _onChange(value);
    }
  }

  @override
  void writeValue(int obj) {
    value = obj;
  }
}
