// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningSession _$LearningSessionFromJson(Map<String, dynamic> json) =>
    LearningSession(
      id: json['id'] as String,
      cards: LearningSession._cardsFromJson(json['a']),
    );

Map<String, dynamic> _$LearningSessionToJson(LearningSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'a': instance.cards.map((e) => e.toJson()).toList(),
    };
