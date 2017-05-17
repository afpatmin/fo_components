// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/fo_components.dart' show DataTableModel, DataTableComponent, ImageFileComponent;

class MockUser implements DataTableModel
{
  MockUser(this._name, this._phone);

  @override
  Map<String, String> toTableRow() => {"name":_name, "phone":_phone};

  final String _name;
  final String _phone;
}

@Component(
    selector: 'fo-app',
    templateUrl: 'app_component.html',
    directives: const [materialDirectives, ImageFileComponent, DataTableComponent],
    providers: const [],
    preserveWhitespace: false)
class AppComponent
{
  AppComponent()
  {
  }


  Map<String, MockUser> mockModels = {"1" : new MockUser("patrick", "0709145324"), "2" : new MockUser("annafrida", "0712312123")};
}
