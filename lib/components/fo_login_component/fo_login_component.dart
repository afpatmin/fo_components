// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/fo_components.dart' show FoModalComponent;

@Component(
    selector: 'fo-login',
    styleUrls: const ['fo_login_component.css'],
    templateUrl: 'fo_login_component.html',
    directives: const [materialDirectives, FoModalComponent],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoLoginComponent implements OnDestroy
{
  FoLoginComponent();

  void ngOnDestroy()
  {
    _onLoginController.close();
    onForgotPasswordController.close();
  }

  void onLogin()
  {
    errorMessage = null;
    _onLoginController.add({"username":username, "password":password});
  }

  String username = "";
  String password = "";

  final StreamController<Map<String, String>> _onLoginController = new StreamController();
  final StreamController onForgotPasswordController = new StreamController();

  @Input('errorMessage')
  String errorMessage;

  @Input('forgotPasswordLabel')
  String strForgotPassword = "Forgot password";

  @Input('loginLabel')
  String strLogin = "Login";

  @Input('passwordLabel')
  String strPassword = "Password";

  @Input('showForgotPassword')
  bool showForgotPassword = true;

  @Input('title')
  String strTitle = "Login";

  @Input('usernameLabel')
  String strUsername = "Username";

  @Input('visible')
  bool visible = true;

  @Output('login')
  Stream<Map<String, String>> get onLoginOutput => _onLoginController.stream;

  @Output('forgotPassword')
  Stream get onForgotPasswordOutput => onForgotPasswordController.stream;
}