import 'package:evo/features/home/widgets/home_header.dart';
import 'package:evo/features/home/widgets/home_shortcuts.dart';
import 'package:evo/features/home/widgets/membership_actions_grid.dart';
import 'package:evo/features/home/widgets/membership_status_banner.dart';
import 'package:evo/features/home/widgets/workouts_overview.dart';
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
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  HomeHeader(),
                  MembershipStatusBanner(details: details!),
                  HomeShortcuts(),
                  WorkoutsOverview(),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('En feil oppstod'),
        ),
      ),
    );
  }
}
