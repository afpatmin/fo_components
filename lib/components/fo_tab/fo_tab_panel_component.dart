import 'dart:async';

import 'package:angular/angular.dart';

import '../fo_icon/fo_icon_component.dart';
import 'fo_tab_component.dart';

@Component(
  selector: 'fo-tab-panel',
  templateUrl: 'fo_tab_panel_component.html',
  styleUrls: ['fo_tab_panel_component.css'],
  directives: [
    FoIconComponent,
    FoTabComponent,
    NgClass,
    NgFor,
    NgIf,
  ],
  changeDetection: ChangeDetectionStrategy.Default,
)
class FoTabPanelComponent implements AfterChanges, OnDestroy {
  List<FoTabComponent> _tabs = [];

  @Input()
  int tabIndex = 0;

  @Input()
  bool disabled = false;

  @Input()
  List<String> hideIconsOn = [];

  @Input()
  List<String> hideLabelsOn = [];

  final StreamController<int> _tabIndexChangeController = StreamController();
  FoTabPanelComponent();

  @Output('tabIndexChange')
  Stream<int> get tabIndexChange => _tabIndexChangeController.stream;

  List<FoTabComponent> get tabs => _tabs;

  @ContentChildren(FoTabComponent)
  set tabs(List<FoTabComponent> value) {
    _tabs = value;
    _evaluateActiveTab();
  }

  String? backgroundColor(FoTabComponent tab) =>
      tab.active ? tab.backgroundColor : 'white';

  String? color(FoTabComponent tab) => tab.active ? 'white' : tab.labelColor;

  bool hideIcons(String size) => hideIconsOn.contains(size);

  bool hideLabels(String size) => hideLabelsOn.contains(size);

  @override
  void ngOnDestroy() {
    _tabIndexChangeController.close();
  }

  void onTabClick(FoTabComponent tab) {
    if (!disabled) {
      for (final t in tabs) {
        t.active = false;
      }
      tab.active = true;
      _tabIndexChangeController.add(tabs.indexOf(tab));
    }
  }

  @override
  void ngAfterChanges() {
    _evaluateActiveTab();
  }

  void _evaluateActiveTab() {
    if (_tabs.isNotEmpty) {
      for (final tab in tabs) {
        tab.active = false;
      }
      if (tabIndex >= _tabs.length) {
        tabIndex = _tabs.length - 1;
      } else if (tabIndex < 0) {
        tabIndex = 0;
      }
      _tabs[tabIndex].active = true;
    }
  }
}
