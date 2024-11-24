import 'package:evo/app.dart';
import 'package:evo/binding.dart';
import 'package:evo/common/widgets/evo_elevated_button.dart';
import 'package:evo/features/auth/views/sign_in_screen.dart';
import 'package:evo/init.dart';
import 'package:evo/log.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i18n/translations.g.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final evoBinding = AppEvoBinding.ensureInitialized();

  LocaleSettings.useDeviceLocale();

  await evoBinding.preloadSharedPreferences();

  await setupFirstLaunch();

  // Lock orientation to portrait.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  if (defaultTargetPlatform == TargetPlatform.android) {
    await androidDisplayInitialization(widgetsBinding);
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  if (defaultTargetPlatform == TargetPlatform.android) {
    // Sets edge-to-edge system UI mode on Android 12+
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
      ),
    );
  }

  runApp(ProviderScope(
    observers: [
      ProviderLogger(),
    ],
    child: TranslationProvider(
      child: const AppInitializationScreen(),
    ),
  ));
}
