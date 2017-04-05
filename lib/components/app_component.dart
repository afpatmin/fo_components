// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:fo_components/fo_components.dart' show TimePickerComponent;

@Component(
    selector: 'fo-app',
    templateUrl: 'app_component.html',
    directives: const [TimePickerComponent],
    viewBindings: const [],
    providers: const [],
    preserveWhitespace: false)
class AppComponent
{
  AppComponent()
  {
  }

}
