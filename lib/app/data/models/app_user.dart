import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vocabulary101_app/app/core/utils/helpers/model.dart';

part 'app_user.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class AppUser extends Equatable {
  // Document ID or Key on local storage
  final String id;

  @JsonKey(name: 'a')
  final String? name;

  @JsonKey(name: 'b')
  final String? photoUrl;

  @JsonKey(name: 'c')
  final String? email;

  @JsonKey(
    name: 'd',
    defaultValue: 'sys',
  )
  final String lang;

  @JsonKey(
    name: 'e',
    defaultValue: 'sys',
  )
  final String theme;

  @JsonKey(
    name: 'f',
    fromJson: ModelHelpers.colorFromJson,
    toJson: ModelHelpers.colorToJson,
  )
  final Color? customThemeColor;

  @JsonKey(name: 'g')
  final DateTime signUpAt;

  @JsonKey(
    name: 'h',
    fromJson: _appUserConfigFromJson,
  )
  final AppUserConfig config;

  @JsonKey(name: 'i')
  final bool activated;

  // To fix "Expected a value of type 'Map<String, dynamic>', but got one of type 'LinkedMap<dynamic, dynamic>'"
  static AppUserConfig _appUserConfigFromJson(val) =>
      AppUserConfig.fromJson(Map<String, dynamic>.from(val));

  const AppUser({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.lang,
    required this.theme,
    required this.customThemeColor,
    required this.signUpAt,
    required this.config,
    required this.activated,
  });

  AppUser.minimum({required String id})
      : id = id,
        name = null,
        photoUrl = null,
        email = null,
        lang = 'sys',
        theme = 'sys',
        customThemeColor = null,
        signUpAt = DateTime.now().toUtc(),
        config = AppUserConfig.minimum(),
        activated = true;

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        email,
        lang,
        theme,
        customThemeColor,
        signUpAt,
        config,
        activated,
      ];

  AppUser copyWith({
    String? id,
    String? name,
    String? photoUrl,
    String? email,
    String? lang,
    String? theme,
    Color? customThemeColor,
    DateTime? signUpAt,
    AppUserConfig? config,
    bool? activated,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      lang: lang ?? this.lang,
      theme: theme ?? this.theme,
      customThemeColor: customThemeColor ?? this.customThemeColor,
      signUpAt: signUpAt ?? this.signUpAt,
      config: config ?? this.config,
      activated: activated ?? this.activated,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  //
  // factory AppUser.fromFirestoreMap(String snapshotId, Map data) {
  //   //
  //   var json = Map<String, dynamic>.from(
  //     data,
  //   );

  //   //
  //   json['id'] = snapshotId;

  //   // Convert 'signUpAt' to DateTime
  //   json['h'] = (json['h'] as Timestamp).toDate().toIso8601String();

  //   //
  //   return _$AppUserFromJson(json);
  // }

  Map<String, dynamic> toDocument() => this.toJson()..remove('id');

  // Map<String, dynamic> toFirestoreDocument() {
  //   Map<String, dynamic> doc = this.toDocument();

  //   // Convert 'signUpAt' to Firestore Timestamp
  //   doc['h'] = Timestamp.fromDate(DateTime.parse(doc['h']));

  //   return doc;
  // }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class AppUserConfig extends Equatable {
  @JsonKey(
    name: 'a',
    defaultValue: false,
  )
  final bool avoidInstallMobileAppMsg;

  AppUserConfig({
    required this.avoidInstallMobileAppMsg,
  });

  AppUserConfig.minimum() : avoidInstallMobileAppMsg = false;

  @override
  List<Object> get props => [
        avoidInstallMobileAppMsg,
      ];

  AppUserConfig copyWith({
    bool? avoidInstallMobileAppMsg,
  }) {
    return AppUserConfig(
      avoidInstallMobileAppMsg:
          avoidInstallMobileAppMsg ?? this.avoidInstallMobileAppMsg,
    );
  }

  factory AppUserConfig.fromJson(Map<String, dynamic> json) =>
      _$AppUserConfigFromJson(json);

  Map<String, dynamic> toJson() {
    // Convert to JSON Map
    Map<String, dynamic> json = _$AppUserConfigToJson(this);

    // Remove 'avoidInstallMobileAppMsg' if have its default value
    if (avoidInstallMobileAppMsg == false) json.remove('a');

    return json;
  }

  @override
  bool get stringify => true;
}
