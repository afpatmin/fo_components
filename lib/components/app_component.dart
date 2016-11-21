// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:fo_components/fo_components.dart';

@Component(
    selector: 'fo-app',
    templateUrl: 'html/app_component.html',
    directives: const [DataTableComponent, InfoPopupComponent, IconComponent],
    preserveWhitespace: false)

class AppComponent
{

  void parseResponse(bool flag)
  {
    color = (flag == true) ? "green" : "red";
  }


  String color = "black";
  final String text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet, consectetur adipiscing elit...";
}
