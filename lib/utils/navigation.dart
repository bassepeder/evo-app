import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A page route that always builds the same screen widget.
///
/// This is useful to inspect new screens being pushed to the Navigator in tests.
abstract class ScreenRoute<T extends Object?> extends PageRoute<T> {
  /// The widget that this page route always builds.
  Widget get screen;
}

/// A [MaterialPageRoute] that always builds the same screen widget.
///
/// This is useful to test new screens being pushed to the Navigator.
class MaterialScreenRoute<T extends Object?> extends MaterialPageRoute<T>
    implements ScreenRoute<T> {
  MaterialScreenRoute({
    required this.screen,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
    super.allowSnapshotting,
  }) : super(builder: (_) => screen);

  @override
  final Widget screen;
}

/// A [CupertinoPageRoute] that always builds the same screen widget.
///
/// This is useful to test new screens being pushed to the Navigator.
class CupertinoScreenRoute<T extends Object?> extends CupertinoPageRoute<T>
    implements ScreenRoute<T> {
  CupertinoScreenRoute({
    required this.screen,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
    super.title,
  }) : super(builder: (_) => screen);

  @override
  final Widget screen;
}

/// Push a new route using Navigator.
///
/// Either [builder] or [screen] must be provided.
///
/// If [builder] if provided, it will return a [MaterialPageRoute] on Android and
/// a [CupertinoPageRoute] on iOS.
///
/// If [screen] is provided, it will return a [MaterialScreenRoute] on Android and
/// a [CupertinoScreenRoute] on iOS.
Future<void> pushPlatformRoute(
  BuildContext context, {
  Widget? screen,
  WidgetBuilder? builder,
  bool rootNavigator = false,
  bool fullscreenDialog = false,
  String? title,
}) {
  assert(
    screen != null || builder != null,
    'Either screen or builder must be provided.',
  );

  return Navigator.of(context, rootNavigator: rootNavigator).push<void>(
    Theme.of(context).platform == TargetPlatform.iOS
        ? builder != null
            ? CupertinoPageRoute(
                builder: builder,
                title: title,
                fullscreenDialog: fullscreenDialog,
              )
            : CupertinoScreenRoute(
                screen: screen!,
                title: title,
                fullscreenDialog: fullscreenDialog,
              )
        : builder != null
            ? MaterialPageRoute(
                builder: builder,
                fullscreenDialog: fullscreenDialog,
              )
            : MaterialScreenRoute(
                screen: screen!,
                fullscreenDialog: fullscreenDialog,
              ),
  );
}

/// Push a new route using Navigator and replace the current route.
///
/// Either [builder] or [screen] must be provided.
///
/// If [builder] if provided, it will return a [MaterialPageRoute] on Android and
/// a [CupertinoPageRoute] on iOS.
///
/// If [screen] is provided, it will return a [MaterialScreenRoute] on Android and
/// a [CupertinoScreenRoute] on iOS.
Future<void> pushReplacementPlatformRoute(
  BuildContext context, {
  WidgetBuilder? builder,
  Widget? screen,
  bool rootNavigator = false,
  bool fullscreenDialog = false,
  String? title,
}) {
  return Navigator.of(
    context,
    rootNavigator: rootNavigator,
  ).pushReplacement<void, void>(
    Theme.of(context).platform == TargetPlatform.iOS
        ? builder != null
            ? CupertinoPageRoute(
                builder: builder,
                title: title,
                fullscreenDialog: fullscreenDialog,
              )
            : CupertinoScreenRoute(
                screen: screen!,
                title: title,
                fullscreenDialog: fullscreenDialog,
              )
        : builder != null
            ? MaterialPageRoute(
                builder: builder,
                fullscreenDialog: fullscreenDialog,
              )
            : MaterialScreenRoute(
                screen: screen!,
                fullscreenDialog: fullscreenDialog,
              ),
  );
}

/// Pushes a new route and removes all previous routes until a condition is met.
///
/// This method allows you to navigate to a new screen and optionally keep the first route in the stack.
///
/// Either [screen] or [builder] must be provided. If [screen] is provided, it will return a
/// [MaterialScreenRoute] on Android and a [CupertinoScreenRoute] on iOS. If [builder] is provided,
/// it will return a [MaterialPageRoute] on Android and a [CupertinoPageRoute] on iOS.
///
/// The [keepFirstRoute] parameter determines whether to retain the first route in the navigation stack.
/// If set to `true`, the first route will be kept; otherwise, all previous routes will be removed.
///
/// The [rootNavigator] parameter specifies whether to use the root navigator.
///
/// The [fullscreenDialog] parameter specifies whether the new route should be a fullscreen dialog.
///
/// [title] can be provided for the route, especially for iOS.
///
/// Example usage:
/// ```dart
/// pushAndRemoveUntilPlatformRoute(
///   context,
///   screen: SignUpScreen(),
///   keepFirstRoute: true,
/// );
/// ```
Future<void> pushAndRemoveUntilPlatformRoute(
  BuildContext context, {
  Widget? screen,
  WidgetBuilder? builder,
  bool rootNavigator = false,
  bool fullscreenDialog = false,
  bool keepFirstRoute = false,
  String? title,
}) {
  assert(
    screen != null || builder != null,
    'Either screen or builder must be provided.',
  );

  return Navigator.of(context, rootNavigator: rootNavigator)
      .pushAndRemoveUntil<void>(
    Theme.of(context).platform == TargetPlatform.iOS
        ? builder != null
            ? CupertinoPageRoute(
                builder: builder,
                title: title,
                fullscreenDialog: fullscreenDialog,
              )
            : CupertinoScreenRoute(
                screen: screen!,
                title: title,
                fullscreenDialog: fullscreenDialog,
              )
        : builder != null
            ? MaterialPageRoute(
                builder: builder,
                fullscreenDialog: fullscreenDialog,
              )
            : MaterialScreenRoute(
                screen: screen!,
                fullscreenDialog: fullscreenDialog,
              ),
    (route) => keepFirstRoute ? route.isFirst : false,
  );
}
