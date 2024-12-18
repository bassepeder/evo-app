///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEn extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsCurrentReferralScreenEn currentReferralScreen = _TranslationsCurrentReferralScreenEn._(_root);
	@override late final _TranslationsErrorsEn errors = _TranslationsErrorsEn._(_root);
	@override late final _TranslationsFormatEn format = _TranslationsFormatEn._(_root);
	@override late final _TranslationsFormsEn forms = _TranslationsFormsEn._(_root);
	@override late final _TranslationsHomeScreenEn homeScreen = _TranslationsHomeScreenEn._(_root);
	@override late final _TranslationsKeyStatusesEn keyStatuses = _TranslationsKeyStatusesEn._(_root);
	@override late final _TranslationsKeyTypesEn keyTypes = _TranslationsKeyTypesEn._(_root);
	@override late final _TranslationsMembershipStatusesEn membershipStatuses = _TranslationsMembershipStatusesEn._(_root);
	@override late final _TranslationsPaymentScreenEn paymentScreen = _TranslationsPaymentScreenEn._(_root);
	@override late final _TranslationsPrimaryLocationScreenEn primaryLocationScreen = _TranslationsPrimaryLocationScreenEn._(_root);
	@override late final _TranslationsProfileScreenEn profileScreen = _TranslationsProfileScreenEn._(_root);
	@override late final _TranslationsSettingsScreenEn settingsScreen = _TranslationsSettingsScreenEn._(_root);
	@override late final _TranslationsSignInScreenEn signInScreen = _TranslationsSignInScreenEn._(_root);
	@override late final _TranslationsWelcomeScreenEn welcomeScreen = _TranslationsWelcomeScreenEn._(_root);
	@override late final _TranslationsWorkoutsScreenEn workoutsScreen = _TranslationsWorkoutsScreenEn._(_root);
}

// Path: currentReferralScreen
class _TranslationsCurrentReferralScreenEn extends TranslationsCurrentReferralScreenNo {
	_TranslationsCurrentReferralScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get appbar => 'Referral Campaign';
	@override String get header => 'Your referral code';
}

// Path: errors
class _TranslationsErrorsEn extends TranslationsErrorsNo {
	_TranslationsErrorsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get generalTitle => 'Oops! Something went wrong';
	@override String get generalDescription => 'Something broke, but we\'re fixing it. Try again in a moment.';
	@override String get generalRetryButtonText => 'Retry';
	@override String get failedToLoadMembershipError => 'Failed to retrieve information about your membership.';
	@override String get failedToLoadLocationData => 'Failed to load location data.';
	@override String get failedToLoadLocations => 'Failed to fetch all EVO locations.';
	@override String get failedToLoadWorkoutStatistics => 'Failed to load your workouts.';
	@override String get failedToLoadInvoices => 'Failed to fetch your invoices.';
	@override String get failedToOpenUrl => 'Failed to open URL.';
	@override String get failedToLoadCurrentMembershipReferral => 'Failed to load membership referral info.';
}

// Path: format
class _TranslationsFormatEn extends TranslationsFormatNo {
	_TranslationsFormatEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get yesterday => 'yesterday';
	@override String get today => 'today';
	@override String get tomorrow => 'tomorrow';
}

// Path: forms
class _TranslationsFormsEn extends TranslationsFormsNo {
	_TranslationsFormsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancel';
	@override String get ok => 'OK';
	@override late final _TranslationsFormsFieldsEn fields = _TranslationsFormsFieldsEn._(_root);
}

// Path: homeScreen
class _TranslationsHomeScreenEn extends TranslationsHomeScreenNo {
	_TranslationsHomeScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get membershipStatus => 'Your membership is';
	@override String get explore => 'Explore membership';
	@override String get currentLocationStatisticsTitle => 'Number of people now at';
	@override TextSpan presentOrFutureLocationTimelineTitle({required InlineSpan formattedDate}) => TextSpan(children: [
		const TextSpan(text: 'Expected visits '),
		formattedDate,
	]);
	@override TextSpan oldLocationTimelineTitle({required InlineSpan formattedDate}) => TextSpan(children: [
		const TextSpan(text: 'Used capacity '),
		formattedDate,
	]);
	@override List<String> get shortcuts => [
		'Your keys',
		'Workouts',
	];
	@override String get chooseLocation => 'Choose EVO location';
	@override String get primaryMembershipLocation => 'Your primary location';
}

// Path: keyStatuses
class _TranslationsKeyStatusesEn extends TranslationsKeyStatusesNo {
	_TranslationsKeyStatusesEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get active => 'Active';
	@override String get inactive => 'Inactive';
}

// Path: keyTypes
class _TranslationsKeyTypesEn extends TranslationsKeyTypesNo {
	_TranslationsKeyTypesEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get rfid => 'Access Tag';
	@override String get pinCode => 'PIN code';
	@override String get unknown => 'Unknown key type';
}

// Path: membershipStatuses
class _TranslationsMembershipStatusesEn extends TranslationsMembershipStatusesNo {
	_TranslationsMembershipStatusesEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get presale => 'Pre-sale';
	@override String get inTrial => 'In trial';
	@override String get active => 'Active';
	@override String get freezed => 'Freezed';
	@override String get pendingCancellation => 'Pending cancellation';
	@override String get cancelled => 'Cancelled';
	@override String get cancelledInPresale => 'Cancelled in pre-sale';
	@override String get cancelledInTrial => 'Cancelled in trial';
	@override String get stopped => 'Stopped';
	@override String get unknown => 'Unknown';
}

// Path: paymentScreen
class _TranslationsPaymentScreenEn extends TranslationsPaymentScreenNo {
	_TranslationsPaymentScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get appbar => 'Payment';
	@override String get paymentCardHeader => 'Payment card';
	@override String get previousPaymentsHeader => 'Previous payments';
	@override late final _TranslationsPaymentScreenTableHeadersEn tableHeaders = _TranslationsPaymentScreenTableHeadersEn._(_root);
}

// Path: primaryLocationScreen
class _TranslationsPrimaryLocationScreenEn extends TranslationsPrimaryLocationScreenNo {
	_TranslationsPrimaryLocationScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get appbar => 'Primary Location';
	@override String get header => 'Your primary location';
	@override String updateSuccessful({required Object name}) => '${name} now set as your primary location.';
}

// Path: profileScreen
class _TranslationsProfileScreenEn extends TranslationsProfileScreenNo {
	_TranslationsProfileScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get appbar => 'Profile Information';
	@override String get personalInformationHeader => 'Personal information';
	@override String get termsHeader => 'Membership terms';
	@override String get updateSuccessful => 'Personal information updated.';
}

// Path: settingsScreen
class _TranslationsSettingsScreenEn extends TranslationsSettingsScreenNo {
	_TranslationsSettingsScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get appBar => 'Settings';
	@override late final _TranslationsSettingsScreenAccountMenuItemsEn accountMenuItems = _TranslationsSettingsScreenAccountMenuItemsEn._(_root);
	@override late final _TranslationsSettingsScreenAppMenuItemsEn appMenuItems = _TranslationsSettingsScreenAppMenuItemsEn._(_root);
}

// Path: signInScreen
class _TranslationsSignInScreenEn extends TranslationsSignInScreenNo {
	_TranslationsSignInScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sign in';
	@override String get header => 'Welcome back!';
	@override String get subtitle => 'Sign in with your e-mail and password.';
	@override late final _TranslationsSignInScreenButtonsEn buttons = _TranslationsSignInScreenButtonsEn._(_root);
	@override late final _TranslationsSignInScreenErrorMessagesEn errorMessages = _TranslationsSignInScreenErrorMessagesEn._(_root);
}

// Path: welcomeScreen
class _TranslationsWelcomeScreenEn extends TranslationsWelcomeScreenNo {
	_TranslationsWelcomeScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get welcomeHeader => 'Welcome to';
	@override String get subtitle => 'The strength you need';
	@override String get signInButton => 'Sign in';
}

// Path: workoutsScreen
class _TranslationsWorkoutsScreenEn extends TranslationsWorkoutsScreenNo {
	_TranslationsWorkoutsScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get appBar => 'Workouts';
	@override TextSpan title({required InlineSpan totalWorkoutsCount}) => TextSpan(children: [
		totalWorkoutsCount,
		const TextSpan(text: ' workouts'),
	]);
	@override String get subtitle => 'You have performed a total of';
	@override TextSpan monthStatisticBar({required InlineSpan workoutsCount}) => TextSpan(children: [
		workoutsCount,
		const TextSpan(text: ' workouts'),
	]);
	@override List<String> get encouragements => [
		'you\'re awesome!',
		'great job!',
		'pure power!',
		'wow!',
		'way to go!',
	];
	@override List<String> get months => [
		'January',
		'February',
		'March',
		'April',
		'May',
		'June',
		'July',
		'August',
		'September',
		'October',
		'November',
		'December',
	];
}

// Path: forms.fields
class _TranslationsFormsFieldsEn extends TranslationsFormsFieldsNo {
	_TranslationsFormsFieldsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsFormsFieldsFirstnameEn firstname = _TranslationsFormsFieldsFirstnameEn._(_root);
	@override late final _TranslationsFormsFieldsLastNameEn lastName = _TranslationsFormsFieldsLastNameEn._(_root);
	@override late final _TranslationsFormsFieldsMobileEn mobile = _TranslationsFormsFieldsMobileEn._(_root);
	@override late final _TranslationsFormsFieldsEmailEn email = _TranslationsFormsFieldsEmailEn._(_root);
	@override late final _TranslationsFormsFieldsPasswordEn password = _TranslationsFormsFieldsPasswordEn._(_root);
	@override late final _TranslationsFormsFieldsStreetAddressEn streetAddress = _TranslationsFormsFieldsStreetAddressEn._(_root);
	@override late final _TranslationsFormsFieldsAddressCityEn addressCity = _TranslationsFormsFieldsAddressCityEn._(_root);
	@override late final _TranslationsFormsFieldsPostalCodeEn postalCode = _TranslationsFormsFieldsPostalCodeEn._(_root);
}

// Path: paymentScreen.tableHeaders
class _TranslationsPaymentScreenTableHeadersEn extends TranslationsPaymentScreenTableHeadersNo {
	_TranslationsPaymentScreenTableHeadersEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPaymentScreenTableHeadersDateEn date = _TranslationsPaymentScreenTableHeadersDateEn._(_root);
	@override late final _TranslationsPaymentScreenTableHeadersAmountEn amount = _TranslationsPaymentScreenTableHeadersAmountEn._(_root);
	@override late final _TranslationsPaymentScreenTableHeadersPeriodEn period = _TranslationsPaymentScreenTableHeadersPeriodEn._(_root);
	@override late final _TranslationsPaymentScreenTableHeadersPdfEn pdf = _TranslationsPaymentScreenTableHeadersPdfEn._(_root);
}

// Path: settingsScreen.accountMenuItems
class _TranslationsSettingsScreenAccountMenuItemsEn extends TranslationsSettingsScreenAccountMenuItemsNo {
	_TranslationsSettingsScreenAccountMenuItemsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get header => 'Account Settings';
	@override late final _TranslationsSettingsScreenAccountMenuItemsProfileInformationEn profileInformation = _TranslationsSettingsScreenAccountMenuItemsProfileInformationEn._(_root);
	@override late final _TranslationsSettingsScreenAccountMenuItemsPaymentEn payment = _TranslationsSettingsScreenAccountMenuItemsPaymentEn._(_root);
	@override late final _TranslationsSettingsScreenAccountMenuItemsLocationsEn locations = _TranslationsSettingsScreenAccountMenuItemsLocationsEn._(_root);
	@override late final _TranslationsSettingsScreenAccountMenuItemsReferralEn referral = _TranslationsSettingsScreenAccountMenuItemsReferralEn._(_root);
	@override late final _TranslationsSettingsScreenAccountMenuItemsSignOutEn signOut = _TranslationsSettingsScreenAccountMenuItemsSignOutEn._(_root);
}

// Path: settingsScreen.appMenuItems
class _TranslationsSettingsScreenAppMenuItemsEn extends TranslationsSettingsScreenAppMenuItemsNo {
	_TranslationsSettingsScreenAppMenuItemsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get header => 'App Settings';
	@override late final _TranslationsSettingsScreenAppMenuItemsAppThemeEn appTheme = _TranslationsSettingsScreenAppMenuItemsAppThemeEn._(_root);
	@override late final _TranslationsSettingsScreenAppMenuItemsSystemColorsEn systemColors = _TranslationsSettingsScreenAppMenuItemsSystemColorsEn._(_root);
	@override late final _TranslationsSettingsScreenAppMenuItemsLocaleEn locale = _TranslationsSettingsScreenAppMenuItemsLocaleEn._(_root);
}

// Path: signInScreen.buttons
class _TranslationsSignInScreenButtonsEn extends TranslationsSignInScreenButtonsNo {
	_TranslationsSignInScreenButtonsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get signIn => 'Sign in';
	@override String get forgotPassword => 'Forgot password?';
	@override String get becomeMember => 'Become member';
}

// Path: signInScreen.errorMessages
class _TranslationsSignInScreenErrorMessagesEn extends TranslationsSignInScreenErrorMessagesNo {
	_TranslationsSignInScreenErrorMessagesEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get invalidCredentials => 'Username or password is incorrect.';
	@override String get genericError => 'An error occured. Please try again.';
}

// Path: forms.fields.firstname
class _TranslationsFormsFieldsFirstnameEn extends TranslationsFormsFieldsFirstnameNo {
	_TranslationsFormsFieldsFirstnameEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'First name';
	@override String get hint => 'Type your first name';
	@override late final _TranslationsFormsFieldsFirstnameValidationEn validation = _TranslationsFormsFieldsFirstnameValidationEn._(_root);
}

// Path: forms.fields.lastName
class _TranslationsFormsFieldsLastNameEn extends TranslationsFormsFieldsLastNameNo {
	_TranslationsFormsFieldsLastNameEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Last name';
	@override String get hint => 'Type your last name';
	@override late final _TranslationsFormsFieldsLastNameValidationEn validation = _TranslationsFormsFieldsLastNameValidationEn._(_root);
}

// Path: forms.fields.mobile
class _TranslationsFormsFieldsMobileEn extends TranslationsFormsFieldsMobileNo {
	_TranslationsFormsFieldsMobileEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Mobile';
	@override String get hint => 'Input your mobile';
	@override late final _TranslationsFormsFieldsMobileValidationEn validation = _TranslationsFormsFieldsMobileValidationEn._(_root);
}

// Path: forms.fields.email
class _TranslationsFormsFieldsEmailEn extends TranslationsFormsFieldsEmailNo {
	_TranslationsFormsFieldsEmailEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Email';
	@override String get hint => 'Type your e-mail';
	@override late final _TranslationsFormsFieldsEmailValidationEn validation = _TranslationsFormsFieldsEmailValidationEn._(_root);
}

// Path: forms.fields.password
class _TranslationsFormsFieldsPasswordEn extends TranslationsFormsFieldsPasswordNo {
	_TranslationsFormsFieldsPasswordEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Password';
	@override String get hint => 'Type your password';
	@override late final _TranslationsFormsFieldsPasswordValidationEn validation = _TranslationsFormsFieldsPasswordValidationEn._(_root);
}

// Path: forms.fields.streetAddress
class _TranslationsFormsFieldsStreetAddressEn extends TranslationsFormsFieldsStreetAddressNo {
	_TranslationsFormsFieldsStreetAddressEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Address';
	@override late final _TranslationsFormsFieldsStreetAddressValidationEn validation = _TranslationsFormsFieldsStreetAddressValidationEn._(_root);
}

// Path: forms.fields.addressCity
class _TranslationsFormsFieldsAddressCityEn extends TranslationsFormsFieldsAddressCityNo {
	_TranslationsFormsFieldsAddressCityEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Place';
	@override late final _TranslationsFormsFieldsAddressCityValidationEn validation = _TranslationsFormsFieldsAddressCityValidationEn._(_root);
}

// Path: forms.fields.postalCode
class _TranslationsFormsFieldsPostalCodeEn extends TranslationsFormsFieldsPostalCodeNo {
	_TranslationsFormsFieldsPostalCodeEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Postal code';
	@override late final _TranslationsFormsFieldsPostalCodeValidationEn validation = _TranslationsFormsFieldsPostalCodeValidationEn._(_root);
}

// Path: paymentScreen.tableHeaders.date
class _TranslationsPaymentScreenTableHeadersDateEn extends TranslationsPaymentScreenTableHeadersDateNo {
	_TranslationsPaymentScreenTableHeadersDateEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Date';
}

// Path: paymentScreen.tableHeaders.amount
class _TranslationsPaymentScreenTableHeadersAmountEn extends TranslationsPaymentScreenTableHeadersAmountNo {
	_TranslationsPaymentScreenTableHeadersAmountEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Amount';
}

// Path: paymentScreen.tableHeaders.period
class _TranslationsPaymentScreenTableHeadersPeriodEn extends TranslationsPaymentScreenTableHeadersPeriodNo {
	_TranslationsPaymentScreenTableHeadersPeriodEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Period';
}

// Path: paymentScreen.tableHeaders.pdf
class _TranslationsPaymentScreenTableHeadersPdfEn extends TranslationsPaymentScreenTableHeadersPdfNo {
	_TranslationsPaymentScreenTableHeadersPdfEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'PDF';
}

// Path: settingsScreen.accountMenuItems.profileInformation
class _TranslationsSettingsScreenAccountMenuItemsProfileInformationEn extends TranslationsSettingsScreenAccountMenuItemsProfileInformationNo {
	_TranslationsSettingsScreenAccountMenuItemsProfileInformationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Account Information';
	@override String get subtitle => 'Change your account information';
}

// Path: settingsScreen.accountMenuItems.payment
class _TranslationsSettingsScreenAccountMenuItemsPaymentEn extends TranslationsSettingsScreenAccountMenuItemsPaymentNo {
	_TranslationsSettingsScreenAccountMenuItemsPaymentEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Payment';
	@override String get subtitle => 'Check your payment card';
}

// Path: settingsScreen.accountMenuItems.locations
class _TranslationsSettingsScreenAccountMenuItemsLocationsEn extends TranslationsSettingsScreenAccountMenuItemsLocationsNo {
	_TranslationsSettingsScreenAccountMenuItemsLocationsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your primary location';
	@override String get subtitle => 'Change your primary location';
}

// Path: settingsScreen.accountMenuItems.referral
class _TranslationsSettingsScreenAccountMenuItemsReferralEn extends TranslationsSettingsScreenAccountMenuItemsReferralNo {
	_TranslationsSettingsScreenAccountMenuItemsReferralEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Referral Campaign';
	@override String get subtitle => 'Get exclusive promotions';
}

// Path: settingsScreen.accountMenuItems.signOut
class _TranslationsSettingsScreenAccountMenuItemsSignOutEn extends TranslationsSettingsScreenAccountMenuItemsSignOutNo {
	_TranslationsSettingsScreenAccountMenuItemsSignOutEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sign Out';
	@override String get subtitle => 'Hope to see you again';
}

// Path: settingsScreen.appMenuItems.appTheme
class _TranslationsSettingsScreenAppMenuItemsAppThemeEn extends TranslationsSettingsScreenAppMenuItemsAppThemeNo {
	_TranslationsSettingsScreenAppMenuItemsAppThemeEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Theme';
	@override String get subtitle => 'Change the look of the app';
	@override late final _TranslationsSettingsScreenAppMenuItemsAppThemeOptionsEn options = _TranslationsSettingsScreenAppMenuItemsAppThemeOptionsEn._(_root);
}

// Path: settingsScreen.appMenuItems.systemColors
class _TranslationsSettingsScreenAppMenuItemsSystemColorsEn extends TranslationsSettingsScreenAppMenuItemsSystemColorsNo {
	_TranslationsSettingsScreenAppMenuItemsSystemColorsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Use system colors';
	@override String get subtitle => 'Make use of the system color palette';
}

// Path: settingsScreen.appMenuItems.locale
class _TranslationsSettingsScreenAppMenuItemsLocaleEn extends TranslationsSettingsScreenAppMenuItemsLocaleNo {
	_TranslationsSettingsScreenAppMenuItemsLocaleEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Language';
	@override String get subtitle => 'Select preferred language';
	@override Map<String, String> get optionsMap => {
		'en': 'English',
		'no': 'Norwegian',
	};
}

// Path: forms.fields.firstname.validation
class _TranslationsFormsFieldsFirstnameValidationEn extends TranslationsFormsFieldsFirstnameValidationNo {
	_TranslationsFormsFieldsFirstnameValidationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter a name';
}

// Path: forms.fields.lastName.validation
class _TranslationsFormsFieldsLastNameValidationEn extends TranslationsFormsFieldsLastNameValidationNo {
	_TranslationsFormsFieldsLastNameValidationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter a last name';
}

// Path: forms.fields.mobile.validation
class _TranslationsFormsFieldsMobileValidationEn extends TranslationsFormsFieldsMobileValidationNo {
	_TranslationsFormsFieldsMobileValidationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Mobile is required';
	@override String get invalid => 'Mobile is not valid';
}

// Path: forms.fields.email.validation
class _TranslationsFormsFieldsEmailValidationEn extends TranslationsFormsFieldsEmailValidationNo {
	_TranslationsFormsFieldsEmailValidationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get emptyFull => 'Please enter your e-mail';
	@override String get invalidFull => 'Please enter a valid e-mail';
	@override String get emptyShort => 'E-mail is required';
	@override String get invalidShort => 'Invalid e-mail';
}

// Path: forms.fields.password.validation
class _TranslationsFormsFieldsPasswordValidationEn extends TranslationsFormsFieldsPasswordValidationNo {
	_TranslationsFormsFieldsPasswordValidationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter password';
}

// Path: forms.fields.streetAddress.validation
class _TranslationsFormsFieldsStreetAddressValidationEn extends TranslationsFormsFieldsStreetAddressValidationNo {
	_TranslationsFormsFieldsStreetAddressValidationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'This is required';
}

// Path: forms.fields.addressCity.validation
class _TranslationsFormsFieldsAddressCityValidationEn extends TranslationsFormsFieldsAddressCityValidationNo {
	_TranslationsFormsFieldsAddressCityValidationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'This is required';
}

// Path: forms.fields.postalCode.validation
class _TranslationsFormsFieldsPostalCodeValidationEn extends TranslationsFormsFieldsPostalCodeValidationNo {
	_TranslationsFormsFieldsPostalCodeValidationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'This is required';
}

// Path: settingsScreen.appMenuItems.appTheme.options
class _TranslationsSettingsScreenAppMenuItemsAppThemeOptionsEn extends TranslationsSettingsScreenAppMenuItemsAppThemeOptionsNo {
	_TranslationsSettingsScreenAppMenuItemsAppThemeOptionsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get deviceTheme => 'Device theme';
	@override String get dark => 'Dark';
	@override String get light => 'Light';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'currentReferralScreen.appbar': return 'Referral Campaign';
			case 'currentReferralScreen.header': return 'Your referral code';
			case 'errors.generalTitle': return 'Oops! Something went wrong';
			case 'errors.generalDescription': return 'Something broke, but we\'re fixing it. Try again in a moment.';
			case 'errors.generalRetryButtonText': return 'Retry';
			case 'errors.failedToLoadMembershipError': return 'Failed to retrieve information about your membership.';
			case 'errors.failedToLoadLocationData': return 'Failed to load location data.';
			case 'errors.failedToLoadLocations': return 'Failed to fetch all EVO locations.';
			case 'errors.failedToLoadWorkoutStatistics': return 'Failed to load your workouts.';
			case 'errors.failedToLoadInvoices': return 'Failed to fetch your invoices.';
			case 'errors.failedToOpenUrl': return 'Failed to open URL.';
			case 'errors.failedToLoadCurrentMembershipReferral': return 'Failed to load membership referral info.';
			case 'format.yesterday': return 'yesterday';
			case 'format.today': return 'today';
			case 'format.tomorrow': return 'tomorrow';
			case 'forms.cancel': return 'Cancel';
			case 'forms.ok': return 'OK';
			case 'forms.fields.firstname.label': return 'First name';
			case 'forms.fields.firstname.hint': return 'Type your first name';
			case 'forms.fields.firstname.validation.empty': return 'Please enter a name';
			case 'forms.fields.lastName.label': return 'Last name';
			case 'forms.fields.lastName.hint': return 'Type your last name';
			case 'forms.fields.lastName.validation.empty': return 'Please enter a last name';
			case 'forms.fields.mobile.label': return 'Mobile';
			case 'forms.fields.mobile.hint': return 'Input your mobile';
			case 'forms.fields.mobile.validation.empty': return 'Mobile is required';
			case 'forms.fields.mobile.validation.invalid': return 'Mobile is not valid';
			case 'forms.fields.email.label': return 'Email';
			case 'forms.fields.email.hint': return 'Type your e-mail';
			case 'forms.fields.email.validation.emptyFull': return 'Please enter your e-mail';
			case 'forms.fields.email.validation.invalidFull': return 'Please enter a valid e-mail';
			case 'forms.fields.email.validation.emptyShort': return 'E-mail is required';
			case 'forms.fields.email.validation.invalidShort': return 'Invalid e-mail';
			case 'forms.fields.password.label': return 'Password';
			case 'forms.fields.password.hint': return 'Type your password';
			case 'forms.fields.password.validation.empty': return 'Please enter password';
			case 'forms.fields.streetAddress.label': return 'Address';
			case 'forms.fields.streetAddress.validation.empty': return 'This is required';
			case 'forms.fields.addressCity.label': return 'Place';
			case 'forms.fields.addressCity.validation.empty': return 'This is required';
			case 'forms.fields.postalCode.label': return 'Postal code';
			case 'forms.fields.postalCode.validation.empty': return 'This is required';
			case 'homeScreen.membershipStatus': return 'Your membership is';
			case 'homeScreen.explore': return 'Explore membership';
			case 'homeScreen.currentLocationStatisticsTitle': return 'Number of people now at';
			case 'homeScreen.presentOrFutureLocationTimelineTitle': return ({required InlineSpan formattedDate}) => TextSpan(children: [
				const TextSpan(text: 'Expected visits '),
				formattedDate,
			]);
			case 'homeScreen.oldLocationTimelineTitle': return ({required InlineSpan formattedDate}) => TextSpan(children: [
				const TextSpan(text: 'Used capacity '),
				formattedDate,
			]);
			case 'homeScreen.shortcuts.0': return 'Your keys';
			case 'homeScreen.shortcuts.1': return 'Workouts';
			case 'homeScreen.chooseLocation': return 'Choose EVO location';
			case 'homeScreen.primaryMembershipLocation': return 'Your primary location';
			case 'keyStatuses.active': return 'Active';
			case 'keyStatuses.inactive': return 'Inactive';
			case 'keyTypes.rfid': return 'Access Tag';
			case 'keyTypes.pinCode': return 'PIN code';
			case 'keyTypes.unknown': return 'Unknown key type';
			case 'membershipStatuses.presale': return 'Pre-sale';
			case 'membershipStatuses.inTrial': return 'In trial';
			case 'membershipStatuses.active': return 'Active';
			case 'membershipStatuses.freezed': return 'Freezed';
			case 'membershipStatuses.pendingCancellation': return 'Pending cancellation';
			case 'membershipStatuses.cancelled': return 'Cancelled';
			case 'membershipStatuses.cancelledInPresale': return 'Cancelled in pre-sale';
			case 'membershipStatuses.cancelledInTrial': return 'Cancelled in trial';
			case 'membershipStatuses.stopped': return 'Stopped';
			case 'membershipStatuses.unknown': return 'Unknown';
			case 'paymentScreen.appbar': return 'Payment';
			case 'paymentScreen.paymentCardHeader': return 'Payment card';
			case 'paymentScreen.previousPaymentsHeader': return 'Previous payments';
			case 'paymentScreen.tableHeaders.date.label': return 'Date';
			case 'paymentScreen.tableHeaders.amount.label': return 'Amount';
			case 'paymentScreen.tableHeaders.period.label': return 'Period';
			case 'paymentScreen.tableHeaders.pdf.label': return 'PDF';
			case 'primaryLocationScreen.appbar': return 'Primary Location';
			case 'primaryLocationScreen.header': return 'Your primary location';
			case 'primaryLocationScreen.updateSuccessful': return ({required Object name}) => '${name} now set as your primary location.';
			case 'profileScreen.appbar': return 'Profile Information';
			case 'profileScreen.personalInformationHeader': return 'Personal information';
			case 'profileScreen.termsHeader': return 'Membership terms';
			case 'profileScreen.updateSuccessful': return 'Personal information updated.';
			case 'settingsScreen.appBar': return 'Settings';
			case 'settingsScreen.accountMenuItems.header': return 'Account Settings';
			case 'settingsScreen.accountMenuItems.profileInformation.title': return 'Account Information';
			case 'settingsScreen.accountMenuItems.profileInformation.subtitle': return 'Change your account information';
			case 'settingsScreen.accountMenuItems.payment.title': return 'Payment';
			case 'settingsScreen.accountMenuItems.payment.subtitle': return 'Check your payment card';
			case 'settingsScreen.accountMenuItems.locations.title': return 'Your primary location';
			case 'settingsScreen.accountMenuItems.locations.subtitle': return 'Change your primary location';
			case 'settingsScreen.accountMenuItems.referral.title': return 'Referral Campaign';
			case 'settingsScreen.accountMenuItems.referral.subtitle': return 'Get exclusive promotions';
			case 'settingsScreen.accountMenuItems.signOut.title': return 'Sign Out';
			case 'settingsScreen.accountMenuItems.signOut.subtitle': return 'Hope to see you again';
			case 'settingsScreen.appMenuItems.header': return 'App Settings';
			case 'settingsScreen.appMenuItems.appTheme.title': return 'Theme';
			case 'settingsScreen.appMenuItems.appTheme.subtitle': return 'Change the look of the app';
			case 'settingsScreen.appMenuItems.appTheme.options.deviceTheme': return 'Device theme';
			case 'settingsScreen.appMenuItems.appTheme.options.dark': return 'Dark';
			case 'settingsScreen.appMenuItems.appTheme.options.light': return 'Light';
			case 'settingsScreen.appMenuItems.systemColors.title': return 'Use system colors';
			case 'settingsScreen.appMenuItems.systemColors.subtitle': return 'Make use of the system color palette';
			case 'settingsScreen.appMenuItems.locale.title': return 'Language';
			case 'settingsScreen.appMenuItems.locale.subtitle': return 'Select preferred language';
			case 'settingsScreen.appMenuItems.locale.optionsMap.en': return 'English';
			case 'settingsScreen.appMenuItems.locale.optionsMap.no': return 'Norwegian';
			case 'signInScreen.title': return 'Sign in';
			case 'signInScreen.header': return 'Welcome back!';
			case 'signInScreen.subtitle': return 'Sign in with your e-mail and password.';
			case 'signInScreen.buttons.signIn': return 'Sign in';
			case 'signInScreen.buttons.forgotPassword': return 'Forgot password?';
			case 'signInScreen.buttons.becomeMember': return 'Become member';
			case 'signInScreen.errorMessages.invalidCredentials': return 'Username or password is incorrect.';
			case 'signInScreen.errorMessages.genericError': return 'An error occured. Please try again.';
			case 'welcomeScreen.welcomeHeader': return 'Welcome to';
			case 'welcomeScreen.subtitle': return 'The strength you need';
			case 'welcomeScreen.signInButton': return 'Sign in';
			case 'workoutsScreen.appBar': return 'Workouts';
			case 'workoutsScreen.title': return ({required InlineSpan totalWorkoutsCount}) => TextSpan(children: [
				totalWorkoutsCount,
				const TextSpan(text: ' workouts'),
			]);
			case 'workoutsScreen.subtitle': return 'You have performed a total of';
			case 'workoutsScreen.monthStatisticBar': return ({required InlineSpan workoutsCount}) => TextSpan(children: [
				workoutsCount,
				const TextSpan(text: ' workouts'),
			]);
			case 'workoutsScreen.encouragements.0': return 'you\'re awesome!';
			case 'workoutsScreen.encouragements.1': return 'great job!';
			case 'workoutsScreen.encouragements.2': return 'pure power!';
			case 'workoutsScreen.encouragements.3': return 'wow!';
			case 'workoutsScreen.encouragements.4': return 'way to go!';
			case 'workoutsScreen.months.0': return 'January';
			case 'workoutsScreen.months.1': return 'February';
			case 'workoutsScreen.months.2': return 'March';
			case 'workoutsScreen.months.3': return 'April';
			case 'workoutsScreen.months.4': return 'May';
			case 'workoutsScreen.months.5': return 'June';
			case 'workoutsScreen.months.6': return 'July';
			case 'workoutsScreen.months.7': return 'August';
			case 'workoutsScreen.months.8': return 'September';
			case 'workoutsScreen.months.9': return 'October';
			case 'workoutsScreen.months.10': return 'November';
			case 'workoutsScreen.months.11': return 'December';
			default: return null;
		}
	}
}

