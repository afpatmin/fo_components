// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_picker_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DatePickerStateCWProxy {
  DatePickerState selectedDate(DateTime? selectedDate);

  DatePickerState days(List<List<DateTime>> days);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DatePickerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DatePickerState(...).copyWith(id: 12, name: "My name")
  /// ````
  DatePickerState call({
    DateTime? selectedDate,
    List<List<DateTime>>? days,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDatePickerState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDatePickerState.copyWith.fieldName(...)`
class _$DatePickerStateCWProxyImpl implements _$DatePickerStateCWProxy {
  const _$DatePickerStateCWProxyImpl(this._value);

  final DatePickerState _value;

  @override
  DatePickerState selectedDate(DateTime? selectedDate) =>
      this(selectedDate: selectedDate);

  @override
  DatePickerState days(List<List<DateTime>> days) => this(days: days);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DatePickerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DatePickerState(...).copyWith(id: 12, name: "My name")
  /// ````
  DatePickerState call({
    Object? selectedDate = const $CopyWithPlaceholder(),
    Object? days = const $CopyWithPlaceholder(),
  }) {
    return DatePickerState(
      selectedDate: selectedDate == const $CopyWithPlaceholder()
          ? _value.selectedDate
          // ignore: cast_nullable_to_non_nullable
          : selectedDate as DateTime?,
      days: days == const $CopyWithPlaceholder() || days == null
          // ignore: unnecessary_non_null_assertion
          ? _value.days!
          // ignore: cast_nullable_to_non_nullable
          : days as List<List<DateTime>>,
    );
  }
}

extension $DatePickerStateCopyWith on DatePickerState {
  /// Returns a callable class that can be used as follows: `instanceOfDatePickerState.copyWith(...)` or like so:`instanceOfDatePickerState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DatePickerStateCWProxy get copyWith => _$DatePickerStateCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `DatePickerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DatePickerState(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  DatePickerState copyWithNull({
    bool selectedDate = false,
  }) {
    return DatePickerState(
      selectedDate: selectedDate == true ? null : this.selectedDate,
      days: days,
    );
  }
}
