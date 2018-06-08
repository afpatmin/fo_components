// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
    selector: 'fo-multi-input',
    styleUrls: const ['fo_multi_input_component.css'],
    templateUrl: 'fo_multi_input_component.html',
    directives: const [coreDirectives, materialDirectives],
    pipes: const [])
class FoMultiInputComponent implements OnDestroy, ControlValueAccessor<String> {
  FoMultiInputComponent(@Self() @Optional() this.control) {
    if (control != null) control.valueAccessor = this;
  }

  @override
  void registerOnTouched(TouchFunction f) {}

  @override
  void writeValue(String obj) {
    inputValue = obj;
  }

  @override
  void registerOnChange(ChangeFunction<String> f) => _onChange = f;

  @override
  void ngOnDestroy() {
    _onValueChangeController.close();
  }

  void onKeyUp(html.KeyboardEvent e) {
    if (e.keyCode == html.KeyCode.ENTER ||
        e.keyCode == html.KeyCode.MAC_ENTER) {
      add();
      e
        ..stopPropagation()
        ..preventDefault();
    }
    if (_onChange != null) _onChange(inputValue);
  }

  void add() {
    if (control?.valid != false && inputValue.isNotEmpty) {
      value ??= [];
      value.add(inputValue);
      _onValueChangeController.add(value);
      inputValue = '';
    }
  }

  void remove(String item) {
    if (!disabled) {
      value.remove(item);
      _onValueChangeController.add(value);
    }
  }

  ChangeFunction<String> _onChange;
  NgControl control;

  @Input()
  bool disabled = false;

  @Input()
  String label;

  @Input()
  String leadingText = '';

  @Input()
  String maxLength;

  String inputValue = '';

  final StreamController<List<String>> _onValueChangeController =
      new StreamController();

  @Input()
  List<String> value = [];

  @Output('valueChange')
  Stream<List<String>> get onValueChangeOutput =>
      _onValueChangeController.stream;

  @override
  void onDisabledChanged(bool isDisabled) {}
}
