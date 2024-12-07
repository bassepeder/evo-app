///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsNo = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.no,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <no>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsErrorsNo errors = TranslationsErrorsNo.internal(_root);
	late final TranslationsFormatNo format = TranslationsFormatNo.internal(_root);
	late final TranslationsHomeScreenNo homeScreen = TranslationsHomeScreenNo.internal(_root);
	late final TranslationsMembershipStatusesNo membershipStatuses = TranslationsMembershipStatusesNo.internal(_root);
	late final TranslationsSignInScreenNo signInScreen = TranslationsSignInScreenNo.internal(_root);
	late final TranslationsValidationNo validation = TranslationsValidationNo.internal(_root);
	late final TranslationsWelcomeScreenNo welcomeScreen = TranslationsWelcomeScreenNo.internal(_root);
}

// Path: errors
class TranslationsErrorsNo {
	TranslationsErrorsNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get generalTitle => 'Oi! Noe gikk galt';
	String get generalDescription => 'Noe gikk i stykker, men vi jobber med det. Prøv igjen om litt.';
	String get generalRetryButtonText => 'Prøv igjen';
	String get failedToLoadMembershipError => 'Kunne ikke hente informasjon om medlemskapet ditt.';
	String get failedToLoadLocationData => 'Klarte ikke å hente lokasjonsdata.';
}

// Path: format
class TranslationsFormatNo {
	TranslationsFormatNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get yesterday => 'i går';
	String get today => 'i dag';
	String get tomorrow => 'i morgen';
}

// Path: homeScreen
class TranslationsHomeScreenNo {
	TranslationsHomeScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get membershipStatus => 'Ditt medlemsskap er';
	String get explore => 'Utforsk medlemsskap';
	String get currentLocationStatisticsTitle => 'Antall personer nå inne på';
	TextSpan locationTimelineTitle({required InlineSpan formattedDate}) => TextSpan(children: [
		const TextSpan(text: 'Forventet besøk '),
		formattedDate,
	]);
	List<String> get shortcuts => [
		'Dine nøkler',
		'Treningsøkter',
	];
}

// Path: membershipStatuses
class TranslationsMembershipStatusesNo {
	TranslationsMembershipStatusesNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get presale => 'Før salg';
	String get inTrial => 'I prøveperiode';
	String get active => 'Aktiv';
	String get freezed => 'Fryst';
	String get pendingCancellation => 'Under kansellering';
	String get cancelled => 'Kansellert';
	String get cancelledInPresale => 'Kansellert i før salg';
	String get cancelledInTrial => 'Kansellert i prøveperiode';
	String get stopped => 'Stoppet';
	String get unknown => 'Ukjent';
}

// Path: signInScreen
class TranslationsSignInScreenNo {
	TranslationsSignInScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Logg inn';
	String get header => 'Velkommen tilbake!';
	String get subtitle => 'Logg inn med e-posten og passordet ditt.';
	late final TranslationsSignInScreenFormNo form = TranslationsSignInScreenFormNo.internal(_root);
	late final TranslationsSignInScreenButtonsNo buttons = TranslationsSignInScreenButtonsNo.internal(_root);
	late final TranslationsSignInScreenErrorMessagesNo errorMessages = TranslationsSignInScreenErrorMessagesNo.internal(_root);
}

// Path: validation
class TranslationsValidationNo {
	TranslationsValidationNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsValidationFormsNo forms = TranslationsValidationFormsNo.internal(_root);
}

// Path: welcomeScreen
class TranslationsWelcomeScreenNo {
	TranslationsWelcomeScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get welcomeHeader => 'Velkommen til ';
	String get subtitle => 'Styrken du trenger';
	String get signInButton => 'Logg inn';
}

// Path: signInScreen.form
class TranslationsSignInScreenFormNo {
	TranslationsSignInScreenFormNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSignInScreenFormEmailNo email = TranslationsSignInScreenFormEmailNo.internal(_root);
	late final TranslationsSignInScreenFormPasswordNo password = TranslationsSignInScreenFormPasswordNo.internal(_root);
}

// Path: signInScreen.buttons
class TranslationsSignInScreenButtonsNo {
	TranslationsSignInScreenButtonsNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get signIn => 'Logg inn';
	String get forgotPassword => 'Glemt passord?';
	String get becomeMember => 'Bli medlem';
}

// Path: signInScreen.errorMessages
class TranslationsSignInScreenErrorMessagesNo {
	TranslationsSignInScreenErrorMessagesNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get invalidCredentials => 'Brukernavn eller passord samsvarer ikke.';
	String get genericError => 'En feil oppstod. Prøv igjen senere.';
}

// Path: validation.forms
class TranslationsValidationFormsNo {
	TranslationsValidationFormsNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsValidationFormsInputFieldsNo inputFields = TranslationsValidationFormsInputFieldsNo.internal(_root);
}

// Path: signInScreen.form.email
class TranslationsSignInScreenFormEmailNo {
	TranslationsSignInScreenFormEmailNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'E-post';
	String get hint => 'Skriv inn e-postaddressen din';
}

// Path: signInScreen.form.password
class TranslationsSignInScreenFormPasswordNo {
	TranslationsSignInScreenFormPasswordNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Passord';
	String get hint => 'Skriv inn passordet ditt';
}

// Path: validation.forms.inputFields
class TranslationsValidationFormsInputFieldsNo {
	TranslationsValidationFormsInputFieldsNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsValidationFormsInputFieldsEmailNo email = TranslationsValidationFormsInputFieldsEmailNo.internal(_root);
	late final TranslationsValidationFormsInputFieldsPasswordNo password = TranslationsValidationFormsInputFieldsPasswordNo.internal(_root);
}

// Path: validation.forms.inputFields.email
class TranslationsValidationFormsInputFieldsEmailNo {
	TranslationsValidationFormsInputFieldsEmailNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Vennligst skriv inn e-postadressen din';
	String get invalid => 'Vennligst skriv inn en gyldig e-post';
}

// Path: validation.forms.inputFields.password
class TranslationsValidationFormsInputFieldsPasswordNo {
	TranslationsValidationFormsInputFieldsPasswordNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Vennligst skriv inn passordet ditt';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'errors.generalTitle': return 'Oi! Noe gikk galt';
			case 'errors.generalDescription': return 'Noe gikk i stykker, men vi jobber med det. Prøv igjen om litt.';
			case 'errors.generalRetryButtonText': return 'Prøv igjen';
			case 'errors.failedToLoadMembershipError': return 'Kunne ikke hente informasjon om medlemskapet ditt.';
			case 'errors.failedToLoadLocationData': return 'Klarte ikke å hente lokasjonsdata.';
			case 'format.yesterday': return 'i går';
			case 'format.today': return 'i dag';
			case 'format.tomorrow': return 'i morgen';
			case 'homeScreen.membershipStatus': return 'Ditt medlemsskap er';
			case 'homeScreen.explore': return 'Utforsk medlemsskap';
			case 'homeScreen.currentLocationStatisticsTitle': return 'Antall personer nå inne på';
			case 'homeScreen.locationTimelineTitle': return ({required InlineSpan formattedDate}) => TextSpan(children: [
				const TextSpan(text: 'Forventet besøk '),
				formattedDate,
			]);
			case 'homeScreen.shortcuts.0': return 'Dine nøkler';
			case 'homeScreen.shortcuts.1': return 'Treningsøkter';
			case 'membershipStatuses.presale': return 'Før salg';
			case 'membershipStatuses.inTrial': return 'I prøveperiode';
			case 'membershipStatuses.active': return 'Aktiv';
			case 'membershipStatuses.freezed': return 'Fryst';
			case 'membershipStatuses.pendingCancellation': return 'Under kansellering';
			case 'membershipStatuses.cancelled': return 'Kansellert';
			case 'membershipStatuses.cancelledInPresale': return 'Kansellert i før salg';
			case 'membershipStatuses.cancelledInTrial': return 'Kansellert i prøveperiode';
			case 'membershipStatuses.stopped': return 'Stoppet';
			case 'membershipStatuses.unknown': return 'Ukjent';
			case 'signInScreen.title': return 'Logg inn';
			case 'signInScreen.header': return 'Velkommen tilbake!';
			case 'signInScreen.subtitle': return 'Logg inn med e-posten og passordet ditt.';
			case 'signInScreen.form.email.label': return 'E-post';
			case 'signInScreen.form.email.hint': return 'Skriv inn e-postaddressen din';
			case 'signInScreen.form.password.label': return 'Passord';
			case 'signInScreen.form.password.hint': return 'Skriv inn passordet ditt';
			case 'signInScreen.buttons.signIn': return 'Logg inn';
			case 'signInScreen.buttons.forgotPassword': return 'Glemt passord?';
			case 'signInScreen.buttons.becomeMember': return 'Bli medlem';
			case 'signInScreen.errorMessages.invalidCredentials': return 'Brukernavn eller passord samsvarer ikke.';
			case 'signInScreen.errorMessages.genericError': return 'En feil oppstod. Prøv igjen senere.';
			case 'validation.forms.inputFields.email.empty': return 'Vennligst skriv inn e-postadressen din';
			case 'validation.forms.inputFields.email.invalid': return 'Vennligst skriv inn en gyldig e-post';
			case 'validation.forms.inputFields.password.empty': return 'Vennligst skriv inn passordet ditt';
			case 'welcomeScreen.welcomeHeader': return 'Velkommen til ';
			case 'welcomeScreen.subtitle': return 'Styrken du trenger';
			case 'welcomeScreen.signInButton': return 'Logg inn';
			default: return null;
		}
	}
}

