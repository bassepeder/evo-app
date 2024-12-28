import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'evo_colors.dart';

// ignore: avoid_classes_with_only_static_members
abstract class Styles {
  // text
  static const bold = TextStyle(fontWeight: FontWeight.bold);
  static const title = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  static const subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final callout = TextStyle(
    fontSize: defaultTargetPlatform == TargetPlatform.iOS ? 20 : 18,
    letterSpacing: defaultTargetPlatform == TargetPlatform.iOS ? -0.41 : null,
    fontWeight: FontWeight.w600,
  );
  static final mainListTileTitle = TextStyle(
    fontSize: defaultTargetPlatform == TargetPlatform.iOS ? 19 : 18,
    letterSpacing: defaultTargetPlatform == TargetPlatform.iOS ? -0.41 : null,
    fontWeight: FontWeight.w500,
  );
  static const mainListTileIconSize = 28.0;
  static final sectionTitle = TextStyle(
    fontSize: defaultTargetPlatform == TargetPlatform.iOS ? 20 : 18,
    letterSpacing: defaultTargetPlatform == TargetPlatform.iOS ? -0.41 : null,
    fontWeight: FontWeight.bold,
  );
  static const boardPreviewTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const subtitleOpacity = 0.7;
  static const timeControl = TextStyle(
    letterSpacing: 1.2,
  );
  static const formLabel = TextStyle(
    fontWeight: FontWeight.bold,
  );
  static const formDescription = TextStyle(fontSize: 12);

  // padding
  static const cupertinoAppBarTrailingWidgetPadding =
      EdgeInsetsDirectional.only(
    end: 8.0,
  );
  static const bodyPadding =
      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
  static const verticalBodyPadding = EdgeInsets.symmetric(vertical: 16.0);
  static const horizontalBodyPadding = EdgeInsets.symmetric(horizontal: 16.0);
  static const sectionBottomPadding = EdgeInsets.only(bottom: 16.0);
  static const sectionTopPadding = EdgeInsets.only(top: 16.0);
  static const bodySectionPadding = EdgeInsets.all(16.0);

  /// Horizontal and bottom padding for the body section.
  static const bodySectionBottomPadding = EdgeInsets.only(
    bottom: 16.0,
    left: 16.0,
    right: 16.0,
  );

  // colors
  static Color? expansionTileColor(BuildContext context) =>
      defaultTargetPlatform == TargetPlatform.iOS
          ? CupertinoColors.secondaryLabel.resolveFrom(context)
          : null;
  static const cupertinoAppBarColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xE6F9F9F9),
    darkColor: Color.fromARGB(210, 36, 36, 38),
  );
  static const cupertinoTabletAppBarColor =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFF9F9F9),
    darkColor: Color.fromARGB(255, 36, 36, 36),
  );
  static const cupertinoScaffoldColor = CupertinoDynamicColor.withBrightness(
    color: Color.fromARGB(255, 242, 242, 247),
    darkColor: Color.fromARGB(255, 23, 23, 23),
  );

  static const _cupertinoDarkLabelColor = Color(0xFFDCDCDC);
  static const cupertinoLabelColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF000000),
    darkColor: _cupertinoDarkLabelColor,
  );
  static const cupertinoTitleColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF000000),
    darkColor: Color(0xFFF5F5F5),
  );
  static const cupertinoCardColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF),
    darkColor: Color.fromARGB(255, 44, 44, 46),
  );
  static const cupertinoSeparatorColor = CupertinoDynamicColor.withBrightness(
    debugLabel: 'separator',
    color: Color.fromARGB(73, 60, 60, 67),
    darkColor: Color.fromARGB(153, 101, 101, 105),
  );

  /// A Material Design text theme with light glyphs based on San Francisco.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  ///
  /// This theme uses the iOS version of the font names.
  static const TextTheme whiteCupertinoTextTheme = TextTheme(
    displayLarge: TextStyle(
      debugLabel: 'whiteCupertino displayLarge',
      fontFamily: 'CupertinoSystemDisplay',
      color: Color(0xFFF5F5F5),
      decoration: TextDecoration.none,
    ),
    displayMedium: TextStyle(
      debugLabel: 'whiteCupertino displayMedium',
      fontFamily: 'CupertinoSystemDisplay',
      color: Color(0xFFF5F5F5),
      decoration: TextDecoration.none,
    ),
    displaySmall: TextStyle(
      debugLabel: 'whiteCupertino displaySmall',
      fontFamily: 'CupertinoSystemDisplay',
      color: Color(0xFFF5F5F5),
      decoration: TextDecoration.none,
    ),
    headlineLarge: TextStyle(
      debugLabel: 'whiteCupertino headlineLarge',
      fontFamily: 'CupertinoSystemDisplay',
      color: Color(0xFFF5F5F5),
      decoration: TextDecoration.none,
    ),
    headlineMedium: TextStyle(
      debugLabel: 'whiteCupertino headlineMedium',
      fontFamily: 'CupertinoSystemDisplay',
      color: Color(0xFFF5F5F5),
      decoration: TextDecoration.none,
    ),
    headlineSmall: TextStyle(
      debugLabel: 'whiteCupertino headlineSmall',
      fontFamily: 'CupertinoSystemDisplay',
      color: Color(0xFFF5F5F5),
      decoration: TextDecoration.none,
    ),
    titleLarge: TextStyle(
      debugLabel: 'whiteCupertino titleLarge',
      fontFamily: 'CupertinoSystemDisplay',
      color: _cupertinoDarkLabelColor,
      decoration: TextDecoration.none,
    ),
    titleMedium: TextStyle(
      debugLabel: 'whiteCupertino titleMedium',
      fontFamily: 'CupertinoSystemText',
      color: _cupertinoDarkLabelColor,
      decoration: TextDecoration.none,
    ),
    titleSmall: TextStyle(
      debugLabel: 'whiteCupertino titleSmall',
      fontFamily: 'CupertinoSystemText',
      color: _cupertinoDarkLabelColor,
      decoration: TextDecoration.none,
    ),
    bodyLarge: TextStyle(
      debugLabel: 'whiteCupertino bodyLarge',
      fontFamily: 'CupertinoSystemText',
      color: _cupertinoDarkLabelColor,
      decoration: TextDecoration.none,
    ),
    bodyMedium: TextStyle(
      debugLabel: 'whiteCupertino bodyMedium',
      fontFamily: 'CupertinoSystemText',
      color: _cupertinoDarkLabelColor,
      decoration: TextDecoration.none,
    ),
    bodySmall: TextStyle(
      debugLabel: 'whiteCupertino bodySmall',
      fontFamily: 'CupertinoSystemText',
      color: _cupertinoDarkLabelColor,
      decoration: TextDecoration.none,
    ),
    labelLarge: TextStyle(
      debugLabel: 'whiteCupertino labelLarge',
      fontFamily: 'CupertinoSystemText',
      color: _cupertinoDarkLabelColor,
      decoration: TextDecoration.none,
    ),
    labelMedium: TextStyle(
      debugLabel: 'whiteCupertino labelMedium',
      fontFamily: 'CupertinoSystemText',
      color: _cupertinoDarkLabelColor,
      decoration: TextDecoration.none,
    ),
    labelSmall: TextStyle(
      debugLabel: 'whiteCupertino labelSmall',
      fontFamily: 'CupertinoSystemText',
      color: _cupertinoDarkLabelColor,
      decoration: TextDecoration.none,
    ),
  );

  // from:
  // https://github.com/flutter/flutter/blob/796c8ef79279f9c774545b3771238c3098dbefab/packages/flutter/lib/src/cupertino/bottom_tab_bar.dart#L17
  static const CupertinoDynamicColor cupertinoDefaultTabBarBorderColor =
      CupertinoDynamicColor.withBrightness(
    color: Color(0x4D000000),
    darkColor: Color(0x29000000),
  );
}

/// Retrieve the default text color and apply an opacity to it.
Color? textShade(BuildContext context, double opacity) =>
    DefaultTextStyle.of(context).style.color?.withValues(alpha: opacity);

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.good,
    required this.error,
    required this.primary,
  });

  final Color good;
  final Color error;
  final Color primary;

  @override
  CustomColors copyWith({
    Color? good,
    Color? error,
    Color? primary,
  }) {
    return CustomColors(
      good: good ?? this.good,
      error: error ?? this.error,
      primary: primary ?? this.primary,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      good: Color.lerp(good, other.good, t) ?? good,
      error: Color.lerp(error, other.error, t) ?? error,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
    );
  }

  CustomColors harmonized(ColorScheme colorScheme) {
    return copyWith(
      good: good.harmonizeWith(colorScheme.primary),
      error: error.harmonizeWith(colorScheme.primary),
      primary: primary.harmonizeWith(colorScheme.primary),
    );
  }
}

const evoCustomColors = CustomColors(
  good: EvoColors.good,
  error: EvoColors.error,
  primary: EvoColors.primary,
);

extension CustomColorsBuildContext on BuildContext {
  CustomColors get evoColors =>
      Theme.of(this).extension<CustomColors>() ?? evoCustomColors;
}
