import 'package:evo/common/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A platform agnostic choice picker.
///
/// It is best used for settings where the user can choose between a relatively
/// small number of options.
class ChoicePicker<T> extends StatelessWidget {
  const ChoicePicker({
    super.key,
    required this.choices,
    required this.selectedItem,
    required this.titleBuilder,
    this.subtitleBuilder,
    this.leadingBuilder,
    required this.onSelectedItemChanged,
    this.tileContentPadding,
    this.margin,
    this.notchedTile = true,
    this.showDividerBetweenTiles = false,
  });

  final List<T> choices;
  final T selectedItem;
  final Widget Function(T choice) titleBuilder;
  final Widget Function(T choice)? subtitleBuilder;
  final Widget Function(T choice)? leadingBuilder;
  final void Function(T choice)? onSelectedItemChanged;

  /// Only on android.
  final bool showDividerBetweenTiles;

  /// Android tiles content padding.
  final EdgeInsetsGeometry? tileContentPadding;

  /// iOS margin.
  final EdgeInsetsGeometry? margin;

  /// iOS only, for choosing the style of the tile.
  final bool notchedTile;

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        final tiles = choices.map((value) {
          return ListTile(
            selected: selectedItem == value,
            trailing: selectedItem == value ? const Icon(Icons.check) : null,
            contentPadding: tileContentPadding,
            title: titleBuilder(value),
            subtitle: subtitleBuilder?.call(value),
            leading: leadingBuilder?.call(value),
            onTap: onSelectedItemChanged != null
                ? () => onSelectedItemChanged!(value)
                : null,
          );
        });
        return Opacity(
          opacity: onSelectedItemChanged != null ? 1.0 : 0.5,
          child: Column(
            children: [
              if (showDividerBetweenTiles)
                ...ListTile.divideTiles(context: context, tiles: tiles)
              else
                ...tiles,
            ],
          ),
        );
      case TargetPlatform.iOS:
        final tileConstructor =
            notchedTile ? CupertinoListTile.notched : CupertinoListTile.new;
        return Padding(
          padding: margin ?? Styles.bodySectionPadding,
          child: Opacity(
            opacity: onSelectedItemChanged != null ? 1.0 : 0.5,
            child: CupertinoListSection.insetGrouped(
              backgroundColor:
                  CupertinoTheme.of(context).scaffoldBackgroundColor,
              decoration: BoxDecoration(
                color: Styles.cupertinoCardColor.resolveFrom(context),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              separatorColor:
                  Styles.cupertinoSeparatorColor.resolveFrom(context),
              margin: EdgeInsets.zero,
              additionalDividerMargin: notchedTile ? null : 6.0,
              hasLeading: leadingBuilder != null,
              children: choices.map((value) {
                return tileConstructor(
                  trailing: selectedItem == value
                      ? const Icon(CupertinoIcons.check_mark_circled_solid)
                      : null,
                  title: titleBuilder(value),
                  subtitle: subtitleBuilder?.call(value),
                  leading: leadingBuilder?.call(value),
                  onTap: onSelectedItemChanged != null
                      ? () => onSelectedItemChanged!(value)
                      : null,
                );
              }).toList(growable: false),
            ),
          ),
        );
      default:
        assert(false, 'Unexpected platform ${Theme.of(context).platform}');
        return const SizedBox.shrink();
    }
  }
}
