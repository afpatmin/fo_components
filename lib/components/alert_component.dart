// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library alert_component;

import 'package:angular2/core.dart';
import 'package:fo_components/fo_components.dart' show IconComponent, InfoPopupComponent;

@Component(
    selector: 'fo-alert',
    styleUrls: const ['style/alert_component.css'],
    templateUrl: 'html/alert_component.html',
    preserveWhitespace: false,
    directives: const [IconComponent, InfoPopupComponent],
    changeDetection: ChangeDetectionStrategy.Detached)

class AlertComponent extends ComponentState
{
  AlertComponent();

  @Input('message')
  void set message(String value)
  {
    setState(() => _message = value);
  }

  @Input('title')
  void set title(String value)
  {
    setState(() => _title = value);
  }

  String get message => _message;
  String get title => _title;


  String _message;
  String _title = "Alert";
}
