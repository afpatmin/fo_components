import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fo_components/components/fo_dropdown_select/fo_dropdown_select_component.dart';

import '../../src/components/fo_label/fo_label_component.dart';
import 'time.dart';

/// Description ...........
@Component(
  selector: 'fo-time-picker',
  templateUrl: 'fo_time_picker_component.html',
  styleUrls: ['fo_time_picker_component.css'],
  directives: [
    coreDirectives,
    formDirectives,
    FoLabelComponent,
    FoDropdownSelectComponent
  ],
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

  Map<String, List<FoDropdownOption>> hourOptions =
      <String, List<FoDropdownOption>>{
    'Hours': [
      FoDropdownOption(0, '00'),
      FoDropdownOption(1, '01'),
      FoDropdownOption(2, '02'),
      FoDropdownOption(3, '03'),
      FoDropdownOption(4, '04'),
      FoDropdownOption(5, '05'),
      FoDropdownOption(6, '06'),
      FoDropdownOption(7, '07'),
      FoDropdownOption(8, '08'),
      FoDropdownOption(9, '09'),
      FoDropdownOption(10, '10'),
      FoDropdownOption(11, '11'),
      FoDropdownOption(12, '12'),
      FoDropdownOption(13, '13'),
      FoDropdownOption(14, '14'),
      FoDropdownOption(15, '15'),
      FoDropdownOption(16, '16'),
      FoDropdownOption(17, '17'),
      FoDropdownOption(18, '18'),
      FoDropdownOption(19, '19'),
      FoDropdownOption(20, '20'),
      FoDropdownOption(21, '21'),
      FoDropdownOption(22, '22'),
      FoDropdownOption(23, '23'),
    ],
  };
  Map<String, List<FoDropdownOption>> minuteOptions =
      <String, List<FoDropdownOption>>{
    'Minutes': [
      FoDropdownOption(0, '00'),
      FoDropdownOption(1, '01'),
      FoDropdownOption(2, '02'),
      FoDropdownOption(3, '03'),
      FoDropdownOption(4, '04'),
      FoDropdownOption(5, '05'),
      FoDropdownOption(6, '06'),
      FoDropdownOption(7, '07'),
      FoDropdownOption(8, '08'),
      FoDropdownOption(9, '09'),
      FoDropdownOption(10, '10'),
      FoDropdownOption(11, '11'),
      FoDropdownOption(12, '12'),
      FoDropdownOption(13, '13'),
      FoDropdownOption(14, '14'),
      FoDropdownOption(15, '15'),
      FoDropdownOption(16, '16'),
      FoDropdownOption(17, '17'),
      FoDropdownOption(18, '18'),
      FoDropdownOption(19, '19'),
      FoDropdownOption(20, '20'),
      FoDropdownOption(21, '21'),
      FoDropdownOption(22, '22'),
      FoDropdownOption(23, '23'),
      FoDropdownOption(24, '24'),
      FoDropdownOption(25, '25'),
      FoDropdownOption(26, '26'),
      FoDropdownOption(27, '27'),
      FoDropdownOption(28, '28'),
      FoDropdownOption(29, '29'),
      FoDropdownOption(30, '30'),
      FoDropdownOption(31, '31'),
      FoDropdownOption(32, '32'),
      FoDropdownOption(33, '33'),
      FoDropdownOption(34, '34'),
      FoDropdownOption(35, '35'),
      FoDropdownOption(36, '36'),
      FoDropdownOption(37, '37'),
      FoDropdownOption(38, '38'),
      FoDropdownOption(39, '39'),
      FoDropdownOption(40, '40'),
      FoDropdownOption(41, '41'),
      FoDropdownOption(42, '42'),
      FoDropdownOption(43, '43'),
      FoDropdownOption(44, '44'),
      FoDropdownOption(45, '45'),
      FoDropdownOption(46, '46'),
      FoDropdownOption(47, '47'),
      FoDropdownOption(48, '48'),
      FoDropdownOption(49, '49'),
      FoDropdownOption(50, '50'),
      FoDropdownOption(51, '51'),
      FoDropdownOption(52, '52'),
      FoDropdownOption(53, '53'),
      FoDropdownOption(54, '54'),
      FoDropdownOption(55, '55'),
      FoDropdownOption(56, '56'),
      FoDropdownOption(57, '57'),
      FoDropdownOption(58, '58'),
      FoDropdownOption(59, '59'),
    ]
  };
}
