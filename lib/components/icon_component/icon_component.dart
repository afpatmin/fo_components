// Copyright (c) 2016, Muienog AB. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library icon_component;

import 'package:angular2/angular2.dart';

@Component(
    selector: 'fo-icon',
    styleUrls: const ['icon_component.css'],
    templateUrl: 'icon_component.html',
    preserveWhitespace: false,
    directives: const [],
    changeDetection: ChangeDetectionStrategy.OnPush)

class IconComponent
{
  IconComponent();

  @Input('src')
  String src = "clock";

  @Input('title')
  String title = "Icon";
}