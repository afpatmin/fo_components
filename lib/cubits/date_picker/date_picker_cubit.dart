import 'package:bloc/bloc.dart';
import 'package:fo_components/cubits/date_picker/date_picker_state.dart';

export 'package:fo_components/cubits/date_picker/date_picker_state.dart';

class DatePickerCubit extends Cubit<DatePickerState> {
  DatePickerCubit(DateTime? initalSelectedDate)
      : super(DatePickerState(
            selectedDate: initalSelectedDate,
            availableDays: _calcAvailableDays(initalSelectedDate)));

  void setDate(DateTime? date) {
    if (date == null) {
      emit(state
          .copyWithNull(selectedDate: true)
          .copyWith(availableDays: <int>[]));
    } else {
      emit(state.copyWith(
          selectedDate: date, availableDays: _calcAvailableDays(date)));
    }
  }

  void setDay(int day) {
    if (day < 1 || day > 32) {
      throw StateError('day must be specified in range 1-32');
    }

    if (state.selectedDate != null) {
      var newDate =
          DateTime(state.selectedDate!.year, state.selectedDate!.month, day);

      // This can happen for example when the month only has 28 days, but the
      // previous month had 31. Pretend like nothing happened
      if (newDate.month > state.selectedDate!.month) {
        return;
      }

      emit(state.copyWith(
          selectedDate: newDate, availableDays: _calcAvailableDays(newDate)));
    }
  }

  void setMonth(int month) {
    if (month < 1 || month > 12) {
      return;
    }

    if (state.selectedDate != null) {
      var newDate =
          DateTime(state.selectedDate!.year, month, state.selectedDate!.day);

      // This can happen for example when the month only has 28 days, but the
      // previous month had 31. Set it to the last day of the new month
      if (newDate.month > month) {
        newDate = DateTime(newDate.year, month + 1, 0);
      }

      emit(state.copyWith(
        selectedDate: newDate,
        availableDays: _calcAvailableDays(newDate),
      ));
    }
  }

  void setYear(int year) {
    if (state.selectedDate != null) {
      final newDate =
          DateTime(year, state.selectedDate!.month, state.selectedDate!.day);
      emit(state.copyWith(
        selectedDate: newDate,
        availableDays: _calcAvailableDays(newDate),
      ));
    }
  }

  static List<int> _calcAvailableDays(DateTime? date) {
    final output = <int>[];
    if (date == null) {
      return output;
    }
    var iDate = DateTime(date.year, date.month, 1);

    while (iDate.month == date.month) {
      output.add(iDate.day);
      iDate = DateTime(iDate.year, iDate.month, iDate.day + 1);
    }
    return output.toList(growable: false);
  }
}
