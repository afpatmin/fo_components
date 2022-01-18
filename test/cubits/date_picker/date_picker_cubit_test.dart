// ignore_for_file: implicit_dynamic_function

import 'package:bloc_test/bloc_test.dart';
import 'package:fo_components/cubits/date_picker/date_picker_cubit.dart';
import 'package:test/test.dart';

void main() {
  final date = DateTime(2020, 7, 8);

  group('setYear', () {
    blocTest('should emit a state the new year selected',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setYear(1983),
        expect: () => [
              DatePickerState(
                  selectedDate: DateTime(1983, date.month, date.day),
                  days: DatePickerCubit.generateDays(
                      DateTime(1983, date.month, date.day)))
            ]);
  });

  group('setMonth', () {
    blocTest('should emit a state',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setMonth(10),
        expect: () => [isA<DatePickerState>()]);

    blocTest(
        'should not pretend like nothing happened if user tries to set a month outside of range 1-12',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setMonth(13),
        expect: () => <DatePickerState>[],
        errors: () => <DatePickerState>[]);

    blocTest(
        'should set the new selectedDate.day to last day of the month if the new month doesnt have enough days',
        build: () => DatePickerCubit(DateTime(2020, 10, 31)),
        act: (DatePickerCubit cubit) => cubit.setMonth(11),
        expect: () => [isA<DatePickerState>()],
        verify: (DatePickerCubit cubit) =>
            cubit.state.selectedDate == DateTime(2020, 11, 30));
  });

  group('setDate', () {
    blocTest('should set the new selectedDate.date to the new date',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setDate(DateTime(1983, 3, 24)),
        expect: () => [
              DatePickerState(
                  selectedDate: DateTime(1983, 3, 24),
                  days: DatePickerCubit.generateDays(DateTime(1983, 3, 24)))
            ]);
  });
}
