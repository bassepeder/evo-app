import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MembershipActionCard extends StatelessWidget {
  final double width;
  final MembershipAction action;
  final VoidCallback onPress;

  const MembershipActionCard({
    super.key,
    this.width = 140,
    required this.action,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF979797).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SvgPicture.string(action.svgIcon),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              action.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  action.description ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MembershipAction {
  final String title;
  final String? description;
  final String svgIcon;

  MembershipAction({
    required this.title,
    this.description,
    required this.svgIcon,
  });
}
