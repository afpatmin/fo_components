import 'package:angular/angular.dart';
import 'package:angular_components/material_icon/material_icon.dart';

/// An icon component. Make sure to have imported the icomoon font and style into your project.
@Component(
    selector: 'fo-icon',
    templateUrl: 'fo_icon_component.html',
    styleUrls: ['fo_icon_component.css'],
    directives: [MaterialIconComponent, NgIf, NgStyle],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoIconComponent {
  String get iconClass => 'icon-$icon';

  @Input()
  String size = '1em';

  @Input()
  String icon;

  /// If this flag is set, fo_icon uses material icon instead
  @Input()
  bool material = false;
}
