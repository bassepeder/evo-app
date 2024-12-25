import 'package:evo/binding.dart';
import 'package:evo/features/auth/secure_session_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

/// Run initialization tasks only once on first app launch or after an update.
Future<void> setupFirstLaunch() async {
  final prefs = EvoBinding.instance.sharedPreferences;
  final pInfo = await PackageInfo.fromPlatform();

  final appVersion = Version.parse(pInfo.version);
  final installedVersion = prefs.getString('installed_version');

  if (installedVersion == null ||
      Version.parse(installedVersion) != appVersion) {
    prefs.setString('installed_version', appVersion.canonicalizedVersion);
  }

  if (prefs.getBool('first_run') ?? true) {
    // Clear secure storage on first run because it is not deleted on app uninstall
    await SecureStorage.instance.deleteAll();

    await prefs.setBool('first_run', false);
  }
}

/// Display setup on Android.
///
/// This is meant to be called once during app initialization.
Future<void> androidDisplayInitialization(WidgetsBinding widgetsBinding) async {
  // Sets edge-to-edge system UI mode on Android 12+
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
    ),
  );

  /// Enables high refresh rate for devices where it was previously disabled
  final List<DisplayMode> supported = await FlutterDisplayMode.supported;
  final DisplayMode active = await FlutterDisplayMode.active;

  final List<DisplayMode> sameResolution = supported
      .where(
        (DisplayMode m) => m.width == active.width && m.height == active.height,
      )
      .toList()
    ..sort(
      (DisplayMode a, DisplayMode b) => b.refreshRate.compareTo(a.refreshRate),
    );

  final DisplayMode mostOptimalMode =
      sameResolution.isNotEmpty ? sameResolution.first : active;

  // This setting is per session.
  await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}
