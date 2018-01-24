// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular/security.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import '../../pipes/phrase_pipe.dart';
import '../../services/phrase_service.dart';
import '../fo_modal_component/fo_modal_component.dart';

@Component(
    selector: 'fo-sidebar',
    styleUrls: const ['fo_sidebar_component.scss.css'],
    templateUrl: 'fo_sidebar_component.html',
    directives: const [CORE_DIRECTIVES, FoModalComponent, materialDirectives, ROUTER_DIRECTIVES],
    providers: const [],
    pipes: const [PhrasePipe],
    visibility: Visibility.none
)
class FoSidebarComponent implements OnInit, OnDestroy
{
  FoSidebarComponent(this.phraseService, this._router, this._domSanitationService);

  void ngOnInit()
  {
    new Timer(const Duration(milliseconds: 500), () => _onNavigate("index.html"));
    _onStartNavigationListener = _router.onStartNavigation.listen(_onNavigate);
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

  void _onNavigate(String event)
  {
    if (_router.currentInstruction != null)
    {
      if (event.startsWith("#/")) event = event.substring("#/".length);
      if (event.endsWith("/")) event = event.substring(0, event.length - 1);

      for (FoSidebarCategory category in categories)
      {
        for (FoSidebarItem item in category.items)
        {
          if (item.url == event)
          {
            pageIcon = item.icon;
            pageHeader = item.label;
            instructionsUrl = item.instructionsUrl == null ? null : _domSanitationService.bypassSecurityTrustResourceUrl(item.instructionsUrl);
            return;
          }
        }
      }
    }
  }

  String calcIFrameWidth()
  {
    return (html.window.innerWidth * 0.7).toString();
  }

  String calcIFrameHeight()
  {
    return ((html.window.innerWidth * 0.7) * 0.615).round().toString();
  }

  String get sidebarWidth => (expanded) ? "${width}px" : "${miniWidth}px";

  final PhraseService phraseService;
  final Router _router;
  final DomSanitizationService _domSanitationService;
  bool animating = false;
  String pageHeader = "";
  String pageIcon = "";
  SafeResourceUrl instructionsUrl;
  bool instructionsModalVisible = false;
  final StreamController<bool> _onExpandedChangeController = new StreamController();
  StreamSubscription<String> _onStartNavigationListener;
  final int miniWidth = 40;

  @Input('backgroundColor')
  String backgroundColor = "#666";

  @Input('header')
  String header = "Menu";

  @Input('paddingTop')
  String paddingTop = "100px";

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
  String title;
}

class FoSidebarItem
{
  FoSidebarItem(this.url, this.label, this.routerLink, this.routeParams, this.icon, [this.instructionsUrl = null]);

  final String url;
  String label;
  final String routerLink;
  final Map<String, String> routeParams;
  final String icon;
  final String instructionsUrl;
}
