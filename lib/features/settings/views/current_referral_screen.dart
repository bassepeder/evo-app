import 'package:evo/common/widgets/error_screen.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentReferralScreen extends ConsumerWidget {
  const CurrentReferralScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final referralCode = ref.read(
      membershipDetailsProvider
          .select((membership) => membership.requireValue!.referralCode),
    );
    final currentMembershipReferral =
        ref.watch(currentMembershipReferralProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.currentReferralScreen.appbar),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      children: [
                        TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          text: '${context.t.currentReferralScreen.header}:\n',
                        ),
                        TextSpan(
                          text: referralCode,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                currentMembershipReferral.when(
                  data: (referral) {
                    return Column(
                      children: [
                        const SizedBox(height: 64),
                        Text(
                          textAlign: TextAlign.center,
                          referral.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    );
                  },
                  loading: () {
                    return const Column(children: [
                      SizedBox(height: 48),
                      Center(
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ],);
                  },
                  error: (_, stack) {
                    return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: ErrorScreen(
                        subtitle: context
                            .t.errors.failedToLoadCurrentMembershipReferral,
                        onRetryClicked: () =>
                            ref.invalidate(currentMembershipReferralProvider),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;

  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
