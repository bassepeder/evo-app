import 'package:evo/common/widgets/error_screen.dart';
import 'package:evo/features/home/location_repository.dart';
import 'package:evo/features/home/viewmodels/location_controller.dart';
import 'package:evo/features/home/widgets/current_location_visits.dart';
import 'package:evo/features/home/widgets/home_header.dart';
import 'package:evo/features/home/widgets/home_shortcuts.dart';
import 'package:evo/features/home/widgets/location_visits_timeline.dart';
import 'package:evo/features/home/widgets/membership_status_banner.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.watch(membershipDetailsProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getLocationsProvider);
    });

    return Scaffold(
      body: membership.when(
        skipLoadingOnRefresh: false,
        data: (details) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () =>
                  ref.read(locationControllerProvider.notifier).refreshData(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    const HomeHeader(),
                    MembershipStatusBanner(details: details!),
                    const HomeShortcuts(),
                    const CurrentLocationVisits(),
                    const LocationVisitsTimeline(),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () {
          return SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: HomeHeader(),
                ),
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, _) {
          return SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: HomeHeader(),
                ),
                Expanded(
                  child: ErrorScreen(
                    subtitle: context.t.errors.failedToLoadMembershipError,
                    onRetryClicked: () {
                      ref.invalidate(membershipDetailsProvider);
                      ref.invalidate(getLocationsProvider);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
