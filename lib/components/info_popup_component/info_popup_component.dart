// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library info_popup_component;
import 'dart:async';
import 'dart:html' as html;

import 'package:angular2/core.dart';
import 'package:fo_components/components/icon_component/icon_component.dart';

@Component(
    selector: 'fo-info-popup',
    styleUrls: const ['info_popup_component.css'],
    templateUrl: 'info_popup_component.html',
    preserveWhitespace: false,
    directives: const [IconComponent],
    changeDetection: ChangeDetectionStrategy.OnPush)

class InfoPopupComponent extends ComponentState
{
  InfoPopupComponent()
      : _isConfirm = false, _isOpen = false, _isReallyOpen = false;

  bool get isConfirm => _isConfirm;
  bool get isOpen => _isOpen;
  bool get isReallyOpen => _isReallyOpen;
  String get text => _text;
  String get title => _title;
  String get titleWidth => "${_title.length * 1.5}em";

  @Input('isConfirm') set isConfirm(bool flag)
  {
    setState(() => _isConfirm = flag);
  }

  void open(html.MouseEvent e, String text, String title)
  {
    setState(()
    {
      _isOpen = true;
      _text = text;
      _title = title;

      new Timer(const Duration(milliseconds: 100), () { setState(() { _isReallyOpen = true; }); });
    });
  }

  void onOk()
  {
    response.emit(true);
    setState(()
    {
      _isReallyOpen = false;
      new Timer(const Duration(milliseconds: 300), () { setState(() => _isOpen = false); });
    });
  }

  void onCancel()
  {
    response.emit(false);
    setState(()
    {
      _isReallyOpen = false;
      new Timer(const Duration(milliseconds: 300), () { setState(() => _isOpen = false); });
    });
  }

  @Output('response')
  final EventEmitter<bool> response = new EventEmitter();

  bool _isReallyOpen;
  bool _isOpen;
  bool _isConfirm;

  String _title;
  String _text;
}
