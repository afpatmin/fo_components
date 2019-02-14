import 'package:angular/angular.dart';
import 'package:angular_components/material_icon/material_icon.dart';

@Component(
    selector: 'fo-text-input',
    templateUrl: 'fo_text_input_component.html',
    styleUrls: const ['fo_text_input_component.css'],
    directives: const [MaterialIconComponent, NgClass, NgIf],
    pipes: const [],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoTextInputComponent { 
  @Input()
  String label;

  @Input()
  String leadingIcon; // material icon id
}
