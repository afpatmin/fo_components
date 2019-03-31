// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_chips/material_chip.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
    selector: 'fo-multi-input',
    styleUrls: ['fo_multi_input_component.css'],
    templateUrl: 'fo_multi_input_component.html',
    directives: [
      formDirectives,
      MaterialButtonComponent,
      MaterialChipComponent,
      MaterialIconComponent,
      materialInputDirectives,
      NgFor,
      NgIf
    ],
    pipes: [],
    changeDetection: ChangeDetectionStrategy.OnPush)
@Deprecated('This component will eventually be replaced by an extension of FoTextInputComponent')
class FoMultiInputComponent implements OnDestroy, ControlValueAccessor<String> {
  ChangeFunction<String> _onChange;

  NgControl control;

  @Input()
  bool disabled = false;

  @Input()
  String label;

  @Input()
  String leadingText = '';

  @Input()
  int maxCount;

  String inputValue = '';

  String get errorMessage {
    if (control == null || control.errors == null || control.errors.isEmpty)
      return null;

    return '${control.errors.keys.first}: ${control.errors.values.first.toString()}';
  }

  final StreamController<List<String>> _onValueChangeController =
      StreamController();

  @Input()
  List<String> value = [];

  FoMultiInputComponent(@Self() @Optional() this.control) {
    if (control != null) control.valueAccessor = this;
  }

  @Output('valueChange')
  Stream<List<String>> get onValueChangeOutput =>
      _onValueChangeController.stream;

  void add() {
    value ??= [];
    if (inputValue.isNotEmpty) {
      value.add(inputValue);
      if (_onChange != null) _onChange(inputValue);
      _onValueChangeController.add(value);
      inputValue = '';
    }
  }

  @override
  void ngOnDestroy() {
    _onValueChangeController.close();
  }

  @override
  void onDisabledChanged(bool isDisabled) {}

  void onKeyUp(html.KeyboardEvent e) {
    if ((e.keyCode == html.KeyCode.ENTER ||
            e.keyCode == html.KeyCode.MAC_ENTER) &&
        (control?.valid != false || value?.isEmpty == true)) {
      add();
      e
        ..stopPropagation()
        ..preventDefault();
    }
  }

  @override
  void registerOnChange(ChangeFunction<String> f) => _onChange = f;

  @override
  void registerOnTouched(TouchFunction f) {}

  void remove(String item) {
    if (!disabled) {
      final index = value.indexOf(item);
      if (_onChange != null) {
        if (index == 0)
          _onChange('');
        else
          _onChange(value[index - 1]);
      }
      value.remove(item);

      _onValueChangeController.add(value);
    }
  }

  @override
  void writeValue(String obj) {
    inputValue = obj;
  }
}
