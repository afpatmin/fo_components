// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:fo_components/fo_components.dart' show DataTableComponent;
import 'package:fo_components/services/mock_user_service.dart';

@Component(
    selector: 'fo-app',
    templateUrl: 'app_component.html',
    directives: const [DataTableComponent],
    viewBindings: const [],
    providers: const [MockUserService],
    preserveWhitespace: false)
class AppComponent
{
  AppComponent(this.userService)
  {
  }

  void printEvent(dynamic event)
  {
    print(event);
  }

  void removeLast()
  {
    userService.filteredData.remove(userService.filteredData.keys.last);
  }

  final MockUserService userService;

  int rows = 32;
}
