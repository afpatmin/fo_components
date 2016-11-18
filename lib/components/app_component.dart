// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:fo_components/fo_components.dart';


@Component(
    selector: 'fo-app',
    templateUrl: 'html/app_component.html',
    directives: const [InfoPopupComponent],
    preserveWhitespace: false)

class AppComponent
{
  void openPopup()
  {
    isOpen = !isOpen;
  }

  int counter = 0;
  bool isOpen = false;
  String title = "Lorem ipsum";
  final String text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
}
