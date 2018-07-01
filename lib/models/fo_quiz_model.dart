import 'package:json_annotation/json_annotation.dart';
part 'fo_quiz_model.g.dart';

@JsonSerializable()
class FoQuizModel extends Object with _$FoQuizModelSerializerMixin {
  FoQuizModel(this.name, this.questions);

  factory FoQuizModel.fromJson(Map<String, dynamic> json) =>
      _$FoQuizModelFromJson(json);

  @JsonKey(nullable: false)
  @override
  final String name;

  @JsonKey(nullable: false)
  @override
  final List<FoQuestionModel> questions;
}

@JsonSerializable()
class FoQuestionModel extends Object with _$FoQuestionModelSerializerMixin {
  FoQuestionModel(this.label, this.options, {this.multiSelect = false});

  factory FoQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$FoQuestionModelFromJson(json);

  @JsonKey(nullable: false)
  @override
  final String label;

  @JsonKey(nullable: false)
  @override
  final List<FoOptionModel> options;

  @JsonKey(nullable: false)
  @override
  final bool multiSelect;
}

@JsonSerializable()
class FoOptionModel extends Object with _$FoOptionModelSerializerMixin {
  FoOptionModel(this.value, this.label,
      {this.selected = false, this.valid = false, this.score = 0, this.child});

  factory FoOptionModel.fromJson(Map<String, dynamic> json) =>
      _$FoOptionModelFromJson(json);

  @JsonKey(nullable: false)
  @override
  final String value;

  @JsonKey(nullable: false)
  @override
  final String label;

  @JsonKey(nullable: false)
  @override
  final bool valid;

  @JsonKey(nullable: false)
  @override
  final int score;

  @JsonKey(nullable: false)
  @override
  bool selected;

  @override
  FoQuizModel child;
}
