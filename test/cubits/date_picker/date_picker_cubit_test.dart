import 'package:bloc_test/bloc_test.dart';
import 'package:fo_components/cubits/date_picker/date_picker_cubit.dart';
import 'package:test/test.dart';

/*
class MockDatePickerCubit extends MockCubit<DateTime>
    implements DatePickerCubit {}
*/
void main() {
  final date = DateTime(2020, 7, 8);
  final dateDays = 31;

  group('setYear', () {
    blocTest('should emit a state the new year selected',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setYear(1983),
        expect: () => [
              DatePickerState(
                  selectedDate: DateTime(1983, date.month, date.day),
                  availableDays: List.generate(dateDays, (index) => index + 1,
                      growable: false))
            ]);
  });

  group('setMonth', () {
    blocTest(
        'should emit a state with 31 available dates when month is set to october',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setMonth(10),
        expect: () => [
              DatePickerState(
                  selectedDate: DateTime(date.year, 10, date.day),
                  availableDays:
                      List.generate(31, (index) => index + 1, growable: false))
            ]);

    blocTest(
        'should not pretend like nothing happened if user tries to set a month outside of range 1-12',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setMonth(13),
        expect: () => [],
        errors: () => []);

    blocTest(
        'should set the new selectedDate.day to last day of the month if the new month doesnt have enough days',
        build: () => DatePickerCubit(DateTime(2020, 10, 31)),
        act: (DatePickerCubit cubit) => cubit.setMonth(11),
        expect: () => [
              DatePickerState(
                  selectedDate: DateTime(2020, 11, 30),
                  availableDays:
                      List.generate(30, (index) => index + 1, growable: false))
            ]);
  });

  group('setDay', () {
    blocTest('should set the new selectedDate.day to the new day',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setDay(12),
        expect: () => [
              DatePickerState(
                  selectedDate: DateTime(date.year, date.month, 12),
                  availableDays: List.generate(dateDays, (index) => index + 1,
                      growable: false))
            ]);
    blocTest(
        'should pretend like nothing happened if the month doesnt have enough days',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setDay(dateDays + 1),
        expect: () => [],
        errors: () => []);

    blocTest(
        'should throw StateError if user tries to set a day outside of range 1-32',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setDay(33),
        errors: () => [isA<StateError>()]);
  });

  group('setDate', () {
    blocTest('should set the new selectedDate.date to the new date',
        build: () => DatePickerCubit(date),
        act: (DatePickerCubit cubit) => cubit.setDate(DateTime(1983, 3, 24)),
        expect: () => [
              DatePickerState(
                  selectedDate: DateTime(1983, 3, 24),
                  availableDays:
                      List.generate(31, (index) => index + 1, growable: false))
            ]);
  });
}
