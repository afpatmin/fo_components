import 'package:angular/angular.dart';
import 'package:fo_components/src/components/fo_label/fo_label_component.dart';

@Component(
  selector: 'fo-load-indicator',
  templateUrl: 'fo_load_indicator_component.html',
  styleUrls: ['fo_load_indicator_component.css'],
  directives: [FoLabelComponent, NgIf],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoLoadIndicatorComponent {
  @Input()
  String label = '';
}
