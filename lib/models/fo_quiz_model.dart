import 'package:json_annotation/json_annotation.dart';
part 'fo_quiz_model.g.dart';

@JsonSerializable()
class FoQuizModel {
  FoQuizModel(this.questions);

  factory FoQuizModel.fromJson(Map<String, dynamic> json) =>
      _$FoQuizModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoQuizModelToJson(this);

  final List<FoQuestionModel> questions;

  int passScore = 0;
}

@JsonSerializable()
class FoQuestionModel {
  FoQuestionModel(this.label, this.options, {this.multiSelect = false});

  factory FoQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$FoQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoQuestionModelToJson(this);

  final String label;

  final List<FoOptionModel> options;

  bool multiSelect;
}

@JsonSerializable()
class FoOptionModel {
  FoOptionModel(this.value, this.label,
      {this.child, this.selected = false, this.score = 0});

  factory FoOptionModel.fromJson(Map<String, dynamic> json) =>
      _$FoOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoOptionModelToJson(this);

  final String value;

  final String label;

  int score;

  @JsonKey(ignore: true)
  bool selected;

  FoQuizModel? child;
}
