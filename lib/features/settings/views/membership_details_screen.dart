import 'package:evo/constants.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/features/membership/models/membership_details.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/formatting.dart';
import 'package:evo/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MembershipDetailsScreen extends ConsumerWidget {
  const MembershipDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.read(membershipDetailsProvider).requireValue;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.membershipDetailsScreen.appbar),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
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
                    _buildMembershipText(
                      context: context,
                      membershipStatus: MembershipStatusExtensions.translated(
                        membership.membershipDetails.status,
                        context,
                      ),
                      membershipStart: formatDate(
                        context,
                        membership.membershipDetails.beganAt,
                      ),
                      membershipEnd: membership.membershipDetails.endsAt != null
                          ? formatDate(
                              context,
                              membership.membershipDetails.endsAt!,
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                TermsAndConditions(
                  terms: membership.product.postSignupPresentation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InlineSpan _buildMembershipText({
  required BuildContext context,
  required String membershipStatus,
  required String membershipStart,
  String? membershipEnd,
}) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;

  return TextSpan(
    style: TextStyle(color: theme.colorScheme.onSurface),
    children: [
      TextSpan(
        style: textTheme.bodyMedium,
        text: '${context.t.homeScreen.membershipStatus}\n',
      ),
      TextSpan(
        text: '$membershipStatus\n',
        style: textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      TextSpan(
        style: textTheme.bodyMedium,
        text:
            '${context.t.membershipDetailsScreen.membershipBeganAt} $membershipStart',
      ),
      if (membershipEnd != null) ...[
        const TextSpan(text: '\n'),
        TextSpan(
          style: textTheme.bodyMedium,
          text:
              '${context.t.membershipDetailsScreen.membershipEndsAt} $membershipEnd',
        ),
      ],
    ],
  );
}

class TermsAndConditions extends StatelessWidget {
  final String terms;

  const TermsAndConditions({
    super.key,
    required this.terms,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(title: context.t.profileScreen.termsHeader),
        const SizedBox(height: 8),
        Text(terms),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: GestureDetector(
            onTap: () => tryOpenUrlWithFeedback(kMembershipTermsUrl, context),
            child: Text(
              context.t.profileScreen.termsLink,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
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
