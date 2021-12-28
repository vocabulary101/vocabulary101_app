// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      id: json['id'] as String,
      name: json['a'] as String?,
      photoUrl: json['b'] as String?,
      email: json['c'] as String?,
      lang: json['d'] as String? ?? 'sys',
      theme: json['e'] as String? ?? 'sys',
      customThemeColor: ModelHelpers.colorFromJson(json['f'] as int?),
      signUpAt: DateTime.parse(json['g'] as String),
      config: AppUser._appUserConfigFromJson(json['h']),
      activated: json['i'] as bool,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('a', instance.name);
  writeNotNull('b', instance.photoUrl);
  writeNotNull('c', instance.email);
  val['d'] = instance.lang;
  val['e'] = instance.theme;
  writeNotNull('f', ModelHelpers.colorToJson(instance.customThemeColor));
  val['g'] = instance.signUpAt.toIso8601String();
  val['h'] = instance.config.toJson();
  val['i'] = instance.activated;
  return val;
}

AppUserConfig _$AppUserConfigFromJson(Map<String, dynamic> json) =>
    AppUserConfig(
      avoidInstallMobileAppMsg: json['a'] as bool? ?? false,
    );

Map<String, dynamic> _$AppUserConfigToJson(AppUserConfig instance) =>
    <String, dynamic>{
      'a': instance.avoidInstallMobileAppMsg,
    };
