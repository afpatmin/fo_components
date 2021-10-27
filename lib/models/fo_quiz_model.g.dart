// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fo_quiz_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension FoQuizModelCopyWith on FoQuizModel {
  FoQuizModel copyWith({
    int? passScore,
    List<FoQuestionModel>? questions,
  }) {
    return FoQuizModel(
      passScore: passScore ?? this.passScore,
      questions: questions ?? this.questions,
    );
  }
}

extension FoQuestionModelCopyWith on FoQuestionModel {
  FoQuestionModel copyWith({
    String? label,
    bool? multiSelect,
    List<FoOptionModel>? options,
  }) {
    return FoQuestionModel(
      label: label ?? this.label,
      multiSelect: multiSelect ?? this.multiSelect,
      options: options ?? this.options,
    );
  }
}

extension FoOptionModelCopyWith on FoOptionModel {
  FoOptionModel copyWith({
    FoQuizModel? child,
    String? label,
    int? score,
    bool? selected,
    Object? value,
  }) {
    return FoOptionModel(
      child: child ?? this.child,
      label: label ?? this.label,
      score: score ?? this.score,
      selected: selected ?? this.selected,
      value: value ?? this.value,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoQuizModel _$FoQuizModelFromJson(Map<String, dynamic> json) => FoQuizModel(
      questions: (json['questions'] as List<dynamic>)
          .map((e) => FoQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      passScore: json['passScore'] as int? ?? 0,
    );

Map<String, dynamic> _$FoQuizModelToJson(FoQuizModel instance) =>
    <String, dynamic>{
      'questions': instance.questions,
      'passScore': instance.passScore,
    };

FoQuestionModel _$FoQuestionModelFromJson(Map<String, dynamic> json) =>
    FoQuestionModel(
      label: json['label'] as String,
      options: (json['options'] as List<dynamic>)
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
      value: json['value'] as Object,
      label: json['label'] as String,
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
