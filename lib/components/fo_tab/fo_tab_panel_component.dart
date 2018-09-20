import 'package:angular/angular.dart';
import '../fo_icon/fo_icon_component.dart';
import 'fo_tab_component.dart';

@Component(
  selector: 'fo-tab-panel',
  templateUrl: 'fo_tab_panel_component.html',
  styleUrls: const ['fo_tab_panel_component.css'],
  directives: const [FoIconComponent, FoTabComponent, NgClass, NgFor, NgIf],
)
class FoTabPanelComponent {
  FoTabPanelComponent();

  void onTabClick(FoTabComponent tab) {
    for (final t in tabs) {
      t.active = false;
    }
    tab.active = true;
  }

  String backgroundColor(FoTabComponent tab) =>
      tab.active ? tab.backgroundColor : 'white';
  String color(FoTabComponent tab) => tab.active ? 'white' : tab.labelColor;

  bool hideIcons(String size) => hideIconsOn == null ? false : hideIconsOn.contains(size);
  bool hideLabels(String size) => hideLabelsOn == null ? false : hideLabelsOn.contains(size);

  List<FoTabComponent> get tabs => _tabs;

  @ContentChildren(FoTabComponent)
  set tabs(List<FoTabComponent> value) {
    _tabs = value;
    if (_tabs != null && _tabs.isNotEmpty) {
      _tabs.first.active = true;
    }
  }

  List<FoTabComponent> _tabs;

  @Input()
  List<String> hideIconsOn = [];

  @Input()
  List<String> hideLabelsOn = [];
}
