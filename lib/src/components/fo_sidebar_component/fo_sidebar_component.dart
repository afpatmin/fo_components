// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fo_components/fo_components.dart';

@Component(
    selector: 'fo-sidebar',
    styleUrls: const ['fo_sidebar_component.css'],
    templateUrl: 'fo_sidebar_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives, ROUTER_DIRECTIVES],
    pipes: const [PhrasePipe]
)
class FoSidebarComponent implements OnInit, OnDestroy
{
  FoSidebarComponent(this._router);

  void ngOnInit()
  {
    setHeaderIcon("index.html");
    _onStartNavigationListener = _router.onStartNavigation.listen(setHeaderIcon);
  }

  void setHeaderIcon(String event)
  {
    if (_router.currentInstruction != null)
    {
      for (FoSidebarCategory category in categories)
      {
        FoSidebarItem item = category.items.firstWhere((item) => item.url == event, orElse: () => null);
        if (item != null) pageIcon = item.icon;
      }
    }
  }

  void ngOnDestroy()
  {
    _onExpandedChangeController.close();
    _onStartNavigationListener.cancel();
  }

  void toggleExpanded()
  {
    expanded = !expanded;

    animating = true;
    new Timer(const Duration(milliseconds: 100), () => animating = false);

    _onExpandedChangeController.add(expanded);
  }

  String get sidebarWidth => (expanded) ? "${width}px" : "${miniWidth}px";

  String get pageHeader => (_router.currentInstruction == null) ? "" : _router.currentInstruction.path;

  final Router _router;
  bool animating = false;
  String pageIcon = "";
  final StreamController<bool> _onExpandedChangeController = new StreamController();
  StreamSubscription<String> _onStartNavigationListener;
  final int miniWidth = 40;

  @Input('backgroundColor')
  String backgroundColor = "#666";

  @Input('header')
  String header = "Menu";

  @Input('expanded')
  bool expanded = false;

  @Input('width')
  int width = 200;

  @Input('categories')
  List<FoSidebarCategory> categories = new List();

  @Output('expandedChange')
  Stream<bool> get onExpandedChangeOutput => _onExpandedChangeController.stream;
}

class FoSidebarCategory
{
  FoSidebarCategory(this.title, this.items);

  final List<FoSidebarItem> items;
  final String title;
}

class FoSidebarItem
{
  FoSidebarItem(this.url, this.label, this.routerLink, this.icon);

  final String url;
  final String label;
  final String routerLink;
  final String icon;
}
