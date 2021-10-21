import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'date_picker_state.g.dart';

@CopyWith(generateCopyWithNull: true)
class DatePickerState extends Equatable {
  final DateTime? selectedDate;
  final List<int> availableDays;

  DatePickerState({required this.selectedDate, required this.availableDays});

  @override
  List<Object?> get props => [selectedDate, availableDays];
}
