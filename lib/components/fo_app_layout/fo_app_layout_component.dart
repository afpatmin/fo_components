// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular/security.dart';
import 'package:angular_components/angular_components.dart';
import '../../pipes/phrase_pipe.dart';
import '../../services/phrase_service.dart';
import '../fo_modal/fo_modal_component.dart';

@Component(
    selector: 'fo-sidebar',
    styleUrls: const ['fo_app_layout_component.scss.css'],
    templateUrl: 'fo_app_layout_component.html',
    directives: const [CORE_DIRECTIVES, FoModalComponent, materialDirectives],
    providers: const [],
    pipes: const [PhrasePipe],
    visibility: Visibility.local
)
class FoAppLayoutComponent implements OnDestroy
{
  FoAppLayoutComponent(this.phraseService, this._domSanitationService);

  @override
  void ngOnDestroy()
  {
    _onExpandedChangeController.close();
    _onNavigateController.close();
  }

  void onNavigate(FoSidebarItem item)
  {
    print(item.label);
    _onNavigateController.add(item.url);
  }

  void toggleExpanded()
  {
    expanded = !expanded;

    animating = true;
    new Timer(const Duration(milliseconds: 100), () => animating = false);

    _onExpandedChangeController.add(expanded);
  }

  String calcIFrameWidth() => (html.window.innerWidth * 0.7).toString();

  String calcIFrameHeight() => ((html.window.innerWidth * 0.7) * 0.615).round().toString();

  String get sidebarWidth => (expanded) ? '${width}px' : '${miniWidth}px';

  final PhraseService phraseService;
  final DomSanitizationService _domSanitationService;
  bool animating = false;
  String pageHeader = '';
  String pageIcon = '';
  SafeResourceUrl instructionsUrl;
  bool instructionsModalVisible = false;
  final StreamController<bool> _onExpandedChangeController = new StreamController<bool>();
  final StreamController<String> _onNavigateController = new StreamController<String>();
  final int miniWidth = 40;

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
  List<FoSidebarCategory> categories =  <FoSidebarCategory>[];

  @Output('expandedChange')
  Stream<bool> get onExpandedChangeOutput => _onExpandedChangeController.stream;

  @Output('navigate')
  Stream<String> get onNavigateOutput => _onNavigateController.stream;
}

class FoSidebarCategory
{
  FoSidebarCategory(this.title, this.items);

  final List<FoSidebarItem> items;
  String title;
}

class FoSidebarItem
{
  FoSidebarItem(this.url, this.label, this.icon, [this.instructionsUrl]);

  final String url;
  String label;
  final String icon;
  final String instructionsUrl;
}
