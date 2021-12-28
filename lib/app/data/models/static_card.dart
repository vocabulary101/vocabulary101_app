import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vocabulary101_app/app/core/utils/helpers/model.dart';

part 'static_card.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class StaticCard extends Equatable {
  // Document ID or Key on local storage
  final String id;

  @JsonKey(name: 'a')
  final String term;

  @JsonKey(name: 'b')
  final String meaning;

  @JsonKey(name: 'c')
  final String example;

  @JsonKey(name: 'd')
  final String ipa;

  @JsonKey(
    name: 'e',
    fromJson: ModelHelpers.uint8ListFromJson,
    toJson: ModelHelpers.uint8ListToJson,
  )
  final Uint8List termAudioBytes;

  @JsonKey(
    name: 'f',
    fromJson: ModelHelpers.uint8ListFromJson,
    toJson: ModelHelpers.uint8ListToJson,
  )
  final Uint8List meaningAudioBytes;

  @JsonKey(
    name: 'g',
    fromJson: ModelHelpers.uint8ListFromJson,
    toJson: ModelHelpers.uint8ListToJson,
  )
  final Uint8List exampleAudioBytes;

  @JsonKey(
    name: 'h',
    fromJson: ModelHelpers.uint8ListFromJson,
    toJson: ModelHelpers.uint8ListToJson,
  )
  final Uint8List photoBytes;

  const StaticCard({
    required this.id,
    required this.term,
    required this.meaning,
    required this.example,
    required this.ipa,
    required this.termAudioBytes,
    required this.meaningAudioBytes,
    required this.exampleAudioBytes,
    required this.photoBytes,
  });

  @override
  List<Object?> get props => [
        id,
        term,
        meaning,
        example,
        ipa,
        termAudioBytes,
        meaningAudioBytes,
        exampleAudioBytes,
        photoBytes,
      ];

  StaticCard copyWith({
    String? id,
    String? term,
    String? meaning,
    String? example,
    String? ipa,
    Uint8List? termAudioBytes,
    Uint8List? meaningAudioBytes,
    Uint8List? exampleAudioBytes,
    Uint8List? photoBytes,
  }) {
    return StaticCard(
      id: id ?? this.id,
      term: term ?? this.term,
      meaning: meaning ?? this.meaning,
      example: example ?? this.example,
      ipa: ipa ?? this.ipa,
      termAudioBytes: termAudioBytes ?? this.termAudioBytes,
      meaningAudioBytes: meaningAudioBytes ?? this.meaningAudioBytes,
      exampleAudioBytes: exampleAudioBytes ?? this.exampleAudioBytes,
      photoBytes: photoBytes ?? this.photoBytes,
    );
  }

  factory StaticCard.fromJson(Map<String, dynamic> json) =>
      _$StaticCardFromJson(json);

  Map<String, dynamic> toJson() => _$StaticCardToJson(this);

  @override
  bool get stringify => true;
}
