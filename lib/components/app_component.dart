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



  final String text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet, consectetur adipiscing elit...";
}
