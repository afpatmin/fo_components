import 'package:angular/angular.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'fo_dropdown_option.dart';

@Component(
  selector: 'fo-dropdown-option',
  templateUrl: 'fo_dropdown_option_component.html',
  styleUrls: ['fo_dropdown_option_component.css'],
  directives: [MaterialIconComponent, NgIf],
)
class FoDropdownOptionComponent {
  @Input()
  FoDropdownOptionRenderable model;
}
