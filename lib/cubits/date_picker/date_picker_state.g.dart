// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_picker_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension DatePickerStateCopyWith on DatePickerState {
  DatePickerState copyWith({
    List<int>? availableDays,
    DateTime? selectedDate,
  }) {
    return DatePickerState(
      availableDays: availableDays ?? this.availableDays,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  DatePickerState copyWithNull({
    bool selectedDate = false,
  }) {
    return DatePickerState(
      availableDays: availableDays,
      selectedDate: selectedDate == true ? null : this.selectedDate,
    );
  }
}
