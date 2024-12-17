import 'dart:convert';

import 'package:evo/binding.dart';
import 'package:evo/features/auth/providers/auth_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final _logger = Logger('PreferencesStorage');

abstract class Serializable {
  Map<String, dynamic> toJson();
}

/// A preference category with its storage key
enum PrefCategory {
  general('preferences.general');

  const PrefCategory(this.storageKey);

  final String storageKey;
}

/// A [Notifier] mixin to provide a way to store and retrieve preferences.
mixin PreferencesStorage<T extends Serializable> on AutoDisposeNotifier<T> {
  T fromJson(Map<String, dynamic> json);

  T get defaults;

  PrefCategory get prefCategory;

  Future<void> save(T value) async {
    await EvoBinding.instance.sharedPreferences.setString(
      prefCategory.storageKey,
      jsonEncode(value.toJson()),
    );

    state = value;
  }

  T fetch() {
    final stored = EvoBinding.instance.sharedPreferences
        .getString(prefCategory.storageKey);
    if (stored == null) {
      return defaults;
    }
    try {
      return fromJson(jsonDecode(stored) as Map<String, dynamic>);
    } catch (e) {
      _logger.warning('Failed to decode $prefCategory preferences: $e');
      return defaults;
    }
  }
}

/// A [Notifier] mixin to provide a way to store and retrieve preferences per session.
mixin SessionPreferencesStorage<T extends Serializable>
    on AutoDisposeNotifier<T> {
  T fromJson(Map<String, dynamic> json);

  T defaults({String? token});

  PrefCategory get prefCategory;

  Future<void> save(T value) async {
    final session = ref.read(authSessionProvider);
    await EvoBinding.instance.sharedPreferences.setString(
      key(prefCategory.storageKey, session),
      jsonEncode(value.toJson()),
    );

    state = value;
  }

  T fetch() {
    final session = ref.watch(authSessionProvider);
    final stored = EvoBinding.instance.sharedPreferences.getString(
      key(prefCategory.storageKey, session),
    );
    if (stored == null) {
      return defaults(token: session?.email);
    }
    try {
      return fromJson(jsonDecode(stored) as Map<String, dynamic>);
    } catch (e) {
      _logger.warning('Failed to decode $prefCategory preferences: $e');
      return defaults(token: session?.email);
    }
  }

  static String key(String key, AuthSessionState? session) =>
      '$key.${session?.email ?? '**anon**'}';
}
