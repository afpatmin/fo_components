// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library info_popup_component;
import 'dart:html' as html show Event;

import 'package:angular2/core.dart';
import 'package:fo_components/components/icon_component.dart';

@Component(
    selector: 'fo-info-popup',
    styleUrls: const ['style/info_popup_component.css'],
    templateUrl: 'html/info_popup_component.html',
    preserveWhitespace: false,
    directives: const [IconComponent])

class InfoPopupComponent extends ComponentState
{
  InfoPopupComponent();

  bool get foIsOpen => _foIsOpen;
  String get text => _text;
  String get title => _title;
  String get titleWidth => "${_title.length * 1.5}em";

  @Input('foText') set text(String value)
  {
    setState(() => _text = value);
  }

  @Input('foTitle') set title(String value)
  {
    setState(() => _title = value);
  }

  void close()
  {
    setState(() => _foIsOpen = false);
  }

  void open(html.Event e)
  {
    setState(() => _foIsOpen = true);
  }

  void onOk()
  {
    print("OK");
    close();
  }

  void onCancel()
  {
    print("CANCEL");
    close();
  }

  bool _foIsOpen = false;
  String _title = "Information";
  String _text;
}
