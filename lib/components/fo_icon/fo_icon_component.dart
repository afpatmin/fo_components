import 'package:angular/angular.dart';

/*
 * Make sure to have copied the resources in 
 * fo_icon/fonts to your project and imported 
 * the icomoon font in your style.css
 *
 * @font-face {
    font-family: 'icomoon';
    src: url('fonts/icomoon.eot?xf6dd5');
    src: url('fonts/icomoon.eot?xf6dd5#iefix') format('embedded-opentype'), url('fonts/icomoon.ttf?xf6dd5') format('truetype'), url('fonts/icomoon.woff?xf6dd5') format('woff'), url('fonts/icomoon.svg?xf6dd5#icomoon') format('svg');
    font-weight: normal;
    font-style: normal;
}
*/
@Component(
  selector: 'fo-icon',
  templateUrl: 'fo_icon_component.html',
  styleUrls: const ['fo_icon_component.css'],
  directives: const [NgStyle],
  changeDetection: ChangeDetectionStrategy.OnPush
)
class FoIconComponent {

  String get iconClass => 'icon-$icon';

  @Input()
  String size = '1em';

  @Input()
  String icon;
}