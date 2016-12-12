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
    directives: const [SourcedDirective],
    changeDetection: ChangeDetectionStrategy.Detached)

class IconComponent extends ComponentState
{
  IconComponent();
  @Input() set src(String value)
  {
    setState(() => _src = value);
  }

  @Input() set title(String value)
  {
    setState(() => _title = value);
  }

  String get src => _src;
  String get title => _title;

  String _src = "clock";
  String _title = "Icon";
}

@Directive(selector: '[sourced]')
class SourcedDirective implements OnInit
{
  SourcedDirective(ElementRef element) : _host = element.nativeElement;

  void ngOnInit()
  {
    _host.setAttributeNS("http://www.w3.org/1999/xlink", "href", "gfx/icons/icons.svg#icon-" + src);
  }

  @Input('src')
  String src;

  Element _host;
}