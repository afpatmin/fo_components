// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as dom;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:fo_components/fo_components.dart' show FoModalComponent;
import 'package:vi_auth_client/vi_auth_client.dart';
import '../../../src/pipes/phrase_pipe.dart';

@Component(
    selector: 'fo-login',
    styleUrls: const ['fo_login_component.css'],
    templateUrl: 'fo_login_component.html',
    directives: const [materialDirectives, FoModalComponent],
    pipes: const [PhrasePipe])
class FoLoginComponent implements AfterContentInit, OnDestroy
{
  FoLoginComponent();

  void ngAfterContentInit()
  {
    state = "login";
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
      errorMessage = "invalid_details";
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
        state = "reset_password";
      }
      on Exception
      {
        errorMessage = "user_not_found";
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
      setState("login");
    }
    on Exception catch (e)
    {
      print(e);
      errorMessage = "invalid_token";
    }

  }

  void setState(String new_state)
  {
    state = new_state;
    resetPasswordSent = false;
    errorMessage = null;

    if (state == "login")
    {

    }
    else if (state == "forgot_password")
    {

    }
    else if (state == "reset_password")
    {

    }
  }

  String username = "patrick.minogue@gmail.com";
  String password = "testa";
  String token = "";

  String state = "";
  String errorMessage;
  bool resetPasswordSent = false;
  bool visible = true;

  final StreamController<Map<String, String>> _onLoginController = new StreamController();
  final StreamController<Map<String, String>> _onResetPasswordController = new StreamController();

  @Input('client')
  ViAuthClient client;

  @Input('showForgotPassword')
  bool showForgotPassword = true;

  @Input('title')
  String strTitle = "Login";

  @Output('login')
  Stream<Map<String, String>> get onLoginOutput => _onLoginController.stream;

  @Output('resetPassword')
  Stream<Map<String, String>> get onResetPasswordOutput => _onResetPasswordController.stream;
}