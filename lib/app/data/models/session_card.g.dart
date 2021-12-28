// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionCard _$SessionCardFromJson(Map<String, dynamic> json) => SessionCard(
      id: json['id'] as String,
      status: SessionCard._learningStatusFromJson(json['a'] as int),
      lastUpdateAt: DateTime.parse(json['b'] as String),
    );

Map<String, dynamic> _$SessionCardToJson(SessionCard instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('a', SessionCard._learningStatusToJson(instance.status));
  val['b'] = instance.lastUpdateAt.toIso8601String();
  return val;
}
