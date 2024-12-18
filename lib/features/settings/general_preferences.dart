import 'dart:ui';

import 'package:evo/features/settings/preferences_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'general_preferences.freezed.dart';
part 'general_preferences.g.dart';

@riverpod
class GeneralPreferences extends _$GeneralPreferences
    with PreferencesStorage<GeneralPrefs> {
  @override
  final prefCategory = PrefCategory.general;

  @override
  GeneralPrefs get defaults => GeneralPrefs.defaults;

  @override
  GeneralPrefs fromJson(Map<String, dynamic> json) =>
      GeneralPrefs.fromJson(json);

  @override
  GeneralPrefs build() {
    return fetch();
  }

  Future<void> setThemeMode(BackgroundThemeMode themeMode) {
    return save(state.copyWith(themeMode: themeMode));
  }

  Future<void> setLocale(Locale? locale) {
    return save(state.copyWith(locale: locale));
  }

  Future<void> toggleSystemColors() async {
    await save(state.copyWith(systemColors: !state.systemColors));
  }
}

Map<String, dynamic>? _localeToJson(Locale? locale) {
  return locale != null
      ? {
          'languageCode': locale.languageCode,
          'countryCode': locale.countryCode,
          'scriptCode': locale.scriptCode,
        }
      : null;
}

Locale? _localeFromJson(Map<String, dynamic>? json) {
  if (json == null) {
    return null;
  }
  return Locale.fromSubtags(
    languageCode: json['languageCode'] as String,
    countryCode: json['countryCode'] as String?,
    scriptCode: json['scriptCode'] as String?,
  );
}

@Freezed(fromJson: true, toJson: true)
class GeneralPrefs with _$GeneralPrefs implements Serializable {
  const factory GeneralPrefs({
    @JsonKey(
      unknownEnumValue: BackgroundThemeMode.system,
      defaultValue: BackgroundThemeMode.system,
    )
    required BackgroundThemeMode themeMode,

    /// Should enable system color palette (Android 12+ only)
    @JsonKey(defaultValue: true) required bool systemColors,

    /// Locale to use in the app, use system locale if null
    @JsonKey(toJson: _localeToJson, fromJson: _localeFromJson) Locale? locale,
  }) = _GeneralPrefs;

  static const defaults = GeneralPrefs(
    themeMode: BackgroundThemeMode.system,
    systemColors: true,
  );

  factory GeneralPrefs.fromJson(Map<String, dynamic> json) {
    return _$GeneralPrefsFromJson(json);
  }
}

/// Describes the background theme of the app.
enum BackgroundThemeMode {
  /// Use either the light or dark theme based on what the user has selected in
  /// the system settings.
  system,

  /// Always use the light mode regardless of system preference.
  light,

  /// Always use the dark mode (if available) regardless of system preference.
  dark,
}
