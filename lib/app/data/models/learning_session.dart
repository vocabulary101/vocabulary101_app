import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vocabulary101_app/app/data/models/session_card.dart';

part 'learning_session.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class LearningSession extends Equatable {
  // Document ID or Key on local storage
  // Format: AppUser ID
  final String id;

  @JsonKey(
    name: 'a',
    fromJson: _cardsFromJson,
  )
  final List<SessionCard> cards;

  // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  static List<SessionCard> _cardsFromJson(val) => (val as List<dynamic>)
      .map((e) => SessionCard.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  const LearningSession({
    required this.id,
    required this.cards,
  });

  @override
  List<Object?> get props => [
        id,
        cards,
      ];

  LearningSession copyWith({
    String? id,
    List<SessionCard>? cards,
  }) {
    return LearningSession(
      id: id ?? this.id,
      cards: cards ?? this.cards,
    );
  }

  factory LearningSession.fromJson(Map<String, dynamic> json) =>
      _$LearningSessionFromJson(json);

  Map<String, dynamic> toJson() => _$LearningSessionToJson(this);

  @override
  bool get stringify => true;
}
