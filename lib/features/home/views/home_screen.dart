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
import 'package:evo/features/settings/views/membership_details_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/navigation.dart';
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
                          Greeting(details: details),
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

class Greeting extends StatefulWidget {
  final MembershipDetails details;

  const Greeting({super.key, required this.details});

  @override
  _GreetingState createState() => _GreetingState();
}

class _GreetingState extends State<Greeting> with WidgetsBindingObserver {
  late String greetingIcon;
  late String greeting;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void updateGreeting() {
    final data = getGreeting(context);

    setState(() {
      greetingIcon = data.$1;
      greeting = data.$2;
    });
  }

  (String, String) getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return ('☀️', context.t.homeScreen.greetings.morning);
    } else if (hour >= 12 && hour < 17) {
      return ('🌤️', context.t.homeScreen.greetings.afternoon);
    } else {
      return ('🌙', context.t.homeScreen.greetings.evening);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateGreeting();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateGreeting();
    }
  }

  @override
  Widget build(BuildContext context) {
    final showAdditionalDetails =
        widget.details.membershipDetails.status != MembershipStatus.active;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Row(
        children: [
          Text(
            greetingIcon,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, ${widget.details.profile.firstName}!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  softWrap: true,
                  /*
                  overflow: TextOverflow
                      .ellipsis, // Ensures the greeting and name are truncated if too long
                   */
                ),
                if (showAdditionalDetails)
                  GestureDetector(
                    onTap: () => pushPlatformRoute(
                      context,
                      builder: (_) => const MembershipDetailsScreen(),
                    ),
                    child: Text.rich(
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
                              widget.details.membershipDetails.status,
                              context,
                            ).toLowerCase()}.',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow
                          .ellipsis, // Ensures only additional details truncate
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
