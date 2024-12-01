import 'package:evo/features/membership/models/membership_details.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class MembershipStatusBanner extends StatelessWidget {
  final MembershipDetails details;

  const MembershipStatusBanner({
    super.key,
    required this.details,
  });

  static const defaultColor = Color(0xFF4A3298);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color:
            MembershipStatusExtensions.color(details.membershipDetails.status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(color: Colors.white),
          children: [
            TextSpan(text: '${context.t.homeScreen.membershipStatus}\n'),
            TextSpan(
              text: MembershipStatusExtensions.translated(
                details.membershipDetails.status,
                context,
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
