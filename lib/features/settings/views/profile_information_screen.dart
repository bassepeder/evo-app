import 'package:email_validator/email_validator.dart';
import 'package:evo/constants.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/features/settings/profile_controller.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_form_field/phone_form_field.dart';

class ProfileInformationScreen extends ConsumerStatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  ConsumerState<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState
    extends ConsumerState<ProfileInformationScreen> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController streetAddressController;
  late final TextEditingController cityController;
  late final TextEditingController postalCodeController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final state = ref.read(profileControllerProvider);

    firstNameController = TextEditingController(text: state.firstName);
    lastNameController = TextEditingController(text: state.lastName);
    emailController = TextEditingController(text: state.email);
    streetAddressController = TextEditingController(text: state.address.street);
    cityController = TextEditingController(text: state.address.postalLocation);
    postalCodeController = TextEditingController(
      text: state.address.postalCode,
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    streetAddressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membershipDetails = ref.read(membershipDetailsProvider).requireValue;
    final isLoading =
        ref.watch(profileControllerProvider.select((state) => state.isLoading));

    ref.listen<ProfileState>(profileControllerProvider, (previous, next) {
      if (next.success == true) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(context.t.profileScreen.updateSuccessful),
              behavior: SnackBarBehavior.floating,
            ),
          );
      } else if (next.error != null && next.error != previous?.error) {
        final message = context.t.signInScreen.errorMessages.genericError;

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              behavior: SnackBarBehavior.floating,
            ),
          );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.profileScreen.appbar),
        centerTitle: true,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final canSaveDetails = ref.watch(
                profileControllerProvider.select(
                  (state) => state.hasChanged && state.isValidMobile,
                ),
              );

              return AnimatedOpacity(
                opacity: canSaveDetails ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 3),
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await ref
                                .read(profileControllerProvider.notifier)
                                .updateProfileDetails();
                          }
                        },
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
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                  emailController: emailController,
                  streetAddressController: streetAddressController,
                  cityController: cityController,
                  postalCodeController: postalCodeController,
                  isLoading: isLoading,
                  formKey: formKey,
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
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController streetAddressController;
  final TextEditingController cityController;
  final TextEditingController postalCodeController;
  final bool isLoading;
  final GlobalKey<FormState> formKey;

  static const outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF757575)),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  );

  const PersonalInformationForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.streetAddressController,
    required this.cityController,
    required this.postalCodeController,
    required this.isLoading,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          UserInfoEditField(
            label: context.t.forms.fields.firstname.label,
            child: TextFormField(
              controller: firstNameController,
              onChanged: (value) => ref
                  .read(profileControllerProvider.notifier)
                  .updateFirstName(value),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              readOnly: isLoading,
              style: const TextStyle(fontSize: 14),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.t.forms.fields.firstname.validation.empty;
                }

                return null;
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.account_box),
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
            label: context.t.forms.fields.lastName.label,
            child: TextFormField(
              controller: lastNameController,
              onChanged: (value) => ref
                  .read(profileControllerProvider.notifier)
                  .updateLastName(value),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              readOnly: isLoading,
              style: const TextStyle(fontSize: 14),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.t.forms.fields.lastName.validation.empty;
                }

                return null;
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.account_box),
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
                  return context.t.forms.fields.email.validation.emptyShort;
                } else if (!EmailValidator.validate(value)) {
                  return context.t.forms.fields.email.validation.invalidShort;
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
            label: context.t.forms.fields.mobile.label,
            child: PhoneInputField(
              initialValue: ref.read(profileControllerProvider).mobile.number,
              onPhoneNumberChanged: (number, isValid) => ref
                  .read(profileControllerProvider.notifier)
                  .updateMobile(number, isValid),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.t.forms.fields.streetAddress.validation.empty;
                }

                return null;
              },
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.t.forms.fields.addressCity.validation.empty;
                }

                return null;
              },
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.t.forms.fields.postalCode.validation.empty;
                }

                return null;
              },
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: GestureDetector(
            onTap: () => tryOpenUrlWithFeedback(kMembershipTermsUrl, context),
            child: Text(
              context.t.profileScreen.termsLink,
              style: TextStyle(
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

class PhoneInputField extends StatefulWidget {
  final void Function(String, bool) onPhoneNumberChanged;
  final String? initialValue;

  const PhoneInputField({
    super.key,
    required this.onPhoneNumberChanged,
    this.initialValue,
  });

  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInputField> {
  late PhoneController controller;
  late PhoneNumber initialValue;

  @override
  void initState() {
    super.initState();
    initialValue = PhoneNumber.parse(
      (widget.initialValue?.isNotEmpty ?? false) && widget.initialValue != ''
          ? widget.initialValue!
          : '+47',
    );
    controller = PhoneController(initialValue: initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      onChanged: (value) => widget.onPhoneNumberChanged(
        value.international,
        value.isValid(type: PhoneNumberType.mobile),
      ),
      controller: controller,
      validator: PhoneValidator.compose([
        PhoneValidator.required(
          context,
          errorText: context.t.forms.fields.mobile.validation.empty,
        ),
        PhoneValidator.validMobile(
          context,
          errorText: context.t.forms.fields.mobile.validation.invalid,
        ),
      ]),
      decoration: InputDecoration(
        filled: true,
        fillColor:
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0 * 1.5,
          vertical: 16.0,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
      enabled: true,
      /*
      countrySelectorNavigator: const CountrySelectorNavigator.page(
        favorites: [IsoCode.NO],
      ),
       */
      isCountryButtonPersistent: true,
      isCountrySelectionEnabled: false,
      countryButtonStyle: const CountryButtonStyle(
        showDialCode: true,
        showFlag: true,
        showDropdownIcon: false,
        flagSize: 16,
      ),
    );
  }
}
