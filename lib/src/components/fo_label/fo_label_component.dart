import 'package:angular/angular.dart';

@Component(
    selector: 'fo-label',
    templateUrl: 'fo_label_component.html',
    styleUrls: ['fo_label_component.css'],
    directives: [NgClass, NgIf],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoLabelComponent {
  @Input()
  String? value;
}
