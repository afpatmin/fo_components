import 'package:angular/angular.dart';

@Component(
    selector: 'fo-label',
    templateUrl: 'fo_label_component.html',
    styleUrls: ['fo_label_component.css'],
    directives: [NgClass, NgIf])
class FoLabelComponent {
  @Input()
  String value;

  @Input()
  bool error = false;
}
