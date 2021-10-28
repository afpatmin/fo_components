import 'package:angular/angular.dart';
import 'package:fo_components/components/fo_icon/fo_icon_component.dart';

@Component(
  selector: 'fo-chip',
  templateUrl: 'fo_chip_component.html',
  styleUrls: ['fo_chip_component.css'],
  directives: [coreDirectives, FoIconComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoChipComponent {
  // Add name/tag to chip
  @Input()
  String? name = 'Chip';

  String myCloseIcon = 'close-outline';
}
