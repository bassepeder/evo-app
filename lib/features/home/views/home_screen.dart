import 'package:evo/common/widgets/error_screen.dart';
import 'package:evo/common/widgets/fade_in_widget.dart';
import 'package:evo/features/home/location_repository.dart';
import 'package:evo/features/home/viewmodels/location_controller.dart';
import 'package:evo/features/home/widgets/current_location_visits.dart';
import 'package:evo/features/home/widgets/home_header.dart';
import 'package:evo/features/home/widgets/home_shortcuts.dart';
import 'package:evo/features/home/widgets/location_visits_timeline.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/features/membership/models/membership_details.dart';
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
                    FadeInWidget(
                      child: Column(
                        children: [
                          //MembershipStatusBanner(details: details!),
                          Greeting(details: details!),
                          const HomeShortcuts(),
                          const CurrentLocationVisits(),
                          const LocationVisitsTimeline(),
                        ],
                      ),
                    ),
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

class Greeting extends StatelessWidget {
  final MembershipDetails details;

  const Greeting({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final showAdditionalDetails =
        details.membershipDetails.status != MembershipStatus.active;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${getGreeting(context)}, ${details.profile.firstName}!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  overflow: TextOverflow
                      .ellipsis, // Ensures the greeting and name are truncated if too long
                ),
                if (showAdditionalDetails)
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      children: [
                        TextSpan(
                          text: context.t.homeScreen.membershipStatus,
                        ),
                        TextSpan(
                          text: ' ${MembershipStatusExtensions.translated(
                            details.membershipDetails.status,
                            context,
                          ).toLowerCase()}.',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow
                        .ellipsis, // Ensures only additional details truncate
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getGreeting(BuildContext context) {
    final DateTime now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return '☀️ ${context.t.homeScreen.greetings.morning}';
    } else if (hour >= 12 && hour < 17) {
      return '🌤️ ${context.t.homeScreen.greetings.afternoon}';
    } else {
      return '🌙 ${context.t.homeScreen.greetings.evening}';
    }
  }
}
