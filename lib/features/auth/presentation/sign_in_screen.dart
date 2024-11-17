import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Logg inn"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                "Velkommen tilbake!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Logg inn med e-posten og passordet ditt.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF757575)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SignInForm(
                        onLoginClick: () {},
                        onEmailChanged: (email) {},
                        onPasswordChanged: (password) {},
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      ForgotPasswordTextButton(onClick: () {}),
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

  const SignInForm({
    super.key,
    required this.onLoginClick,
    required this.onEmailChanged,
    required this.onPasswordChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            onChanged: (email) => onEmailChanged(email),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: "Skriv inn e-postadressen din",
                labelText: "E-post",
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
              decoration: InputDecoration(
                  hintText: "Skriv inn passordet ditt",
                  labelText: "Passord",
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
          ElevatedButton(
            onPressed: () => onLoginClick,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            child: const Text("Logg inn"),
          )
        ],
      ),
    );
  }
}

class ForgotPasswordTextButton extends StatelessWidget {
  final VoidCallback onClick;

  const ForgotPasswordTextButton({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onClick,
      child: Text(
        'Glemt passord?',
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
