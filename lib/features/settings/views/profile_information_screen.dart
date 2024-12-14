import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/features/settings/profile_controller.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileInformationScreen extends ConsumerStatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  ConsumerState<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState
    extends ConsumerState<ProfileInformationScreen> {
  late final TextEditingController emailController;
  late final TextEditingController streetAddressController;
  late final TextEditingController cityController;
  late final TextEditingController postalCodeController;

  @override
  void initState() {
    super.initState();

    final state = ref.read(profileControllerProvider);

    emailController = TextEditingController(text: state.email);
    streetAddressController = TextEditingController(text: state.address.street);
    cityController = TextEditingController(text: state.address.postalLocation);
    postalCodeController = TextEditingController(
      text: state.address.postalCode,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    streetAddressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membershipDetails = ref.read(membershipDetailsProvider).requireValue!;
    final isLoading =
        ref.watch(profileControllerProvider.select((state) => state.isLoading));

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.profileScreen.appbar),
        centerTitle: true,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final hasChanged = ref.watch(
                profileControllerProvider.select((state) => state.hasChanged),
              );

              return AnimatedOpacity(
                opacity: hasChanged ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.save_as_outlined),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Header(
                  title: context.t.profileScreen.personalInformationHeader,
                ),
                const SizedBox(height: 8),
                PersonalInformationForm(
                  emailController: emailController,
                  streetAddressController: streetAddressController,
                  cityController: cityController,
                  postalCodeController: postalCodeController,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 32),
                TermsAndConditions(
                  terms: membershipDetails.product.postSignupPresentation,
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

class PersonalInformationForm extends ConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController streetAddressController;
  final TextEditingController cityController;
  final TextEditingController postalCodeController;
  final bool isLoading;

  final formKey = GlobalKey<FormState>();

  static const outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF757575)),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  );

  PersonalInformationForm({
    super.key,
    required this.emailController,
    required this.streetAddressController,
    required this.cityController,
    required this.postalCodeController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          UserInfoEditField(
            label: context.t.forms.fields.email.label,
            child: TextFormField(
              controller: emailController,
              onChanged: (value) => ref
                  .read(profileControllerProvider.notifier)
                  .updateEmail(value),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              readOnly: isLoading,
              style: const TextStyle(fontSize: 14),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.t.forms.fields.email.validation.empty;
                } else if (!value.isValidEmail()) {
                  return context.t.forms.fields.email.validation.invalid;
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
            label: context.t.forms.fields.streetAddress.label,
            child: TextFormField(
              controller: streetAddressController,
              onChanged: (value) => ref
                  .read(profileControllerProvider.notifier)
                  .updateStreetAddress(value),
              keyboardType: TextInputType.streetAddress,
              readOnly: isLoading,
              textInputAction: TextInputAction.done,
              style: const TextStyle(fontSize: 14),
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
            label: context.t.forms.fields.addressCity.label,
            child: TextFormField(
              controller: cityController,
              onChanged: (value) => ref
                  .read(profileControllerProvider.notifier)
                  .updateCity(value),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              readOnly: isLoading,
              style: const TextStyle(fontSize: 14),
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
            label: context.t.forms.fields.postalCode.label,
            child: TextFormField(
              controller: postalCodeController,
              onChanged: (value) => ref
                  .read(profileControllerProvider.notifier)
                  .updatePostalCode(value),
              keyboardType: TextInputType.number,
              readOnly: isLoading,
              style: const TextStyle(fontSize: 14),
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
      ],
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  final String label;
  final Widget child;

  const UserInfoEditField({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
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
