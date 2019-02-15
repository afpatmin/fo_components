import 'package:angular/angular.dart';
import 'fo_dropdown_option.dart';

@Component(
  selector: 'fo-dropdown-option',
  templateUrl: 'fo_dropdown_option_component.html',
  styleUrls: const ['fo_dropdown_option_component.css'],
  directives: const [],
)
class FoDropdownOptionComponent {

  @Input()
  FoDropdownOption model;
}