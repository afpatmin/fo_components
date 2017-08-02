// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as dom;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/fo_components.dart' show FoModalComponent;
import 'package:vi_auth_client/vi_auth_client.dart';

@Component(
    selector: 'fo-login',
    styleUrls: const ['fo_login_component.css'],
    templateUrl: 'fo_login_component.html',
    directives: const [materialDirectives, FoModalComponent])
class FoLoginComponent implements AfterContentInit, OnDestroy
{
  FoLoginComponent();

  void ngAfterContentInit()
  {
    state = strLogin;
  }

  void ngOnDestroy()
  {
    _onLoginController.close();
    _onResetPasswordController.close();
  }

  Future onLogin() async
  {
    try
    {
      errorMessage = null;
      String token = await client.loginWithUsernamePassword(username, password);
      _onLoginController.add({"username":username, "token":token});
      visible = false;
    }
    on Exception
    {
      errorMessage = strInvalidDetailsMessage;
    }
  }

  void onKeyUp(dom.KeyboardEvent e)
  {
    if (username.isNotEmpty && password.isNotEmpty
        && (e.keyCode == dom.KeyCode.ENTER || e.keyCode == dom.KeyCode.MAC_ENTER))
    {
      onLogin();
    }
  }

  void onRecoverPasswordKeyUp(dom.KeyboardEvent e)
  {
    if (e.keyCode == dom.KeyCode.ENTER || e.keyCode == dom.KeyCode.MAC_ENTER)
    {
      onRecoverPassword();
    }
  }

  Future onRecoverPassword() async
  {
    if (username.isNotEmpty)
    {
      errorMessage = null;
      try
      {
        String token = await client.resetToken(username);
        resetPasswordSent = true;
        _onResetPasswordController.add({"username":username, "token":token});
        state = strResetPassword;
      }
      on Exception
      {
        errorMessage = strUserNotFoundMessage;
      }
    }
  }

  Future onUpdatePassword() async
  {
    try
    {
      errorMessage = null;
      await client.resetPassword(username, password, token);
      token = "";
      setState(strLogin);
    }
    on Exception catch (e)
    {
      print(e);
      errorMessage = "Invalid token";
    }

  }

  void setState(String new_state)
  {
    state = new_state;
    resetPasswordSent = false;
    errorMessage = null;

    if (state == strLogin)
    {

    }
    else if (state == strForgotPassword)
    {

    }
    else if (state == strResetPassword)
    {

    }
  }

  String username = "patrick.minogue@gmail.com";
  String password = "test";
  String token = "";

  String state = "";
  String errorMessage;
  bool resetPasswordSent = false;
  bool visible = true;

  final StreamController<Map<String, String>> _onLoginController = new StreamController();
  final StreamController<Map<String, String>> _onResetPasswordController = new StreamController();

  @Input('client')
  ViAuthClient client;

  @Input('backLabel')
  String strBack = "Back";

  @Input('forgotPasswordLabel')
  String strForgotPassword = "Forgot password";

  @Input('loginLabel')
  String strLogin = "Login";

  @Input('resetPasswordLabel')
  String strResetPassword = "Reset password";

  @Input('newPasswordLabel')
  String strNewPassword = "New password";

  @Input('passwordLabel')
  String strPassword = "Password";

  @Input('saveLabel')
  String strSave = "Save";

  @Input('tokenLabel')
  String strToken = "Token";

  @Input('invalidDetailsMessage')
  String strInvalidDetailsMessage = "Invalid username or password";

  @Input('userNotFoundMessage')
  String strUserNotFoundMessage = "User not found";

  @Input('forgotPasswordDescription')
  String strForgotPasswordDescription = "Enter your username to recover your password";

  @Input('resetPasswordDescription')
  String strResetPasswordDescription = "A email has been sent to you with a key that you can use to update your password below.";

  @Input('sendLabel')
  String strSend = "Send";

  @Input('showForgotPassword')
  bool showForgotPassword = true;

  @Input('title')
  String strTitle = "Login";

  @Input('usernameLabel')
  String strUsername = "Username";

  @Output('login')
  Stream<Map<String, String>> get onLoginOutput => _onLoginController.stream;

  @Output('resetPassword')
  Stream<Map<String, String>> get onResetPasswordOutput => _onResetPasswordController.stream;
}