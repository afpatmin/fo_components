import 'package:angular/angular.dart';
import '../../pipes/fo_name_pipe.dart';

@Component(
    selector: 'fo-error-output',
    templateUrl: 'fo_error_output_component.html',
    styleUrls: ['fo_error_output_component.css'],
    directives: [NgIf],
    pipes: [NamePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoErrorOutputComponent {
  FoErrorOutputComponent();

  @Input()
  String message;
}
