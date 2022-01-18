// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_picker_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension DatePickerStateCopyWith on DatePickerState {
  DatePickerState copyWith({
    List<List<DateTime>>? days,
    DateTime? selectedDate,
  }) {
    return DatePickerState(
      days: days ?? this.days,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  DatePickerState copyWithNull({
    bool selectedDate = false,
  }) {
    return DatePickerState(
      days: days,
      selectedDate: selectedDate == true ? null : this.selectedDate,
    );
  }
}
