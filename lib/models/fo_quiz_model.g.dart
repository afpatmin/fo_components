// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fo_quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoQuizModel _$FoQuizModelFromJson(Map<String, dynamic> json) {
  return new FoQuizModel((json['questions'] as List)
      .map((e) => new FoQuestionModel.fromJson(e as Map<String, dynamic>))
      .toList());
}

abstract class _$FoQuizModelSerializerMixin {
  List<FoQuestionModel> get questions;
  Map<String, dynamic> toJson() => <String, dynamic>{'questions': questions};
}

FoQuestionModel _$FoQuestionModelFromJson(Map<String, dynamic> json) {
  return new FoQuestionModel(
      json['label'] as String,
      (json['options'] as List)
          .map((e) => new FoOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      multiSelect: json['multiSelect'] as bool);
}

abstract class _$FoQuestionModelSerializerMixin {
  String get label;
  List<FoOptionModel> get options;
  bool get multiSelect;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'label': label,
        'options': options,
        'multiSelect': multiSelect
      };
}

FoOptionModel _$FoOptionModelFromJson(Map<String, dynamic> json) {
  return new FoOptionModel(json['value'] as String, json['label'] as String,
      selected: json['selected'] as bool,
      score: json['score'] as int,
      child: json['child'] == null
          ? null
          : new FoQuizModel.fromJson(json['child'] as Map<String, dynamic>));
}

abstract class _$FoOptionModelSerializerMixin {
  String get value;
  String get label;
  int get score;
  bool get selected;
  FoQuizModel get child;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'value': value,
        'label': label,
        'score': score,
        'selected': selected,
        'child': child
      };
}
