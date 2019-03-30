// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'dart:math' as math;

import 'package:angular/angular.dart';
import 'package:angular_components/focus/focus.dart';
import 'package:angular_components/laminate/enums/alignment.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_components/material_input/material_number_accessor.dart';
import 'package:angular_components/material_popup/material_popup.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:intl/intl.dart';

import '../../pipes/capitalize_pipe.dart';
import '../fo_modal/fo_modal_component.dart';

@Component(
    selector: 'fo-number-input',
    styleUrls: ['fo_number_input_component.css'],
    templateUrl: 'fo_number_input_component.html',
    directives: [
      AutoFocusDirective,
      coreDirectives,
      FoModalComponent,
      formDirectives,
      materialInputDirectives,
      materialNumberInputDirectives,
      AutoFocusDirective,
      MaterialButtonComponent,
      MaterialIconComponent,
      MaterialInputComponent,
      MaterialPopupComponent,
      PopupSourceDirective
    ],
    providers: [FORM_PROVIDERS],
    pipes: [CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoNumberInputComponent implements OnDestroy, ControlValueAccessor<int> {
  final List<RelativePosition> position = [RelativePosition.AdjacentBottom];

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

  final String msgEnterValue = Intl.message('enter value', name: 'enter_value');

  @Input()
  bool disabled = false;
  @Input()
  String label = 'value';
  @Input()
  String leadingText = '';

  @Input()
  int max = 9999;
  @Input()
  int min = 0;
  @Input()
  int step = 1;
  @Input()
  String trailingText = '';
  @ViewChild(MaterialInputComponent)
  MaterialInputComponent input;
  FoNumberInputComponent(@Self() @Optional() this.control,
      @Attribute('tabindex') this.tabIndex, this._changeDetectorRef) {
    _mouseUpListener = html.document.onMouseUp.listen(onMouseUp);
    _touchEndListener = html.document.onTouchEnd.listen(onMouseUp);
    _keyUpListener = html.document.onKeyUp.listen(onMouseUp);

    if (control != null) control.valueAccessor = this;
  }
  String get formattedValue => value == null ? '-' : value.toString();
  void add(int count) {
    value ??= (count is double) ? 0.0 : 0;

    if (value + count >= min && value + count <= max) {
      value += count;
      _onChange(value);
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

  void openPopup() {
    if (!disabled) {
      popupVisible = true;
    }
  }

  @override
  void registerOnChange(ChangeFunction<int> f) => _onChange = f;

  @override
  void registerOnTouched(TouchFunction f) {}

  void setValueClamped(String v) {
    if (v == null)
      value = 0;
    else {
      try {
        value = v == null ? 0 : math.max(min, math.min(max, int.parse(v)));
      } on FormatException {
        value = 0;
      }
    }

    _onChange(value);
  }

  @override
  void writeValue(int obj) {
    value = obj;
  }
}
