import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileInformationScreen extends ConsumerWidget {
  const ProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.settingsScreen.screens.profileInformation.appbar),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Header(title: 'Personlig informasjon'),
                const SizedBox(height: 8),
                PersonalInformationForm(),
                const Divider(),
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

class PersonalInformationForm extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();

  static const outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF757575)),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  );

  PersonalInformationForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          UserInfoEditField(
            text: "E-post",
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              initialValue: "bastian.tangedal@gmail.com",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.t.validation.forms.inputFields.email.empty;
                } else if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                ).hasMatch(value)) {
                  return context.t.validation.forms.inputFields.email.invalid;
                }

                return null;
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.mail_outline),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5,
                  vertical: 16.0,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
          UserInfoEditField(
            text: "Addresse",
            child: TextFormField(
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
              initialValue: "Strømsø Torg 5E",
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.home),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5,
                  vertical: 16.0,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
          UserInfoEditField(
            text: "Sted",
            child: TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              initialValue: "Drammen",
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.pin_drop),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5,
                  vertical: 16.0,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
          UserInfoEditField(
            text: "Postnummer",
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: "3044",
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.numbers),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5,
                  vertical: 16.0,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({
    super.key,
    required this.text,
    required this.child,
  });

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 3,
            child: child,
          ),
        ],
      ),
    );
  }
}
