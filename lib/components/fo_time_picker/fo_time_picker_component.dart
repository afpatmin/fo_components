import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../src/components/fo_label/fo_label_component.dart';
import 'time.dart';

/// Description ...........
@Component(
  selector: 'fo-time-picker',
  templateUrl: 'fo_time_picker_component.html',
  styleUrls: ['fo_time_picker_component.css'],
  directives: [coreDirectives, formDirectives, FoLabelComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoTimePickerComponent {
  int? hour;

  int? minute;
  final StreamController<Time> _controller = StreamController<Time>();

  @Input()
  String label = 'Pick a time';

  @Input()
  set time(Time? t) {
    if (t == null) {
      hour = null;
      minute = null;
    } else {
      hour = t.hour;
      minute = t.minute;
    }
  }

  @Output('timeChange')
  Stream<Time> get timeChange => _controller.stream;

  void onHourChange(int hr) {
    hour = hr;
    _controller.add(Time(hour: hour!, minute: minute!));
  }

  void onMinuteChange(int min) {
    minute = min;
    _controller.add(Time(hour: hour!, minute: minute!));
  }
}
