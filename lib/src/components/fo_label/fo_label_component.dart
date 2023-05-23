import 'package:ngdart/angular.dart';

@Component(
    selector: 'fo-label',
    templateUrl: 'fo_label_component.html',
    styleUrls: ['fo_label_component.css'],
    directives: [NgClass, NgIf],
    changeDetection: ChangeDetectionStrategy.onPush)
class FoLabelComponent {
  @Input()
  String? value;
}
