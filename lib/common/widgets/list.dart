import 'package:evo/common/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Platform agnostic list tile widget.
///
/// Will use [ListTile] on android and [CupertinoListTile] on iOS.
class PlatformListTile extends StatelessWidget {
  const PlatformListTile({
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.additionalInfo,
    this.dense,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.isThreeLine = false,
    this.padding,
    this.cupertinoBackgroundColor,
    this.visualDensity,
    this.harmonizeCupertinoTitleStyle = false,
    super.key,
  });

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;

  final EdgeInsetsGeometry? padding;

  final Color? cupertinoBackgroundColor;

  /// only on iOS
  final Widget? additionalInfo;

  /// Useful on some screens where ListTiles with and without subtitle are mixed.
  final bool harmonizeCupertinoTitleStyle;

  final bool selected;

  // only on android
  final bool? dense;

  // only on android
  final bool isThreeLine;

  /// Only on android.
  final VisualDensity? visualDensity;

  final GestureTapCallback? onTap;

  // Only on android
  final GestureLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return ListTile(
          leading: leading,
          title: title,
          iconColor: Theme.of(context).colorScheme.outline,
          subtitle: subtitle != null
              ? DefaultTextStyle.merge(
                  child: subtitle!,
                  style: TextStyle(
                    color: textShade(context, 0.7),
                  ),
                )
              : null,
          trailing: trailing,
          dense: dense,
          visualDensity: visualDensity,
          onTap: onTap,
          onLongPress: onLongPress,
          selected: selected,
          isThreeLine: isThreeLine,
          contentPadding: padding,
        );
      case TargetPlatform.iOS:
        return IconTheme(
          data: CupertinoIconThemeData(
            color: CupertinoColors.systemGrey.resolveFrom(context),
          ),
          child: GestureDetector(
            onLongPress: onLongPress,
            child: CupertinoListTile.notched(
              backgroundColor: selected == true
                  ? CupertinoColors.systemGrey4.resolveFrom(context)
                  : cupertinoBackgroundColor,
              leading: leading,
              title: harmonizeCupertinoTitleStyle
                  ? DefaultTextStyle.merge(
                      // see: https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/cupertino/list_tile.dart
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      child: title,
                    )
                  : title,
              subtitle: subtitle,
              trailing: trailing ??
                  (selected == true
                      ? const Icon(CupertinoIcons.check_mark_circled_solid)
                      : null),
              additionalInfo: additionalInfo,
              padding: padding,
              onTap: onTap,
            ),
          ),
        );

      default:
        assert(false, 'Unexpected platform ${Theme.of(context).platform}');
        return const SizedBox.shrink();
    }
  }
}
