// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library icon_component;

import 'dart:html';
import 'package:angular2/core.dart';

@Component(
    selector: 'fo-icon',
    styleUrls: const ['style/icon_component.css'],
    templateUrl: 'html/icon_component.html',
    preserveWhitespace: false,
    directives: const [SourcedDirective, TitledDirective],
    changeDetection: ChangeDetectionStrategy.Detached)

class IconComponent extends ComponentState
{
  IconComponent();
  @Input() set foSrc(String value)
  {
    setState(() => _foSrc = value);
  }

  @Input() set foTitle(String value)
  {
    setState(() => _foTitle = value);
  }

  String get foSrc => _foSrc;
  String get foTitle => _foTitle;

  String _foSrc = "clock";
  String _foTitle = "Icon";
}

@Directive(selector: '[foSourced]')
class SourcedDirective implements OnInit
{
  SourcedDirective(ElementRef element) : _host = element.nativeElement;

  void ngOnInit()
  {
    _host.setAttributeNS("http://www.w3.org/1999/xlink", "href", "gfx/icons/icons.svg#icon-" + src);
  }

  @Input('foSrc')
  String src;

  Element _host;
}

@Directive(selector: '[foTitled]')
class TitledDirective implements OnInit
{
  TitledDirective(ElementRef element) : _host = element.nativeElement;

  void ngOnInit()
  {
    _host.title = title;
    _host.setAttribute("aria-label", title);
  }

  @Input('foTitle')
  String title;

  Element _host;
}