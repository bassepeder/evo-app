import 'package:evo/common/widgets/adaptive_bottom_sheet.dart';
import 'package:evo/common/widgets/themed_icon.dart';
import 'package:evo/features/home/widgets/keys_menu.dart';
import 'package:evo/features/workouts/workouts_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeShortcuts extends StatelessWidget {
  const HomeShortcuts({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Shortcut> shortcuts = [
      Shortcut(
        id: 'keys',
        svgIcon: keyIcon,
        title: context.t.homeScreen.shortcuts[0],
      ),
      Shortcut(
        id: 'workouts',
        svgIcon: workoutIcon,
        title: context.t.homeScreen.shortcuts[1],
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          shortcuts.length,
          (index) => ShortcutCard(
            icon: shortcuts[index].svgIcon,
            text: shortcuts[index].title,
            press: () {
              final id = shortcuts[index].id;

              HapticFeedback.mediumImpact();

              if (id == 'keys') {
                showAdaptiveBottomSheet<int>(
                  context: context,
                  builder: (_) => KeysMenu(),
                );
              } else {
                pushPlatformRoute(
                  context,
                  builder: (_) => const WorkoutsScreen(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ShortcutCard extends StatelessWidget {
  final String icon;
  final String text;
  final GestureTapCallback press;

  const ShortcutCard({
    super.key,
    required this.icon,
    required this.text,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: press,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                ThemedIcon(svgData: icon),
                const SizedBox(width: 8),
                Text(text, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Shortcut {
  final String id;
  final String svgIcon;
  final String title;

  const Shortcut({
    required this.id,
    required this.svgIcon,
    required this.title,
  });
}

const workoutIcon = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="#C00080" class="size-6">
      <g fill="none" stroke="currentColor" stroke-width="1.5">
        <path d="M15.5 9v6c0 .465 0 .697.051.888a1.5 1.5 0 0 0 1.06 1.06c.191.052.424.052.889.052s.698 0 .888-.051a1.5 1.5 0 0 0 1.06-1.06c.052-.191.052-.424.052-.889V9c0-.465 0-.697-.051-.888a1.5 1.5 0 0 0-1.06-1.06C18.197 7 17.964 7 17.5 7s-.698 0-.888.051a1.5 1.5 0 0 0-1.06 1.06c-.052.192-.052.424-.052.889Zm-11 0v6c0 .465 0 .697.051.888a1.5 1.5 0 0 0 1.06 1.06c.192.052.424.052.889.052s.697 0 .888-.051a1.5 1.5 0 0 0 1.06-1.06c.052-.191.052-.424.052-.889V9c0-.465 0-.697-.051-.888a1.5 1.5 0 0 0-1.06-1.06C7.196 7 6.964 7 6.5 7s-.697 0-.888.051a1.5 1.5 0 0 0-1.06 1.06C4.5 8.304 4.5 8.536 4.5 9Z"/>
        <path d="M5 10H4a2 2 0 1 0 0 4h1m4-2h6m4 2h1a2 2 0 1 0 0-4h-1"/>
      </g>
    </svg>''';

const keyIcon = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25a3 3 0 0 1 3 3m3 0a6 6 0 0 1-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1 1 21.75 8.25Z" />
</svg>
''';
