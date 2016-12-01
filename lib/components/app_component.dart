// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:fo_components/fo_components.dart';

@Component(
    selector: 'fo-app',
    templateUrl: 'html/app_component.html',
    directives: const [DataTableComponent, FormComponent, IconComponent, InfoPopupComponent, InputComponent],
    providers: const [],
    preserveWhitespace: false)

class AppComponent implements OnInit
{

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

  void onSubmit()
  {
    print("SUBMIT");
  }

  String color = "black";

  List<Map<String, String>> table = new List();
}
