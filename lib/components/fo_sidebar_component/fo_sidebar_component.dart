// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController;
import 'dart:html' as dom show MouseEvent;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

@Component(
    selector: 'fo-sidebar',
    styleUrls: const ['fo_sidebar_component.css'],
    templateUrl: 'fo_sidebar_component.html',
    directives: const [materialDirectives]
)
class FoSidebarComponent implements OnDestroy
{
  FoSidebarComponent();

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
  }

  void close()
  {
    _onVisibleChangeController.add(false);
    visible = false;
  }

  final StreamController<bool> _onVisibleChangeController = new StreamController();

  @Input('visible')
  bool visible = false;

  @Input('title')
  String title = "Menu";

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;

  @HostListener('click', const ['\$event'])
  void onHostClick(dom.MouseEvent e)
  {
    close();
  }
}
