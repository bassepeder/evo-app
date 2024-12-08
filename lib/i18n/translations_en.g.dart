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
	@override late final _TranslationsErrorsEn errors = _TranslationsErrorsEn._(_root);
	@override late final _TranslationsFormatEn format = _TranslationsFormatEn._(_root);
	@override late final _TranslationsHomeScreenEn homeScreen = _TranslationsHomeScreenEn._(_root);
	@override late final _TranslationsKeyStatusesEn keyStatuses = _TranslationsKeyStatusesEn._(_root);
	@override late final _TranslationsKeyTypesEn keyTypes = _TranslationsKeyTypesEn._(_root);
	@override late final _TranslationsMembershipStatusesEn membershipStatuses = _TranslationsMembershipStatusesEn._(_root);
	@override late final _TranslationsSignInScreenEn signInScreen = _TranslationsSignInScreenEn._(_root);
	@override late final _TranslationsValidationEn validation = _TranslationsValidationEn._(_root);
	@override late final _TranslationsWelcomeScreenEn welcomeScreen = _TranslationsWelcomeScreenEn._(_root);
	@override late final _TranslationsWorkoutsScreenEn workoutsScreen = _TranslationsWorkoutsScreenEn._(_root);
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
	@override String get rfid => 'RFID chip';
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
	@override String get uknonwn => 'Unknown';
}

// Path: signInScreen
class _TranslationsSignInScreenEn extends TranslationsSignInScreenNo {
	_TranslationsSignInScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sign in';
	@override String get header => 'Welcome back!';
	@override String get subtitle => 'Sign in with your e-mail and password.';
	@override late final _TranslationsSignInScreenFormEn form = _TranslationsSignInScreenFormEn._(_root);
	@override late final _TranslationsSignInScreenButtonsEn buttons = _TranslationsSignInScreenButtonsEn._(_root);
	@override late final _TranslationsSignInScreenErrorMessagesEn errorMessages = _TranslationsSignInScreenErrorMessagesEn._(_root);
}

// Path: validation
class _TranslationsValidationEn extends TranslationsValidationNo {
	_TranslationsValidationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsValidationFormsEn forms = _TranslationsValidationFormsEn._(_root);
}

// Path: welcomeScreen
class _TranslationsWelcomeScreenEn extends TranslationsWelcomeScreenNo {
	_TranslationsWelcomeScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get welcomeHeader => 'Welcome to ';
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

// Path: signInScreen.form
class _TranslationsSignInScreenFormEn extends TranslationsSignInScreenFormNo {
	_TranslationsSignInScreenFormEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSignInScreenFormEmailEn email = _TranslationsSignInScreenFormEmailEn._(_root);
	@override late final _TranslationsSignInScreenFormPasswordEn password = _TranslationsSignInScreenFormPasswordEn._(_root);
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

// Path: validation.forms
class _TranslationsValidationFormsEn extends TranslationsValidationFormsNo {
	_TranslationsValidationFormsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsValidationFormsInputFieldsEn inputFields = _TranslationsValidationFormsInputFieldsEn._(_root);
}

// Path: signInScreen.form.email
class _TranslationsSignInScreenFormEmailEn extends TranslationsSignInScreenFormEmailNo {
	_TranslationsSignInScreenFormEmailEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Email';
	@override String get hint => 'Type your e-mail';
}

// Path: signInScreen.form.password
class _TranslationsSignInScreenFormPasswordEn extends TranslationsSignInScreenFormPasswordNo {
	_TranslationsSignInScreenFormPasswordEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Password';
	@override String get hint => 'Type your password';
}

// Path: validation.forms.inputFields
class _TranslationsValidationFormsInputFieldsEn extends TranslationsValidationFormsInputFieldsNo {
	_TranslationsValidationFormsInputFieldsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsValidationFormsInputFieldsEmailEn email = _TranslationsValidationFormsInputFieldsEmailEn._(_root);
	@override late final _TranslationsValidationFormsInputFieldsPasswordEn password = _TranslationsValidationFormsInputFieldsPasswordEn._(_root);
}

// Path: validation.forms.inputFields.email
class _TranslationsValidationFormsInputFieldsEmailEn extends TranslationsValidationFormsInputFieldsEmailNo {
	_TranslationsValidationFormsInputFieldsEmailEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter your e-mail';
	@override String get invalid => 'Please enter a valid e-mail';
}

// Path: validation.forms.inputFields.password
class _TranslationsValidationFormsInputFieldsPasswordEn extends TranslationsValidationFormsInputFieldsPasswordNo {
	_TranslationsValidationFormsInputFieldsPasswordEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter password';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'errors.generalTitle': return 'Oops! Something went wrong';
			case 'errors.generalDescription': return 'Something broke, but we\'re fixing it. Try again in a moment.';
			case 'errors.generalRetryButtonText': return 'Retry';
			case 'errors.failedToLoadMembershipError': return 'Failed to retrieve information about your membership.';
			case 'errors.failedToLoadLocationData': return 'Failed to load location data.';
			case 'errors.failedToLoadLocations': return 'Failed to fetch all EVO locations.';
			case 'format.yesterday': return 'yesterday';
			case 'format.today': return 'today';
			case 'format.tomorrow': return 'tomorrow';
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
			case 'keyTypes.rfid': return 'RFID chip';
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
			case 'membershipStatuses.uknonwn': return 'Unknown';
			case 'signInScreen.title': return 'Sign in';
			case 'signInScreen.header': return 'Welcome back!';
			case 'signInScreen.subtitle': return 'Sign in with your e-mail and password.';
			case 'signInScreen.form.email.label': return 'Email';
			case 'signInScreen.form.email.hint': return 'Type your e-mail';
			case 'signInScreen.form.password.label': return 'Password';
			case 'signInScreen.form.password.hint': return 'Type your password';
			case 'signInScreen.buttons.signIn': return 'Sign in';
			case 'signInScreen.buttons.forgotPassword': return 'Forgot password?';
			case 'signInScreen.buttons.becomeMember': return 'Become member';
			case 'signInScreen.errorMessages.invalidCredentials': return 'Username or password is incorrect.';
			case 'signInScreen.errorMessages.genericError': return 'An error occured. Please try again.';
			case 'validation.forms.inputFields.email.empty': return 'Please enter your e-mail';
			case 'validation.forms.inputFields.email.invalid': return 'Please enter a valid e-mail';
			case 'validation.forms.inputFields.password.empty': return 'Please enter password';
			case 'welcomeScreen.welcomeHeader': return 'Welcome to ';
			case 'welcomeScreen.subtitle': return 'The strength you need';
			case 'welcomeScreen.signInButton': return 'Sign in';
			case 'workoutsScreen.appBar': return 'Workouts';
			case 'workoutsScreen.title': return ({required InlineSpan totalWorkoutsCount}) => TextSpan(children: [
				totalWorkoutsCount,
				const TextSpan(text: ' workouts'),
			]);
			case 'workoutsScreen.subtitle': return 'You have performed a total of';
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

