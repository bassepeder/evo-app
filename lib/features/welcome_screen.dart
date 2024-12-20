import 'package:evo/common/widgets/evo_elevated_button.dart';
import 'package:evo/features/auth/views/sign_in_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/navigation.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/images/showcase.jpg',
            width: size.width,
            height: size.height * 0.7,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${context.t.welcomeScreen.welcomeHeader} ',
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Image.asset(
                'assets/images/logo.png',
                width: 70,
                height: 70,
              ),
            ],
          ),
          Text(
            context.t.welcomeScreen.subtitle,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge!.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.64),
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: EvoElevatedButton(
              onPressed: () => pushPlatformRoute(
                context,
                builder: (_) => const SignInScreen(),
              ),
              text: context.t.welcomeScreen.signInButton.toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}
