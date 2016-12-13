// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:angular2/common.dart';

import 'package:fo_components/fo_components.dart';
import 'package:fo_components/fo_validators.dart';


@Component(
    selector: 'fo-app',
    templateUrl: 'html/app_component.html',
    directives: const [AlertComponent, DataTableComponent, FORM_DIRECTIVES, IconComponent, InfoPopupComponent, InputComponent],
    viewBindings: const [FORM_BINDINGS],
    providers: const [],
    preserveWhitespace: false)

class AppComponent implements OnInit
{

  AppComponent(this._formBuilder)
  {
    form = _formBuilder.group(
    {
      "login": ["1234", Validators.required],
      "firstname": ["PATRICK", Validators.required]
    });




  }

  void ngOnInit()
  {
    table.add({"testcol1" : "value1-2", "testcol2":"value1-2"});
    table.add({"testcol1" : "value2-2", "testcol2":"value2-2"});
  }

  void parseResponse(bool flag)
  {
    color = (flag == true) ? "green" : "red";
  }


  void printData(dynamic data)
  {
    print(data);
  }

  void onSubmit(dynamic data)
  {
    formData = JSON.encode(data);
  }

  String formData = "";

  String color = "black";

  List<Map<String, String>> table = new List();



  Control firstname = new Control("patrick");



  bool formClicked = false;

  final FormBuilder _formBuilder;
  ControlGroup form;

}
