import 'package:evo/features/home/widgets/current_location_overview.dart';
import 'package:evo/features/home/widgets/home_header.dart';
import 'package:evo/features/home/widgets/home_shortcuts.dart';
import 'package:evo/features/home/widgets/location_overview_timeline.dart';
import 'package:evo/features/home/widgets/membership_status_banner.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.watch(membershipDetailsProvider);

    return Scaffold(
      body: membership.when(
        data: (details) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  const HomeHeader(disableButtons: false),
                  MembershipStatusBanner(details: details!),
                  const HomeShortcuts(),
                  const CurrentLocationOverview(),
                  const LocationOverviewTimeline(),
                ],
              ),
            ),
          );
        },
        loading: () {
          return const SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: HomeHeader(disableButtons: true),
                ),
                Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          );
        },
        error: (error, _) => const Center(
          child: Text('En feil oppstod'),
        ),
      ),
    );
  }
}
