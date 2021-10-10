import 'package:angular/angular.dart';

/// An icon component. Make sure to have imported the icomoon font and style into your project.
@Component(
    selector: 'fo-icon',
    templateUrl: 'fo_icon_component.html',
    styleUrls: ['fo_icon_component.css'],
    directives: [NgFor, NgIf, NgStyle],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoIconComponent implements AfterChanges {
  String get iconClass => 'icon-$icon';

  @Input()
  String size = '1em !important';

  @Input()
  String? icon;

  /// If this flag is set, fo_icon uses material icon instead
  @Input()
  bool material = false;

  List<String> subPaths = [];

  @override
  void ngAfterChanges() {
    subPaths = List.generate(16, (i) => 'path${i + 1}', growable: false);
  }
}
