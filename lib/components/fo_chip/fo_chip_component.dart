import 'package:angular/angular.dart';

@Component(
  selector: 'fo-chip',
  templateUrl: 'fo_chip_component.html',
  styleUrls: ['fo_chip_component.css'],
  directives: [coreDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoChipComponent {
  // Add name/tag to chip
  @Input()
  String? name = 'Chip';
}
