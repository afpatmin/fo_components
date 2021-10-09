import 'package:angular/angular.dart';
import '../fo_icon/fo_icon_component.dart';
import 'fo_dropdown_option.dart';

@Component(
    selector: 'fo-dropdown-option',
    templateUrl: 'fo_dropdown_option_component.html',
    styleUrls: ['fo_dropdown_option_component.css'],
    directives: [FoIconComponent, NgClass, NgIf],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoDropdownOptionComponent {
  @Input()
  FoDropdownOption? model;

  @Input()
  bool materialIcon = true;
}
