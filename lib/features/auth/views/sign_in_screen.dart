import 'package:evo/common/widgets/evo_elevated_button.dart';
import 'package:evo/features/auth/models/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../i18n/translations.g.dart';
import '../providers/auth_view_model_provider.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final isLoading =
        ref.watch(authViewModelProvider.select((it) => it.loading));

    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.success == true) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('You are signed in'),
              behavior: SnackBarBehavior.floating,
            ),
          );
      } else if (next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
              behavior: SnackBarBehavior.floating,
            ),
          );
      }
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(t.signInScreen.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                t.signInScreen.header,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                t.signInScreen.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF757575)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenHeight * 0.1),
                      SignInForm(
                        onLoginClick: () async => await ref
                            .read(authViewModelProvider.notifier)
                            .signIn(),
                        onEmailChanged: (email) => ref
                            .read(authViewModelProvider.notifier)
                            .setEmail(email),
                        onPasswordChanged: (password) => ref
                            .read(authViewModelProvider.notifier)
                            .setPassword(password),
                        isLoading: isLoading,
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      ForgotPasswordTextButton(
                        onClick: () {},
                        label: t.signInScreen.forgotPassword,
                      ),
                      /*
                      //SizedBox(height: screenHeight * 0.075),
                      SizedBox(height: screenHeight * 0.3),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                       */
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

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);

class SignInForm extends StatelessWidget {
  final VoidCallback onLoginClick;
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;
  final bool isLoading;

  final formKey = GlobalKey<FormState>();

  SignInForm({
    super.key,
    required this.onLoginClick,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            onChanged: (email) => onEmailChanged(email),
            autocorrect: false,
            readOnly: isLoading,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return t.validation.forms.inputFields.email.empty;
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return t.validation.forms.inputFields.email.invalid;
              }

              return null;
            },
            decoration: InputDecoration(
                hintText: t.signInScreen.form.email.hint,
                labelText: t.signInScreen.form.email.label,
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
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: TextFormField(
              onChanged: (password) => onPasswordChanged(password),
              obscureText: true,
              readOnly: isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return t.validation.forms.inputFields.password.empty;
                }

                return null;
              },
              decoration: InputDecoration(
                  hintText: t.signInScreen.form.password.hint,
                  labelText: t.signInScreen.form.password.label,
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
                        color: Theme.of(context).colorScheme.primary),
                  )),
            ),
          ),
          const SizedBox(height: 8),
          EvoElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onLoginClick();
              }
            },
            text: t.signInScreen.signInButton,
            isLoading: isLoading,
          )
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
                  .withOpacity(0.64),
            ),
      ),
    );
  }
}
