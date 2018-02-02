// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:vi_auth_client/vi_auth_client.dart';
import '../../pipes/phrase_pipe.dart';
import '../fo_modal/fo_modal_component.dart';

@Component(
    selector: 'fo-login',
    styleUrls: const ['fo_login_component.scss.css'],
    templateUrl: 'fo_login_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives, FoModalComponent],
    pipes: const [PhrasePipe],
    visibility: Visibility.local
)
class FoLoginComponent implements OnChanges, OnDestroy
{
  FoLoginComponent();

  @override
  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey('client') && Uri.base.queryParameters.containsKey('token'))
    {
      _tryLoginToken(Uri.base.queryParameters['token']);
    }
  }

  @override
  void ngOnDestroy()
  {
    _onLoginController.close();
  }

  Future onLogin() async
  {
    try
    {
      errorMessage = null;
      final token = await client.loginWithUsernamePassword(username, password);
      _onLoginController.add({'username':username, 'token':token});
      visible = false;
    }
    on Exception
    {
      errorMessage = 'invalid_details';
    }
  }

  void onKeyUp(html.KeyboardEvent e)
  {
    if (username.isNotEmpty && password.isNotEmpty
        && (e.keyCode == html.KeyCode.ENTER || e.keyCode == html.KeyCode.MAC_ENTER))
    {
      onLogin();
    }
  }

  void onRecoverPasswordKeyUp(html.KeyboardEvent e)
  {
    if (e.keyCode == html.KeyCode.ENTER || e.keyCode == html.KeyCode.MAC_ENTER)
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
        state = 'reset_password';
      }

      on Exception catch (e, s) { print(s); errorMessage = e.toString(); }
    }
  }

  Future onUpdatePassword() async
  {
    try
    {
      errorMessage = null;
      await client.updatePassword(username, password, token);
      token = '';
      setState('login');
    }
    on Exception catch (e, s)
    {
      print(s);
      errorMessage = e.toString();
    }
  }

  void setState(String newState)
  {
    state = newState;
    recoverPasswordSent = false;
    errorMessage = null;
  }

  Future _tryLoginToken(String token) async
  {
    try
    {
      visible = false;
      final newToken = await client.loginWithToken(token);
      _onLoginController.add({'username':username, 'token':newToken});
    }
    on Exception catch(e)
    {
      print(e.toString());
      visible = true;
    }
  }

  String token = '';

  String state = 'login';
  String errorMessage;
  bool recoverPasswordSent = false;
  bool visible = true;

  final StreamController<Map<String, String>> _onLoginController = new StreamController();

  @Input()
  String username = '';

  @Input()
  String password = '';

  @Input()
  ViAuthClient client;

  @Input()
  bool showForgotPassword = true;

  /// This is the message which will be sent to the user by email when attempting
  /// recover its password.
  /// %token% placeholders are replaced by a new valid token
  /// %password% placeholders are replaced by a new auto-generated password
  /// %username% placeholders are replaced by the users username
  @Input()
  String recoverPasswordMessageEmail; // = 'token: %token%, username/password: %username% / %password%';

  @Input()
  String recoverPasswordSubjectEmail = 'Recover your password';

  @Input()
  String recoverPasswordFromEmail;

  @Input()
  String recoverPasswordMessageSMS; // = 'token: %token%, username/password: %username% / %password%';

  @Input()
  String recoverPasswordFromSMS;

  @Input()
  String titleImageUrl;

  @Output('login')
  Stream<Map<String, String>> get onLoginOutput => _onLoginController.stream;
}