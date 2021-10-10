// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fo_quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoQuizModel _$FoQuizModelFromJson(Map<String, dynamic> json) => FoQuizModel(
      (json['questions'] as List<dynamic>)
          .map((e) => FoQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..passScore = json['passScore'] as int;

Map<String, dynamic> _$FoQuizModelToJson(FoQuizModel instance) =>
    <String, dynamic>{
      'questions': instance.questions,
      'passScore': instance.passScore,
    };

FoQuestionModel _$FoQuestionModelFromJson(Map<String, dynamic> json) =>
    FoQuestionModel(
      json['label'] as String,
      (json['options'] as List<dynamic>)
          .map((e) => FoOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      multiSelect: json['multiSelect'] as bool? ?? false,
    );

Map<String, dynamic> _$FoQuestionModelToJson(FoQuestionModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'options': instance.options,
      'multiSelect': instance.multiSelect,
    };

FoOptionModel _$FoOptionModelFromJson(Map<String, dynamic> json) =>
    FoOptionModel(
      json['value'] as String,
      json['label'] as String,
      child: json['child'] == null
          ? null
          : FoQuizModel.fromJson(json['child'] as Map<String, dynamic>),
      score: json['score'] as int? ?? 0,
    );

Map<String, dynamic> _$FoOptionModelToJson(FoOptionModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'score': instance.score,
      'child': instance.child,
    };
