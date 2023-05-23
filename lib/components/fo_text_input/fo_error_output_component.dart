import 'package:ngdart/angular.dart';
import '../../pipes/capitalize_pipe.dart';

@Component(
    selector: 'fo-error-output',
    templateUrl: 'fo_error_output_component.html',
    styleUrls: ['fo_error_output_component.css'],
    directives: [NgIf],
    pipes: [CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.onPush)
class FoErrorOutputComponent {
  FoErrorOutputComponent();

  @Input()
  late String message;
}
