// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../pipes/fo_name_pipe.dart';
import '../../services/fo_messages_service.dart';
import '../fo_modal/fo_modal_component.dart';

class LoginEvent {
  String username;
  String password;
}

class UpdatePasswordEvent {
  String username;
  String password;
  String token;
}

@Component(
    selector: 'fo-login',
    styleUrls: const ['fo_login_component.css'],
    templateUrl: 'fo_login_component.html',
    directives: const [      
      NgIf,
      materialInputDirectives,
      MaterialButtonComponent,
      FoModalComponent
    ],
    pipes: const [NamePipe])
class FoLoginComponent implements OnDestroy {
  FoLoginComponent(this.msg) : stateLabels = {
    'forgot_password': msg.forgot_password(),
    'login': msg.login(),
    'reset_password': msg.reset_password(),
    } {
    state = 'login';    
  }

  @override
  void ngOnDestroy() {
    _onLoginController.close();
    _onRecoverPasswordController.close();
    _onUpdatePasswordController.close();
  }

  void onLogin() {
    _onLoginController.add(new LoginEvent()
      ..username = username
      ..password = password);
  }

  void onRecoverPassword() {
    _onRecoverPasswordController.add(username);   
  }

  void onUpdatePassword() {
    _onUpdatePasswordController.add(new UpdatePasswordEvent()
      ..username = username
      ..password = password
      ..token = token);
    state = 'login';
  }

  void onLoginKeyUp(html.KeyboardEvent e) {
    if (username?.isNotEmpty == false &&
        password?.isNotEmpty != false &&
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

  String token = '';
  
  bool visible = true;
  final FoMessagesService msg;
  final StreamController<LoginEvent> _onLoginController =
      new StreamController();
  final StreamController<String> _onRecoverPasswordController =
      new StreamController();
  final StreamController<UpdatePasswordEvent> _onUpdatePasswordController =
      new StreamController();

  final Map<String, String> stateLabels;

  @Input()
  String username;

  @Input()
  String password;

  @Input()
  String errorMessage;

  @Input()
  bool showForgotPassword = true;

  @Input()
  String label;

  @Input()
  String state;

  @Input()
  String titleImageUrl;

  @Input()
  String altUrl;
 
  @Input()
  String altUrlTitle;

  @Input()
  bool loading = false;

  @Output('login')
  Stream<LoginEvent> get onLoginOutput => _onLoginController.stream;

  @Output('recoverPassword')
  Stream<String> get onRecoverPasswordOutput =>
      _onRecoverPasswordController.stream;

  @Output('updatePassword')
  Stream<UpdatePasswordEvent> get onUpdatePasswordOutput =>
      _onUpdatePasswordController.stream;
}
