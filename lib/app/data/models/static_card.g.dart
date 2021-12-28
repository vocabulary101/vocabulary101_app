// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaticCard _$StaticCardFromJson(Map<String, dynamic> json) => StaticCard(
      id: json['id'] as String,
      term: json['a'] as String,
      meaning: json['b'] as String,
      example: json['c'] as String,
      ipa: json['d'] as String,
      termAudioBytes: ModelHelpers.uint8ListFromJson(json['e'] as String),
      meaningAudioBytes: ModelHelpers.uint8ListFromJson(json['f'] as String),
      exampleAudioBytes: ModelHelpers.uint8ListFromJson(json['g'] as String),
      photoBytes: ModelHelpers.uint8ListFromJson(json['h'] as String),
    );

Map<String, dynamic> _$StaticCardToJson(StaticCard instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'a': instance.term,
    'b': instance.meaning,
    'c': instance.example,
    'd': instance.ipa,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('e', ModelHelpers.uint8ListToJson(instance.termAudioBytes));
  writeNotNull('f', ModelHelpers.uint8ListToJson(instance.meaningAudioBytes));
  writeNotNull('g', ModelHelpers.uint8ListToJson(instance.exampleAudioBytes));
  writeNotNull('h', ModelHelpers.uint8ListToJson(instance.photoBytes));
  return val;
}
