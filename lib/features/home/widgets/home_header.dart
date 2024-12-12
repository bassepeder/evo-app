import 'package:evo/common/id.dart';
import 'package:evo/common/widgets/adaptive_bottom_sheet.dart';
import 'package:evo/common/widgets/icon_button_with_counter.dart';
import 'package:evo/common/widgets/list.dart';
import 'package:evo/features/home/location_repository.dart';
import 'package:evo/features/home/viewmodels/location_controller.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/features/settings/settings_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.read(membershipDetailsProvider);

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
          const Spacer(),
          IconButtonWithCounter(
            svgSrc: mapPinIcon,
            press: () {
              if (!membership.hasValue) return;

              HapticFeedback.mediumImpact();
              final double screenHeight = MediaQuery.sizeOf(context).height;

              showAdaptiveBottomSheet<int>(
                context: context,
                isScrollControlled: true,
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.6,
                ),
                builder: (_) => _LocationPickerMenu(
                  currentLocationId:
                      ref.read(locationControllerProvider).locationId!,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          IconButtonWithCounter(
            svgSrc: settingsIcon,
            press: () {
              if (!membership.hasValue) return;

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

const mapPinIcon = '''
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
</svg>
''';

class _LocationPickerMenu extends ConsumerStatefulWidget {
  final LocationId currentLocationId;

  const _LocationPickerMenu({
    required this.currentLocationId,
  });

  @override
  ConsumerState<_LocationPickerMenu> createState() =>
      _LocationPickerMenuState();
}

class _LocationPickerMenuState extends ConsumerState<_LocationPickerMenu> {
  final currentLocationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final primaryMembershipLocationId =
        ref.read(membershipDetailsProvider).requireValue!.location.id;
    final locationsProvider = ref.read(getLocationsProvider);

    // Scroll to the current location.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentLocationKey.currentContext != null) {
        Scrollable.ensureVisible(
          currentLocationKey.currentContext!,
          alignment: 0.5,
        );
      }
    });

    return locationsProvider.when(
      data: (locations) => BottomSheetScrollableContainer(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.homeScreen.chooseLocation,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              for (final location in locations)
                PlatformListTile(
                  key: location.id == widget.currentLocationId
                      ? currentLocationKey
                      : null,
                  title: Text(location.name, maxLines: 2),
                  subtitle: primaryMembershipLocationId == location.id
                      ? Text(context.t.homeScreen.primaryMembershipLocation)
                      : null,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  leading: const Icon(Icons.pin_drop),
                  onTap: () {
                    ref
                        .read(locationControllerProvider.notifier)
                        .setNewLocation(
                          location.id,
                          location.name,
                        );
                    Navigator.pop(context);
                  },
                  selected: location.id == widget.currentLocationId,
                ),
            ],
          ),
        ],
      ),
      error: (e, _) => Text(context.t.errors.failedToLoadLocations),
      loading: () => const Column(
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ],
      ),
    );
  }
}
