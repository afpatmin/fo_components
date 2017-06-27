// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, StreamController, StreamSubscription;
import 'dart:html' as dom;
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
  FoSidebarComponent()
  {
    _onWindowClickListener = dom.document.onClick.listen((e)
    {
      if (visible && !locked) visible = locked = false;

      _onVisibleChangeController.add(visible);
    });
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onWindowClickListener.cancel();
  }

  void toggleLocked(dom.Event e)
  {
    e.stopPropagation();
    locked = !locked;
  }

  void toggleOpen(dom.Event e)
  {
    e.stopPropagation();
    visible = !visible;

    /// Can't be locked and not visible
    if (!visible) locked = false;

    _onVisibleChangeController.add(visible);
  }

  final StreamController<bool> _onVisibleChangeController = new StreamController();
  StreamSubscription<dom.Event> _onWindowClickListener;

  @Input('backgroundColor')
  String backgroundColor = "#666";

  @Input('locked')
  bool locked = false;

  @Input('title')
  String title = "Menu";

  @Input('visible')
  bool visible = false;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}
