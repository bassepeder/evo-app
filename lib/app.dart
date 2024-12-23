import 'package:dynamic_color/dynamic_color.dart';
import 'package:evo/common/preloaded_data.dart';
import 'package:evo/features/auth/providers/auth_session.dart';
import 'package:evo/features/home/views/home_screen.dart';
import 'package:evo/features/settings/brightness.dart';
import 'package:evo/features/settings/general_preferences.dart';
import 'package:evo/features/welcome_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/styles.dart';

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
class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ConsumerState<Application> createState() => _AppState();
}

class _AppState extends ConsumerState<Application> {
  AppLifecycleListener? _appLifecycleListener;

  @override
  void initState() {
    _appLifecycleListener = AppLifecycleListener(
      onResume: () async {},
    );
    super.initState();
  }

  @override
  void dispose() {
    _appLifecycleListener?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        // TODO remove this workaround when the dynamic_color colorScheme bug is fixed
        // See: https://github.com/material-foundation/flutter-packages/issues/574
        final (
          fixedLightScheme,
          fixedDarkScheme
        ) = lightColorScheme != null && darkColorScheme != null
            ? _generateDynamicColourSchemes(lightColorScheme, darkColorScheme)
            : (null, null);

        final dynamicColorScheme =
            brightness == Brightness.light ? fixedLightScheme : fixedDarkScheme;

        final colorScheme =
            generalPrefs.systemColors && dynamicColorScheme != null
                ? dynamicColorScheme
                : ColorScheme.fromSeed(
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
                )
                    .textTheme
                    .textStyle
                    .copyWith(color: Styles.cupertinoLabelColor),
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
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
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
                        color: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .color,
                      ),
                      child: Material(child: child),
                    ),
                  );
                }
              : null,
          navigatorKey: ref.read(navigatorProvider),
          home: hasSession ? const HomeScreen() : const WelcomeScreen(),
        );
      },
    );
  }
}

(ColorScheme light, ColorScheme dark) _generateDynamicColourSchemes(
  ColorScheme lightDynamic,
  ColorScheme darkDynamic,
) {
  final lightBase = ColorScheme.fromSeed(seedColor: lightDynamic.primary);
  final darkBase = ColorScheme.fromSeed(
    seedColor: darkDynamic.primary,
    brightness: Brightness.dark,
  );

  final lightAdditionalColours = _extractAdditionalColours(lightBase);
  final darkAdditionalColours = _extractAdditionalColours(darkBase);

  final lightScheme =
      _insertAdditionalColours(lightBase, lightAdditionalColours);
  final darkScheme = _insertAdditionalColours(darkBase, darkAdditionalColours);

  return (lightScheme.harmonized(), darkScheme.harmonized());
}

List<Color> _extractAdditionalColours(ColorScheme scheme) => [
      scheme.surface,
      scheme.surfaceDim,
      scheme.surfaceBright,
      scheme.surfaceContainerLowest,
      scheme.surfaceContainerLow,
      scheme.surfaceContainer,
      scheme.surfaceContainerHigh,
      scheme.surfaceContainerHighest,
    ];

ColorScheme _insertAdditionalColours(
  ColorScheme scheme,
  List<Color> additionalColours,
) =>
    scheme.copyWith(
      surface: additionalColours[0],
      surfaceDim: additionalColours[1],
      surfaceBright: additionalColours[2],
      surfaceContainerLowest: additionalColours[3],
      surfaceContainerLow: additionalColours[4],
      surfaceContainer: additionalColours[5],
      surfaceContainerHigh: additionalColours[6],
      surfaceContainerHighest: additionalColours[7],
    );
