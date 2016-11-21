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
  InfoPopupComponent()
      : _isConfirm = false, _isOpen = false;

  bool get isConfirm => _isConfirm;
  bool get isOpen => _isOpen;
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

  @Input('foIsConfirm') set isConfirm(bool flag)
  {
    setState(() => _isConfirm = flag);
  }

  void open(html.Event e)
  {
    setState(() => _isOpen = true);
  }

  void onOk()
  {
    if (_isConfirm) userResponse.emit(true);
    setState(() => _isOpen = false);
  }

  void onCancel()
  {
    if (_isConfirm) userResponse.emit(false);
    setState(() => _isOpen = false);
  }

  @Output('userResponse')
  final EventEmitter<bool> userResponse = new EventEmitter();

  bool _isOpen;
  bool _isConfirm;

  String _title = "Information";
  String _text = "";
}
