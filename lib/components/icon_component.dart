// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:angular2/core.dart';

@Component(
    selector: 'fo-icon',
    styleUrls: const ['css/icon_component.css'],
    templateUrl: 'html/icon_component.html',
    preserveWhitespace: false,
    directives: const [IconComponent, SourcedDirective, TitledDirective])

class IconComponent
{
  IconComponent();
  @Input() String foSrc = "clock";
  @Input() String foTitle = "Icon";
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