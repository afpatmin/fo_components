// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular/security.dart' as security;
import 'package:angular_components/angular_components.dart';
import 'package:intl/intl.dart';
import '../../pipes/fo_name_pipe.dart';
import '../fo_modal/fo_modal_component.dart';

@Component(
    selector: 'fo-app-layout',
    styleUrls: ['fo_app_layout_component.css'],
    templateUrl: 'fo_app_layout_component.html',
    directives: [
      coreDirectives,
      FoModalComponent,
      MaterialIconComponent,
      MaterialListComponent,
      MaterialListItemComponent,
      MaterialTooltipDirective,
      routerDirectives
    ],
    pipes: [NamePipe])
class FoAppLayoutComponent implements OnDestroy {
  FoAppLayoutComponent(this.router, this._domSanitizationService) {
    router.onRouteActivated.listen(_onRouteActivated);
  }

  @override
  void ngOnDestroy() {
    _onExpandedChangeController.close();
  }

  void toggleExpanded() {
    expanded = !expanded;

    animating = true;
    new Timer(const Duration(milliseconds: 100), () => animating = false);

    _onExpandedChangeController.add(expanded);
  }

  String instructions() => Intl.message('Instruktioner');

  bool isActive(FoSidebarItem item) => item == _activeItem;

  String calcIFrameWidth() => (html.window.innerWidth * 0.6).toString();

  String calcIFrameHeight() =>
      ((html.window.innerWidth * 0.6) * 0.615).round().toString();

  void _onRouteActivated(RouterState state) {
    _activeItem = null;

    final path = state.path.replaceAll('/', '').replaceAll('#', '');
    if (path == null || path.isEmpty) return;

    for (final category in categories) {
      _activeItem =
          category.items.firstWhere((i) => i.url == path, orElse: () => null);

      if (_activeItem == null) {
        instructionsUrl = null;
      } else {
        instructionsUrl = _activeItem?.instructionsUrl == null
            ? null
            : _domSanitizationService
                .bypassSecurityTrustResourceUrl(_activeItem.instructionsUrl);
        break;
      }
    }
  }

  String get sidebarWidth => (expanded) ? '${width}px' : '${miniWidth}px';

  String get pageHeader => _activeItem?.label;
  String get pageIcon => _activeItem?.icon;

  bool animating = false;

  final security.DomSanitizationService _domSanitizationService;
  final Router router;
  final StreamController<bool> _onExpandedChangeController =
      new StreamController();
  final int miniWidth = 40;
  FoSidebarItem _activeItem;

  @Input()
  String backgroundColor = '#666';

  @Input()
  String header = 'Menu';

  @Input()
  String paddingTop = '100px';

  @Input()
  bool expanded = false;

  @Input()
  int width = 200;

  @Input()
  List<FoSidebarCategory> categories = <FoSidebarCategory>[];

  @Input()
  security.SafeResourceUrl instructionsUrl;

  @Input()
  bool instructionsModalVisible = false;

  @Output('expandedChange')
  Stream<bool> get onExpandedChangeOutput => _onExpandedChangeController.stream;
}

class FoSidebarCategory {
  FoSidebarCategory(this.title, this.items);

  final List<FoSidebarItem> items;
  String title;
}

class FoSidebarItem {
  FoSidebarItem(this.url, this.label, this.icon, [this.instructionsUrl]);

  final String url;
  String label;
  final String icon;
  final String instructionsUrl;
}
