import 'package:angular/angular.dart';

import 'package:fo_components/components/fo_text_input/fo_text_input_component.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'fo-chip',
  templateUrl: 'fo_chip_component.html',
  styleUrls: ['fo_chip_component.css'],
  directives: [coreDirectives, FoTextInputComponent, formDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoChipComponent {
  // Add name/tag to chip
  @Input()
  String? name = 'Chip';
}
