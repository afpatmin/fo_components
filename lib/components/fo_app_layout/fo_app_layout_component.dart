// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular/security.dart' as security;
import 'package:angular_components/angular_components.dart';
import '../../pipes/phrase_pipe.dart';
import '../../services/phrase_service.dart';
import '../fo_modal/fo_modal_component.dart';

@Component(
    selector: 'fo-app-layout',
    styleUrls: ['fo_app_layout_component.css'],
    templateUrl: 'fo_app_layout_component.html',
    directives: [coreDirectives, FoModalComponent, materialDirectives],
    pipes: [PhrasePipe])
class FoAppLayoutComponent implements OnDestroy {
  FoAppLayoutComponent(
      this.router, this.phraseService, this._domSanitizationService) {
    
    router.onRouteActivated.listen((state) { 
      _activeItem = null;
      instructionsUrl = null;

      for (final category in categories) {

        final path = state.path.replaceAll('/', '').replaceAll('#', '');

        _activeItem = category.items
            .firstWhere((i) => i.url == path, orElse: () => null);       

        if (_activeItem != null) {
          instructionsUrl = _activeItem?.instructionsUrl == null
          ? null
          : _domSanitizationService
              .bypassSecurityTrustResourceUrl(_activeItem.instructionsUrl);

          break;
        }
      }
    });
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

  bool isActive(FoSidebarItem item) => item == _activeItem;

  String calcIFrameWidth() => (html.window.innerWidth * 0.6).toString();

  String calcIFrameHeight() =>
      ((html.window.innerWidth * 0.6) * 0.615).round().toString();

  String get sidebarWidth => (expanded) ? '${width}px' : '${miniWidth}px';

  String get pageHeader => _activeItem?.label;
  String get pageIcon => _activeItem?.icon;
  
  /*
  security.SafeResourceUrl get instructionsUrl =>
      _activeItem?.instructionsUrl == null
          ? null
          : _domSanitizationService
              .bypassSecurityTrustResourceUrl(_activeItem.instructionsUrl);
*/
  final PhraseService phraseService;
  bool animating = false;

  bool instructionsModalVisible = false;
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
