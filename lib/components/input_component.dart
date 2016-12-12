// Copyright (c) 2016, Minoch AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library input_component;

import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fo_components/components/info_popup_component.dart';
import 'package:fo_components/components/icon_component.dart';

@Component(
    selector: 'fo-input',
    styleUrls: const ['style/input_component.css'],
    templateUrl: 'html/input_component.html',
    preserveWhitespace: false,
    directives: const [IconComponent, InfoPopupComponent],
    providers: const [])

class InputComponent
{
  InputComponent()
  {
  }

  @Input('description')
  String description;

  @Input('label')
  String label;

  @Input('max')
  int max;

  @Input('min')
  int min;

  @Input('pattern')
  void set pattern(String value)
  {
    _regExp = new RegExp(value);
  }

  @Input('placeholder')
  String placeholder = "";

  @Input('postfix')
  String postfix;

  @Input('prefix')
  String prefix;

  @Input('type')
  void set type(String value)
  {
    _type = value;
  }

  @Input('validationMessage')
  String validationMessage;

  @Input('required')
  void set required(String value)
  {
    _required = value != null;
  }

  @Input('className')
  void set className(String value)
  {
    _className = value;
  }

  String get className => _className;
  bool get isRequired => _required;
  String get pattern => (_regExp == null) ? null : _regExp.pattern;
  String get type => _type;

  String _className = "";
  bool _required = false;
  RegExp _regExp = new RegExp(".*");
  String _type = "text";

  String value = "";
}
