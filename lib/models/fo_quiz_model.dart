import 'package:json_annotation/json_annotation.dart';
part 'fo_quiz_model.g.dart';

@JsonSerializable()
class FoQuizModel {
  FoQuizModel(this.questions);

  factory FoQuizModel.fromJson(Map<String, dynamic> json) =>
      _$FoQuizModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoQuizModelToJson(this);

  @JsonKey(nullable: false)  
  final List<FoQuestionModel> questions;
  
  int passScore;
}

@JsonSerializable()
class FoQuestionModel {
  FoQuestionModel(this.label, this.options, {this.multiSelect = false});

  factory FoQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$FoQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoQuestionModelToJson(this);

  @JsonKey(nullable: false)  
  final String label;

  @JsonKey(nullable: false)  
  final List<FoOptionModel> options;

  @JsonKey(nullable: false)
  bool multiSelect;
}

@JsonSerializable()
class FoOptionModel {
  FoOptionModel(this.value, this.label,
      {this.selected = false, this.score = 0, this.child});

  factory FoOptionModel.fromJson(Map<String, dynamic> json) =>
      _$FoOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoOptionModelToJson(this);

  @JsonKey(nullable: false)
  final String value;

  @JsonKey(nullable: false)
  final String label;

  @JsonKey(nullable: false)
  int score;

  @JsonKey(nullable: false)  
  bool selected;

  FoQuizModel child;
}
