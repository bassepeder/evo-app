import 'package:evo/common/widgets/icon_button_with_counter.dart';
import 'package:evo/features/settings/views/settings_screen.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Image.asset(
              'assets/images/logo.png',
              width: 72,
              height: 72,
            ),
          ),
          Spacer(),
          IconButtonWithCounter(
            svgSrc: userIcon,
            press: () {},
          ),
          const SizedBox(width: 8),
          IconButtonWithCounter(
            svgSrc: settingsIcon,
            press: () {
              HapticFeedback.mediumImpact();
              pushPlatformRoute(
                context,
                builder: (_) => const SettingsScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}

const settingsIcon = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.325.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 0 1 1.37.49l1.296 2.247a1.125 1.125 0 0 1-.26 1.431l-1.003.827c-.293.241-.438.613-.43.992a7.723 7.723 0 0 1 0 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 0 1-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 0 1-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 0 1-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 0 1-1.369-.49l-1.297-2.247a1.125 1.125 0 0 1 .26-1.431l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 0 1 0-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 0 1-.26-1.43l1.297-2.247a1.125 1.125 0 0 1 1.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28Z" />
  <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
</svg>
''';

const userIcon = '''
<svg width="15" height="15" viewBox="0 0 18 16" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" clip-rule="evenodd" d="M14.8331 14.6608C14.6271 14.9179 14.3055 15.0713 13.9729 15.0713H2.02715C1.69446 15.0713 1.37287 14.9179 1.16692 14.6608C0.972859 14.4191 0.906322 14.1271 0.978404 13.8382C1.77605 10.6749 4.66327 8.46512 8.0004 8.46512C11.3367 8.46512 14.2239 10.6749 15.0216 13.8382C15.0937 14.1271 15.0271 14.4191 14.8331 14.6608ZM4.62208 4.23295C4.62208 2.41197 6.13737 0.929467 8.0004 0.929467C9.86263 0.929467 11.3779 2.41197 11.3779 4.23295C11.3779 6.0547 9.86263 7.53565 8.0004 7.53565C6.13737 7.53565 4.62208 6.0547 4.62208 4.23295ZM15.9444 13.6159C15.2283 10.7748 13.0231 8.61461 10.2571 7.84315C11.4983 7.09803 12.3284 5.75882 12.3284 4.23295C12.3284 1.89921 10.387 0 8.0004 0C5.613 0 3.67155 1.89921 3.67155 4.23295C3.67155 5.75882 4.50168 7.09803 5.7429 7.84315C2.97688 8.61461 0.771665 10.7748 0.0556038 13.6159C-0.0861827 14.179 0.0460985 14.7692 0.419179 15.2332C0.808894 15.7212 1.39584 16 2.02715 16H13.9729C14.6042 16 15.1911 15.7212 15.5808 15.2332C15.9539 14.7692 16.0862 14.179 15.9444 13.6159Z" fill="currentColor"/>
</svg>
''';
