// Copyright (c) 2016, BuyByMarcus Ltd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/fo_components.dart' show DataTableModel, DataTableComponent, ImageFileComponent;

class MockUser extends DataTableModel
{
  MockUser(this._name, this._phone, String id) : super(id);

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
    new Timer(const Duration(milliseconds:200), () => userStreamController.add(new MockUser("patrick", "0709145325", "1")));
    new Timer(const Duration(milliseconds:300), () => userStreamController.add(new MockUser("bullen", "12346", "2")));
    new Timer(const Duration(milliseconds:500), () => userStreamController.add(new MockUser("bill", "t1951u0", "3")));
    new Timer(const Duration(milliseconds:850), () => userStreamController.add(new MockUser("peter", "012312", "4")));
    new Timer(const Duration(milliseconds:1600), () => userStreamController.add(new MockUser("marcus", "5555", "5")));
    new Timer(const Duration(milliseconds:1630), () => userStreamController.add(new MockUser("putte", "0709145325", "6")));
    new Timer(const Duration(milliseconds:2000), () => userStreamController.add(new MockUser("dejan", "12346", "7")));
    new Timer(const Duration(milliseconds:2200), () => userStreamController.add(new MockUser("oscar", "t1951u0", "8")));
    new Timer(const Duration(milliseconds:2300), () => userStreamController.add(new MockUser("richard", "012312", "9")));
    new Timer(const Duration(milliseconds:4000), () => userStreamController.add(new MockUser("charo", "5555", "10")));
    new Timer(const Duration(milliseconds:4300), () => userStreamController.add(new MockUser("richard", "012312", "11")));
    new Timer(const Duration(milliseconds:5000), () => userStreamController.add(new MockUser("charo", "5555", "12")));

    userStreamController.stream.listen((user)
    {
      models.add(user);
      models = new List.from(models);
    });
  }

  List<MockUser> models = new List();

  StreamController<MockUser> userStreamController = new StreamController();

  //Map<String, MockUser> mockModels = {"1" : new MockUser("patrick", "0709145324", "1"), "2" : new MockUser("annafrida", "0712312123", "2")};



}
