import 'package:angular/angular.dart';

/// Description ...........
@Component(
  selector: 'fo-time-picker',
  templateUrl: 'fo_time_picker_component.html',
  styleUrls: ['fo_time_picker_component.css'],
  directives: [coreDirectives],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoTimePickerComponent {
  String time = '';
  String name = 'OK';
  String inputType = 'button';

  dynamic chosenTime() {
    time = 'Chosen time goes here';
  }
}
