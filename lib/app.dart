import 'package:evo/common/preloaded_data.dart';
import 'package:evo/features/auth/providers/auth_session.dart';
import 'package:evo/features/home/views/home_screen.dart';
import 'package:evo/features/settings/brightness.dart';
import 'package:evo/features/settings/general_preferences.dart';
import 'package:evo/features/welcome_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_form_field/phone_form_field.dart';

import 'common/styles.dart';

final RouteObserver<PageRoute<void>> rootNavPageRouteObserver =
    RouteObserver<PageRoute<void>>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Application initialization and main entry point.
class AppInitializationScreen extends ConsumerWidget {
  const AppInitializationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<PreloadedData>>(
      preloadedDataProvider,
      (_, state) {
        if (state.hasValue || state.hasError) {
          FlutterNativeSplash.remove();
        }
      },
    );

    return ref.watch(preloadedDataProvider).when(
          data: (_) => const Application(),
          // loading screen is handled by the native splash screen
          loading: () => const SizedBox.shrink(),
          error: (err, st) {
            debugPrint(
              'SEVERE: [App] could not initialize app; $err\n$st',
            );
            return const SizedBox.shrink();
          },
        );
  }
}

/// The main application widget.
///
/// This widget is the root of the application and is responsible for setting up
/// the theme, locale, and other global settings.
class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generalPrefs = ref.watch(generalPreferencesProvider);
    final brightness = ref.watch(currentBrightnessProvider);

    if (generalPrefs.locale != null) {
      LocaleSettings.setLocaleRaw(generalPrefs.locale!.languageCode);
    } else {
      LocaleSettings.useDeviceLocale();
    }

    final hasSession = ref.read(
      authSessionProvider.select((it) => it?.token.isNotEmpty ?? false),
    );

    final colorScheme = ColorScheme.fromSeed(
      seedColor: evoCustomColors.primary,
      brightness: brightness,
    );

    final cupertinoThemeData = CupertinoThemeData(
      primaryColor: colorScheme.primary,
      primaryContrastingColor: colorScheme.onPrimary,
      brightness: brightness,
      textTheme: CupertinoTheme.of(context).textTheme.copyWith(
            primaryColor: colorScheme.primary,
            textStyle: CupertinoTheme.of(
              context,
            ).textTheme.textStyle.copyWith(color: Styles.cupertinoLabelColor),
            navTitleTextStyle: CupertinoTheme.of(
              context,
            )
                .textTheme
                .navTitleTextStyle
                .copyWith(color: Styles.cupertinoTitleColor),
            navLargeTitleTextStyle: CupertinoTheme.of(
              context,
            )
                .textTheme
                .navLargeTitleTextStyle
                .copyWith(color: Styles.cupertinoTitleColor),
          ),
      scaffoldBackgroundColor: Styles.cupertinoScaffoldColor,
      barBackgroundColor: Styles.cupertinoAppBarColor,
    );

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        ...PhoneFieldLocalization.delegates,
      ],
      supportedLocales: AppLocaleUtils.supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => 'EVO',
      locale: TranslationProvider.of(context).flutterLocale,
      theme: ThemeData.from(
        colorScheme: colorScheme,
        textTheme: Theme.of(context).platform == TargetPlatform.iOS
            ? brightness == Brightness.light
                ? Typography.blackCupertino
                : Styles.whiteCupertinoTextTheme
            : null,
        useMaterial3: true,
      ).copyWith(
        cupertinoOverrideTheme: cupertinoThemeData,
        extensions: [evoCustomColors.harmonized(colorScheme)],
      ),
      themeMode: switch (generalPrefs.themeMode) {
        BackgroundThemeMode.light => ThemeMode.light,
        BackgroundThemeMode.dark => ThemeMode.dark,
        BackgroundThemeMode.system => ThemeMode.system,
      },
      builder: Theme.of(context).platform == TargetPlatform.iOS
          ? (context, child) {
              return CupertinoTheme(
                data: cupertinoThemeData,
                child: IconTheme.merge(
                  data: IconThemeData(
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                  child: Material(child: child),
                ),
              );
            }
          : null,
      navigatorKey: navigatorKey,
      home: hasSession ? const HomeScreen() : const WelcomeScreen(),
      navigatorObservers: [rootNavPageRouteObserver],
    );
  }
}
