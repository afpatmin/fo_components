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
    directives: const [IconComponent, InfoPopupComponent, FORM_DIRECTIVES],
    providers: const [FORM_PROVIDERS])

class InputComponent implements OnInit
{
  InputComponent()
  {
  }

  void ngOnInit()
  {
    //control.validator = _validate;
    //print(control.valid);
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
  String foValidationMessage = "Enter a value";

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
/*
  Map<String, dynamic> _validate(AbstractControl c)
  {
    Map<String, dynamic> ret = new Map();

   // Map<String, dynamic> r1 = v.validate(c);
   // if (r1 != null) ret.addAll(r1);

    Map<String, dynamic> r2 = v2.validate(c);
    if (r2 != null) ret.addAll(r2);

    print(ret);
    return ret;
  }
*/
  String get foClass => _foClass;
  bool get isRequired => _foRequired;
  String get foPattern => _regExp.pattern;
  String get foType => _type;

  String _foClass = "";
  bool _foRequired = false;
  RegExp _regExp = new RegExp(r"(.*)");
  String _type = "text";

  String foValue = "";


  //Control control = new Control("");

  //Validator v = new MinLengthValidator("12");
 //alidator v2 = new MaxLengthValidator("13");
}
