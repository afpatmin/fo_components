import 'dart:html' as dom;
import 'package:angular/angular.dart';
import 'package:angular_bloc/angular_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubits/date_picker/date_picker_cubit.dart';
import '../../src/components/fo_dropdown/fo_dropdown_component.dart';
import '../../src/components/fo_label/fo_label_component.dart';
import '../fo_button/fo_button_component.dart';
import '../fo_icon/fo_icon_component.dart';

@Component(
  selector: 'fo-date-picker',
  templateUrl: 'fo_date_picker_component.html',
  styleUrls: ['fo_date_picker_component.css'],
  directives: [
    coreDirectives,
    FoButtonComponent,
    FoDropdownComponent,
    FoIconComponent,
    FoLabelComponent
  ],
  pipes: [BlocPipe, DatePipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoDatePickerComponent {
  final DatePickerCubit datePickerCubit;
  final List<String> weekdays;

  FoDatePickerComponent()
      : datePickerCubit = DatePickerCubit(null),
        weekdays = List.generate(
            7,
            (index) => DateFormat(DateFormat.ABBR_WEEKDAY)
                .format(DateTime(2021, 10, 11 + index)));

  final List<List<int>> weeks = [
    List.generate(7, (index) => index + 1, growable: false),
    List.generate(7, (index) => index + 8, growable: false),
    List.generate(7, (index) => index + 15, growable: false),
    List.generate(7, (index) => index + 22, growable: false),
  ];
  final List<int> lastWeek = [29, 30, 31];

  @Input()
  set date(DateTime? v) {
    datePickerCubit.setDate(v);
    if (v == null) {
      dropdownVisible = false;
    }
  }

  @Input()
  String label = 'Pick a date';

  @Output('dateChange')
  Stream<DateTime?> get onDateChange =>
      datePickerCubit.stream.map((event) => event.selectedDate);

  @Input()
  bool disabled = false;

  bool dropdownVisible = false;

  void advanceMonth(int howMany) {
    if (datePickerCubit.state.selectedDate != null) {
      datePickerCubit
          .setMonth(datePickerCubit.state.selectedDate!.month + howMany);
    }
  }

  void advanceYear(int howMany) {
    if (datePickerCubit.state.selectedDate != null) {
      datePickerCubit
          .setYear(datePickerCubit.state.selectedDate!.year + howMany);
    }
  }

  void onClick(dom.Event e) {
    if (!disabled) {
      dropdownVisible = !dropdownVisible;
      if (dropdownVisible && datePickerCubit.state.selectedDate == null) {
        datePickerCubit.setDate(DateTime.now());
      }
    }
  }
}
