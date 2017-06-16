// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Stream, Timer, StreamController, StreamSubscription;
import 'dart:html' as dom;
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

@Component(
    selector: 'fo-sidebar',
    styleUrls: const ['fo_sidebar_component.css'],
    templateUrl: 'fo_sidebar_component.html',
    directives: const [materialDirectives]
)
class FoSidebarComponent implements OnDestroy, OnChanges
{
  FoSidebarComponent();

  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("visible"))
    {
      if (changes["visible"].currentValue == true)
      {
        _onClickListener?.cancel();
        new Timer(const Duration(milliseconds: 100), ()
        {
          _onClickListener = dom.document.onClick.listen((e) => _onVisibleChangeController.add(locked));
        });
      }
    }
  }

  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onClickListener?.cancel();
  }

  void toggleLocked(dom.Event e)
  {
    e.stopPropagation();
    locked = !locked;
    lockIcon = locked ? "lock" : "lock_open";

  }

  final StreamController<bool> _onVisibleChangeController = new StreamController();
  StreamSubscription<dom.Event> _onClickListener;
  String lockIcon = "lock_open";

  @Input('locked')
  bool locked = false;

  @Input('title')
  String title = "Menu";

  @Input('visible')
  bool visible = false;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}
