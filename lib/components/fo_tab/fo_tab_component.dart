import 'dart:html' as dom;
import 'package:angular/angular.dart';

@Component(
    selector: 'fo-tab',
    templateUrl: 'fo_tab_component.html',
    styleUrls: ['fo_tab_component.css'],
    directives: [NgClass],
    changeDetection: ChangeDetectionStrategy.Default)
class FoTabComponent {
  FoTabComponent(this._host);

  set active(bool value) {
    _active = value;
    _host.style.display = _active ? '' : 'none';
  }

  bool get active => _active;

  bool _active = false;

  @Input()
  String? label;

  @Input()
  String? icon;

  @Input()
  String? labelColor;

  @Input()
  String? backgroundColor;

  final dom.Element _host;
}
