import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'fo_quiz_model.g.dart';

@JsonSerializable()
@CopyWith()
class FoQuizModel extends Equatable {
  const FoQuizModel({
    required this.questions,
    this.passScore = 0,
  });

  factory FoQuizModel.fromJson(Map<String, dynamic> json) =>
      _$FoQuizModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoQuizModelToJson(this);

  final List<FoQuestionModel> questions;

  final int passScore;

  @override
  List<Object> get props => [
        questions,
        passScore,
      ];
}

@JsonSerializable()
@CopyWith()
class FoQuestionModel extends Equatable {
  const FoQuestionModel({
    required this.label,
    required this.options,
    this.multiSelect = false,
  });

  factory FoQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$FoQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoQuestionModelToJson(this);

  final String label;

  final List<FoOptionModel> options;

  final bool multiSelect;

  @override
  List<Object> get props => [
        label,
        options,
        multiSelect,
      ];
}

@JsonSerializable()
@CopyWith()
class FoOptionModel extends Equatable {
  const FoOptionModel({
    required this.value,
    required this.label,
    this.child,
    this.selected = false,
    this.score = 0,
  });

  factory FoOptionModel.fromJson(Map<String, dynamic> json) =>
      _$FoOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoOptionModelToJson(this);

  final Object value;

  final String label;

  final int score;

  @JsonKey(ignore: true)
  final bool selected;

  final FoQuizModel? child;

  @override
  List<Object?> get props => [
        value,
        label,
        score,
        selected,
        child,
      ];
}
