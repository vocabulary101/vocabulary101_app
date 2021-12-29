import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_card.g.dart';

enum LearningStatus {
  undefined,
  again,
  hard,
  good,
  easy,
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class SessionCard extends Equatable {
  // Document ID or Key on local storage
  // Format: Language code plus StaticCard ID. Ex.: en3
  final String id;

  @JsonKey(
    name: 'a',
    fromJson: _learningStatusFromJson,
    toJson: _learningStatusToJson,
  )
  final LearningStatus status;

  @JsonKey(name: 'b')
  final String term;

  @JsonKey(name: 'c')
  final DateTime lastUpdateAt;

  static LearningStatus _learningStatusFromJson(int valueAsInt) {
    return LearningStatus.values.elementAt(valueAsInt);
  }

  static int _learningStatusToJson(LearningStatus value) {
    return value.index;
  }

  const SessionCard({
    required this.id,
    required this.term,
    required this.status,
    required this.lastUpdateAt,
  });

  @override
  List<Object?> get props => [
        id,
        term,
        status,
        lastUpdateAt,
      ];

  SessionCard copyWith({
    String? id,
    String? term,
    LearningStatus? status,
    DateTime? lastUpdateAt,
  }) {
    return SessionCard(
      id: id ?? this.id,
      term: term ?? this.term,
      status: status ?? this.status,
      lastUpdateAt: lastUpdateAt ?? this.lastUpdateAt,
    );
  }

  factory SessionCard.fromJson(Map<String, dynamic> json) =>
      _$SessionCardFromJson(json);

  Map<String, dynamic> toJson() => _$SessionCardToJson(this);

  String getStatusAsString() {
    switch (status) {
      case LearningStatus.again:
        return 'again';
      case LearningStatus.hard:
        return 'hard';
      case LearningStatus.good:
        return 'good';
      case LearningStatus.easy:
        return 'easy';
      default:
        return 'new';
    }
  }

  Color? getStatusColor() {
    switch (status) {
      case LearningStatus.again:
        return const Color(0xFFFF0000);
      case LearningStatus.hard:
        return const Color(0xFFCB6E18);
      case LearningStatus.good:
        return const Color(0xFF4D8EDA);
      case LearningStatus.easy:
        return const Color(0xFF34A400);
      default:
        return null;
    }
  }

  @override
  bool get stringify => true;
}
