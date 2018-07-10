// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:vi_auth_client/vi_auth_client.dart';
import '../../services/fo_messages_service.dart';
import '../fo_modal/fo_modal_component.dart';

@Component(
    selector: 'fo-login',
    styleUrls: const ['fo_login_component.css'],
    templateUrl: 'fo_login_component.html',
    directives: const [NgIf, materialInputDirectives, MaterialButtonComponent, FoModalComponent],
    pipes: const [])
class FoLoginComponent implements OnInit, OnDestroy {
  FoLoginComponent(this.msg) {
    state = msg.login();
  }

  @override
  void ngOnInit() {
    if (client != null &&
        Uri.base.queryParameters.containsKey('token') &&
        Uri.base.queryParameters.containsKey('username')) {
      _tryLoginToken(Uri.decodeFull(Uri.base.queryParameters['username']),
          Uri.base.queryParameters['token']);
    }
  }

  @override
  void ngOnDestroy() {
    _onLoginController.close();
  }

  Future onLogin() async {
    try {
      errorMessage = null;
      final token = await client.loginWithUsernamePassword(username, password);
      _onLoginController.add({'username': username, 'token': token});
      visible = false;
    } on Exception {
      errorMessage = 'invalid_details';
    }
  }

  void onKeyUp(html.KeyboardEvent e) {
    if (username.isNotEmpty &&
        password.isNotEmpty &&
        (e.keyCode == html.KeyCode.ENTER ||
            e.keyCode == html.KeyCode.MAC_ENTER)) {
      onLogin();
    }
  }

  void onRecoverPasswordKeyUp(html.KeyboardEvent e) {
    if (e.keyCode == html.KeyCode.ENTER ||
        e.keyCode == html.KeyCode.MAC_ENTER) {
      onRecoverPassword();
    }
  }

  Future onRecoverPassword() async {
    if (username.isNotEmpty) {
      errorMessage = null;
      try {
        await client.sendCredentials(username,
            emailFrom: recoverPasswordFromEmail,
            emailMessage: recoverPasswordMessageEmail,
            emailSubject: recoverPasswordSubjectEmail,
            smsMessage: recoverPasswordMessageSMS,
            smsFrom: recoverPasswordFromSMS);

        recoverPasswordSent = true;
        state = msg.reset_password();
      } on Exception catch (e, s) {
        print(s);
        errorMessage = e.toString();
      }
    }
  }

  Future onUpdatePassword() async {
    try {
      errorMessage = null;
      await client.updatePassword(username, password, token);
      token = '';
      setState(msg.login());
    } on Exception catch (e, s) {
      print(s);
      errorMessage = e.toString();
    }
  }

  void setState(String newState) {
    state = newState;
    recoverPasswordSent = false;
    errorMessage = null;
  }

  Future _tryLoginToken(String username, String token) async {
    try {
      visible = false;
      final newToken = await client.loginWithToken(token);
      _onLoginController.add({'username': username, 'token': newToken});
    } on Exception catch (e) {
      print(e.toString());
      visible = true;
    }
  }

  String token = '';

  String state;
  String errorMessage;
  bool recoverPasswordSent = false;
  bool visible = true;
  final FoMessagesService msg;
  final StreamController<Map<String, String>> _onLoginController =
      new StreamController();

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
  // = 'token: %token%, username/password: %username% / %password%';
  @Input()
  String recoverPasswordMessageEmail;

  @Input()
  String recoverPasswordSubjectEmail = 'Recover your password';

  @Input()
  String recoverPasswordFromEmail;

  // = 'token: %token%, username/password: %username% / %password%';
  @Input()
  String recoverPasswordMessageSMS;

  @Input()
  String recoverPasswordFromSMS;

  @Input()
  String titleImageUrl;

  @Input()
  String altUrl;

  @Input()
  String altUrlTitle;

  @Output('login')
  Stream<Map<String, String>> get onLoginOutput => _onLoginController.stream;
}
