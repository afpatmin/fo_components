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
class FoLoginComponent implements OnDestroy
{
  FoLoginComponent();

  void ngOnDestroy()
  {
    _onLoginController.close();
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
        await client.sendCredentials(
            username,
            emailFrom: recoverPasswordFromEmail,
            emailMessage: recoverPasswordMessageEmail,
            emailSubject: recoverPasswordSubjectEmail,
            smsMessage: recoverPasswordMessageSMS,
            smsFrom: recoverPasswordFromSMS);

        recoverPasswordSent = true;
        state = "reset_password";
      }

      catch (e, s) { print(s); errorMessage = e.message; }
    }
  }

  Future onUpdatePassword() async
  {
    try
    {
      errorMessage = null;
      await client.updatePassword(username, password, token);
      token = "";
      setState("login");
    }
    catch (e, s)
    {
      print(s);
      errorMessage = e.message;
    }
  }

  void setState(String new_state)
  {
    state = new_state;
    recoverPasswordSent = false;
    errorMessage = null;
  }

  String username = "patrick.minogue@gmail.com";
  String password = "testa";
  String token = "";

  String state = "login";
  String errorMessage;
  bool recoverPasswordSent = false;
  bool visible = true;

  final StreamController<Map<String, String>> _onLoginController = new StreamController();

  @Input('client')
  ViAuthClient client;

  @Input('showForgotPassword')
  bool showForgotPassword = true;

  @Input('title')
  String strTitle = "Login";

  /**
   * This is the message which will be sent to the user by email when attempting
   * recover its password.
   * %token% placeholders are replaced by a new valid token
   * %password% placeholders are replaced by a new auto-generated password
   * %username% placeholders are replaced by the users username
   */
  @Input('recoverPasswordMessageEmail')
  String recoverPasswordMessageEmail; // = "token: %token%, username/password: %username% / %password%";

  @Input('recoverPasswordSubjectEmail')
  String recoverPasswordSubjectEmail = "Recover your password";

  @Input('recoverPasswordFromEmail')
  String recoverPasswordFromEmail;

  @Input('recoverPasswordMessageSMS')
  String recoverPasswordMessageSMS; // = "token: %token%, username/password: %username% / %password%";

  @Input('recoverPasswordFromSMS')
  String recoverPasswordFromSMS;

  @Output('login')
  Stream<Map<String, String>> get onLoginOutput => _onLoginController.stream;
}