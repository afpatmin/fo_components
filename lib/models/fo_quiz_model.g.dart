// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fo_quiz_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FoQuizModelCWProxy {
  FoQuizModel questions(List<FoQuestionModel> questions);

  FoQuizModel passScore(int passScore);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoQuizModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoQuizModel(...).copyWith(id: 12, name: "My name")
  /// ````
  FoQuizModel call({
    List<FoQuestionModel>? questions,
    int? passScore,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFoQuizModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFoQuizModel.copyWith.fieldName(...)`
class _$FoQuizModelCWProxyImpl implements _$FoQuizModelCWProxy {
  const _$FoQuizModelCWProxyImpl(this._value);

  final FoQuizModel _value;

  @override
  FoQuizModel questions(List<FoQuestionModel> questions) =>
      this(questions: questions);

  @override
  FoQuizModel passScore(int passScore) => this(passScore: passScore);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoQuizModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoQuizModel(...).copyWith(id: 12, name: "My name")
  /// ````
  FoQuizModel call({
    Object? questions = const $CopyWithPlaceholder(),
    Object? passScore = const $CopyWithPlaceholder(),
  }) {
    return FoQuizModel(
      questions: questions == const $CopyWithPlaceholder() || questions == null
          ? _value.questions
          // ignore: cast_nullable_to_non_nullable
          : questions as List<FoQuestionModel>,
      passScore: passScore == const $CopyWithPlaceholder() || passScore == null
          ? _value.passScore
          // ignore: cast_nullable_to_non_nullable
          : passScore as int,
    );
  }
}

extension $FoQuizModelCopyWith on FoQuizModel {
  /// Returns a callable class that can be used as follows: `instanceOfFoQuizModel.copyWith(...)` or like so:`instanceOfFoQuizModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FoQuizModelCWProxy get copyWith => _$FoQuizModelCWProxyImpl(this);
}

abstract class _$FoQuestionModelCWProxy {
  FoQuestionModel label(String label);

  FoQuestionModel options(List<FoOptionModel> options);

  FoQuestionModel multiSelect(bool multiSelect);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoQuestionModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoQuestionModel(...).copyWith(id: 12, name: "My name")
  /// ````
  FoQuestionModel call({
    String? label,
    List<FoOptionModel>? options,
    bool? multiSelect,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFoQuestionModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFoQuestionModel.copyWith.fieldName(...)`
class _$FoQuestionModelCWProxyImpl implements _$FoQuestionModelCWProxy {
  const _$FoQuestionModelCWProxyImpl(this._value);

  final FoQuestionModel _value;

  @override
  FoQuestionModel label(String label) => this(label: label);

  @override
  FoQuestionModel options(List<FoOptionModel> options) =>
      this(options: options);

  @override
  FoQuestionModel multiSelect(bool multiSelect) =>
      this(multiSelect: multiSelect);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoQuestionModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoQuestionModel(...).copyWith(id: 12, name: "My name")
  /// ````
  FoQuestionModel call({
    Object? label = const $CopyWithPlaceholder(),
    Object? options = const $CopyWithPlaceholder(),
    Object? multiSelect = const $CopyWithPlaceholder(),
  }) {
    return FoQuestionModel(
      label: label == const $CopyWithPlaceholder() || label == null
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      options: options == const $CopyWithPlaceholder() || options == null
          ? _value.options
          // ignore: cast_nullable_to_non_nullable
          : options as List<FoOptionModel>,
      multiSelect:
          multiSelect == const $CopyWithPlaceholder() || multiSelect == null
              ? _value.multiSelect
              // ignore: cast_nullable_to_non_nullable
              : multiSelect as bool,
    );
  }
}

extension $FoQuestionModelCopyWith on FoQuestionModel {
  /// Returns a callable class that can be used as follows: `instanceOfFoQuestionModel.copyWith(...)` or like so:`instanceOfFoQuestionModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FoQuestionModelCWProxy get copyWith => _$FoQuestionModelCWProxyImpl(this);
}

abstract class _$FoOptionModelCWProxy {
  FoOptionModel value(Object value);

  FoOptionModel label(String label);

  FoOptionModel child(FoQuizModel? child);

  FoOptionModel selected(bool selected);

  FoOptionModel score(int score);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoOptionModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoOptionModel(...).copyWith(id: 12, name: "My name")
  /// ````
  FoOptionModel call({
    Object? value,
    String? label,
    FoQuizModel? child,
    bool? selected,
    int? score,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFoOptionModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFoOptionModel.copyWith.fieldName(...)`
class _$FoOptionModelCWProxyImpl implements _$FoOptionModelCWProxy {
  const _$FoOptionModelCWProxyImpl(this._value);

  final FoOptionModel _value;

  @override
  FoOptionModel value(Object value) => this(value: value);

  @override
  FoOptionModel label(String label) => this(label: label);

  @override
  FoOptionModel child(FoQuizModel? child) => this(child: child);

  @override
  FoOptionModel selected(bool selected) => this(selected: selected);

  @override
  FoOptionModel score(int score) => this(score: score);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FoOptionModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FoOptionModel(...).copyWith(id: 12, name: "My name")
  /// ````
  FoOptionModel call({
    Object? value = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? child = const $CopyWithPlaceholder(),
    Object? selected = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
  }) {
    return FoOptionModel(
      value: value == const $CopyWithPlaceholder() || value == null
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as Object,
      label: label == const $CopyWithPlaceholder() || label == null
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      child: child == const $CopyWithPlaceholder()
          ? _value.child
          // ignore: cast_nullable_to_non_nullable
          : child as FoQuizModel?,
      selected: selected == const $CopyWithPlaceholder() || selected == null
          ? _value.selected
          // ignore: cast_nullable_to_non_nullable
          : selected as bool,
      score: score == const $CopyWithPlaceholder() || score == null
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as int,
    );
  }
}

extension $FoOptionModelCopyWith on FoOptionModel {
  /// Returns a callable class that can be used as follows: `instanceOfFoOptionModel.copyWith(...)` or like so:`instanceOfFoOptionModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FoOptionModelCWProxy get copyWith => _$FoOptionModelCWProxyImpl(this);
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
      selected: json['selected'] as bool? ?? false,
      score: json['score'] as int? ?? 0,
    );

Map<String, dynamic> _$FoOptionModelToJson(FoOptionModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'score': instance.score,
      'selected': instance.selected,
      'child': instance.child,
    };
