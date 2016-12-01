// Copyright (c) 2016, Minoch AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library input_component;

import 'package:angular2/core.dart';

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

  @Input('foDescription')
  String foDescription;

  @Input('foLabel')
  String foLabel;

  @Input('foMax')
  int foMax;

  @Input('foMin')
  int foMin;

  @Input('foPattern')
  void set foPattern(String value)
  {
    _regExp = new RegExp(value);
  }

  @Input('foPlaceholder')
  String foPlaceholder = "";

  @Input('foPostfix')
  String foPostfix;

  @Input('foPrefix')
  String foPrefix;

  @Input('foType')
  void set foType(String value)
  {
    _type = value;
  }

  @Input('foValidationMessage')
  String foValidationMessage;

  @Input('foRequired')
  void set foRequired(String value)
  {
    _foRequired = value != null;
  }

  @Input('foClass')
  void set foClass(String value)
  {
    _foClass = value;
  }

  String get foClass => _foClass;
  bool get isRequired => _foRequired;
  String get foPattern => (_regExp == null) ? null : _regExp.pattern;
  String get foType => _type;

  String _foClass = "";
  bool _foRequired = false;
  RegExp _regExp = new RegExp(".*");
  String _type = "text";

  String foValue = "";
}
