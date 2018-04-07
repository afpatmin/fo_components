// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular/security.dart' as security;
import 'package:angular_components/angular_components.dart';
import '../../pipes/phrase_pipe.dart';
import '../../services/phrase_service.dart';
import '../fo_modal/fo_modal_component.dart';

@Component(
    selector: 'fo-app-layout',
    styleUrls: const ['fo_app_layout_component.css'],
    templateUrl: 'fo_app_layout_component.html',
    directives: const [coreDirectives, FoModalComponent, materialDirectives],
    pipes: const [PhrasePipe],
    visibility: Visibility.local)
class FoAppLayoutComponent implements OnInit, OnDestroy {
  FoAppLayoutComponent(this.phraseService, this._domSanitizationService);

  @override
  void ngOnInit() {
    if (categories.isNotEmpty && categories.first.items.isNotEmpty) {
      pageIcon = categories.first.items.first.icon;
      pageHeader = categories.first.items.first.label;
    }
  }

  @override
  void ngOnDestroy() {
    _onExpandedChangeController.close();
    _onNavigateController.close();
    _onInstructionsCloseController.close();
  }

  void onNavigate(FoSidebarItem item) {
    _activeItem = item;
    pageIcon = item.icon;
    pageHeader = item.label;
    instructionsUrl = item.instructionsUrl == null
        ? null
        : _domSanitizationService
            .bypassSecurityTrustResourceUrl(item.instructionsUrl);
    _onNavigateController.add(item.url);
  }

  void toggleExpanded() {
    expanded = !expanded;

    animating = true;
    new Timer(const Duration(milliseconds: 100), () => animating = false);

    _onExpandedChangeController.add(expanded);
  }

  void onInstructionsModalVisibleChange(bool visible) {
    if (!visible) {
      _onInstructionsCloseController.add(instructionsUrl.toString());
    }
    instructionsModalVisible = visible;
  }

  bool isActive(FoSidebarItem item) => item == _activeItem;

  String calcIFrameWidth() => (html.window.innerWidth * 0.6).toString();

  String calcIFrameHeight() =>
      ((html.window.innerWidth * 0.6) * 0.615).round().toString();

  String get sidebarWidth => (expanded) ? '${width}px' : '${miniWidth}px';

  final PhraseService phraseService;
  bool animating = false;
  String pageHeader = '';
  String pageIcon = '';
  security.SafeResourceUrl instructionsUrl;
  bool instructionsModalVisible = false;
  final security.DomSanitizationService _domSanitizationService;
  final StreamController<bool> _onExpandedChangeController =
      new StreamController();
  final StreamController<String> _onNavigateController =
      new StreamController();
  final StreamController<String> _onInstructionsCloseController = new StreamController();
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
  // ignore: avoid_setters_without_getters
  set instructions(String value) {
    if (value == null) {
      instructionsUrl = null;
      instructionsModalVisible = false;
    }
    else {
      instructionsUrl = _domSanitizationService
          .bypassSecurityTrustResourceUrl(value);
      instructionsModalVisible = true;
    }
  }

  @Output('instructionsClose')
  Stream<String> get instructionsClose => _onInstructionsCloseController.stream;

  @Output('expandedChange')
  Stream<bool> get onExpandedChangeOutput => _onExpandedChangeController.stream;

  @Output('navigate')
  Stream<String> get onNavigateOutput => _onNavigateController.stream;
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
