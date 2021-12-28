import 'package:equatable/equatable.dart';
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
  final DateTime lastUpdateAt;

  static LearningStatus _learningStatusFromJson(int valueAsInt) {
    return LearningStatus.values.elementAt(valueAsInt);
  }

  static int _learningStatusToJson(LearningStatus value) {
    return value.index;
  }

  const SessionCard({
    required this.id,
    required this.status,
    required this.lastUpdateAt,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        lastUpdateAt,
      ];

  SessionCard copyWith({
    String? id,
    LearningStatus? status,
    DateTime? lastUpdateAt,
  }) {
    return SessionCard(
      id: id ?? this.id,
      status: status ?? this.status,
      lastUpdateAt: lastUpdateAt ?? this.lastUpdateAt,
    );
  }

  factory SessionCard.fromJson(Map<String, dynamic> json) =>
      _$SessionCardFromJson(json);

  Map<String, dynamic> toJson() => _$SessionCardToJson(this);

  @override
  bool get stringify => true;
}
