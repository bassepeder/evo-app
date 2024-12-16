import 'package:email_validator/email_validator.dart';
import 'package:evo/common/exceptions/http_exceptions.dart';
import 'package:evo/common/widgets/evo_elevated_button.dart';
import 'package:evo/constants.dart';
import 'package:evo/features/auth/models/auth_state.dart';
import 'package:evo/features/auth/viewmodels/auth_view_model.dart';
import 'package:evo/features/home/views/home_screen.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/navigation.dart';
import 'package:evo/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authViewModelProvider);
    emailController = TextEditingController(text: authState.email);
    passwordController = TextEditingController(text: authState.password);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(authViewModelProvider.select((state) => state.loading));

    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.success == true) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        pushAndRemoveUntilPlatformRoute(
          context,
          builder: (_) => const HomeScreen(),
        );
      } else if (next.error != null && next.error != previous?.error) {
        final message = next.error is InvalidCredentialsException
            ? context.t.signInScreen.errorMessages.invalidCredentials
            : context.t.signInScreen.errorMessages.genericError;

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              behavior: SnackBarBehavior.floating,
            ),
          );

        if (next.error is InvalidCredentialsException) {
          passwordController.clear();
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.signInScreen.title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                context.t.signInScreen.header,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                context.t.signInScreen.subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: const Color(0xFF757575),
                    ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 80),
                      SignInForm(
                        emailController: emailController,
                        passwordController: passwordController,
                        onLoginClick: () {
                          ref
                              .read(authViewModelProvider.notifier)
                              .setEmail(emailController.text);
                          ref
                              .read(authViewModelProvider.notifier)
                              .setPassword(passwordController.text);
                          ref.read(authViewModelProvider.notifier).signIn();
                        },
                        isLoading: isLoading,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          BecomeMemberTextButton(
                            onClick: () async {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              await tryOpenUrlWithFeedback(
                                kBuyMembershipUrl,
                                context,
                              );
                            },
                            label: context.t.signInScreen.buttons.becomeMember,
                          ),
                          ForgotPasswordTextButton(
                            onClick: () {},
                            label:
                                context.t.signInScreen.buttons.forgotPassword,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLoginClick;
  final bool isLoading;

  final formKey = GlobalKey<FormState>();

  static const authOutlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF757575)),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  );

  SignInForm({
    super.key,
    required this.onLoginClick,
    required this.isLoading,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            autocorrect: false,
            readOnly: isLoading,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.t.forms.fields.email.validation.emptyFull;
              } else if (!EmailValidator.validate(value)) {
                return context.t.forms.fields.email.validation.invalidFull;
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: context.t.forms.fields.email.hint,
              labelText: context.t.forms.fields.email.label,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: const TextStyle(color: Color(0xFF757575)),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              suffix: const Icon(Icons.mail_outline),
              border: authOutlineInputBorder,
              enabledBorder: authOutlineInputBorder,
              focusedBorder: authOutlineInputBorder.copyWith(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              readOnly: isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.t.forms.fields.password.validation.empty;
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: context.t.forms.fields.password.hint,
                labelText: context.t.forms.fields.password.label,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: const TextStyle(color: Color(0xFF757575)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                suffix: const Icon(Icons.lock_outline),
                border: authOutlineInputBorder,
                enabledBorder: authOutlineInputBorder,
                focusedBorder: authOutlineInputBorder.copyWith(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          EvoElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onLoginClick();
              }
            },
            text: t.signInScreen.buttons.signIn,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordTextButton extends StatelessWidget {
  final VoidCallback onClick;
  final String label;

  const ForgotPasswordTextButton({
    super.key,
    required this.onClick,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withValues(alpha: 0.64),
            ),
      ),
    );
  }
}

class BecomeMemberTextButton extends StatelessWidget {
  final VoidCallback onClick;
  final String label;

  const BecomeMemberTextButton({
    super.key,
    required this.onClick,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
            ),
      ),
    );
  }
}
