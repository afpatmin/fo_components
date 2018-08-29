import 'package:angular/angular.dart';
import 'fo_tab_component.dart';

@Component(
  selector: 'fo-tab-panel',
  templateUrl: 'fo_tab_panel_component.html',
  styleUrls: const ['fo_tab_panel_component.css'],
  directives: const [FoTabComponent, NgFor, NgIf],
)
class FoTabPanelComponent {  
  FoTabPanelComponent();

  void onTabClick(FoTabComponent tab) {
    for (final t in tabs) {
      t.active = false;
    }
    tab.active = true;    
  }

  String backgroundColor(FoTabComponent tab) => tab.active ? tab.backgroundColor : 'white';
  String color(FoTabComponent tab) => tab.active ? 'white': tab.labelColor;

  List<FoTabComponent> get tabs => _tabs;

  @ContentChildren(FoTabComponent)
  set tabs(List<FoTabComponent> value) {
    _tabs = value;
    _tabs.first.active = true;
  }

  List<FoTabComponent> _tabs;
}