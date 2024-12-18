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
	late final TranslationsCurrentReferralScreenNo currentReferralScreen = TranslationsCurrentReferralScreenNo.internal(_root);
	late final TranslationsErrorsNo errors = TranslationsErrorsNo.internal(_root);
	late final TranslationsFormatNo format = TranslationsFormatNo.internal(_root);
	late final TranslationsFormsNo forms = TranslationsFormsNo.internal(_root);
	late final TranslationsHomeScreenNo homeScreen = TranslationsHomeScreenNo.internal(_root);
	late final TranslationsKeyStatusesNo keyStatuses = TranslationsKeyStatusesNo.internal(_root);
	late final TranslationsKeyTypesNo keyTypes = TranslationsKeyTypesNo.internal(_root);
	late final TranslationsMembershipStatusesNo membershipStatuses = TranslationsMembershipStatusesNo.internal(_root);
	late final TranslationsPaymentScreenNo paymentScreen = TranslationsPaymentScreenNo.internal(_root);
	late final TranslationsPrimaryLocationScreenNo primaryLocationScreen = TranslationsPrimaryLocationScreenNo.internal(_root);
	late final TranslationsProfileScreenNo profileScreen = TranslationsProfileScreenNo.internal(_root);
	late final TranslationsSettingsScreenNo settingsScreen = TranslationsSettingsScreenNo.internal(_root);
	late final TranslationsSignInScreenNo signInScreen = TranslationsSignInScreenNo.internal(_root);
	late final TranslationsWelcomeScreenNo welcomeScreen = TranslationsWelcomeScreenNo.internal(_root);
	late final TranslationsWorkoutsScreenNo workoutsScreen = TranslationsWorkoutsScreenNo.internal(_root);
}

// Path: currentReferralScreen
class TranslationsCurrentReferralScreenNo {
	TranslationsCurrentReferralScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get appbar => 'Vervekampanje';
	String get header => 'Din vervekode';
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
	String get failedToLoadLocations => 'Klarte ikke å hente alle EVO lokasjoner.';
	String get failedToLoadWorkoutStatistics => 'Klarte ikke å hente treningsøktene dine.';
	String get failedToLoadInvoices => 'Klarte ikke å hente fakturaene dine.';
	String get failedToOpenUrl => 'Klarte ikke å åpne URL.';
	String get failedToLoadCurrentMembershipReferral => 'Klarte ikke å hente info om din vervekampanje.';
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

// Path: forms
class TranslationsFormsNo {
	TranslationsFormsNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get cancel => 'Avbryt';
	String get ok => 'OK';
	late final TranslationsFormsFieldsNo fields = TranslationsFormsFieldsNo.internal(_root);
}

// Path: homeScreen
class TranslationsHomeScreenNo {
	TranslationsHomeScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get membershipStatus => 'Ditt medlemsskap er';
	String get explore => 'Utforsk medlemsskap';
	String get currentLocationStatisticsTitle => 'Antall personer nå inne på';
	TextSpan presentOrFutureLocationTimelineTitle({required InlineSpan formattedDate}) => TextSpan(children: [
		const TextSpan(text: 'Forventet besøk '),
		formattedDate,
	]);
	TextSpan oldLocationTimelineTitle({required InlineSpan formattedDate}) => TextSpan(children: [
		const TextSpan(text: 'Brukt kapasitet '),
		formattedDate,
	]);
	List<String> get shortcuts => [
		'Dine nøkler',
		'Treningsøkter',
	];
	String get chooseLocation => 'Velg EVO senter';
	String get primaryMembershipLocation => 'Ditt primærsenter';
}

// Path: keyStatuses
class TranslationsKeyStatusesNo {
	TranslationsKeyStatusesNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get active => 'Aktiv';
	String get inactive => 'Inaktiv';
}

// Path: keyTypes
class TranslationsKeyTypesNo {
	TranslationsKeyTypesNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get rfid => 'Adgangsbrikke';
	String get pinCode => 'PIN kode';
	String get unknown => 'Ukjent nøkkeltype';
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

// Path: paymentScreen
class TranslationsPaymentScreenNo {
	TranslationsPaymentScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get appbar => 'Betaling';
	String get paymentCardHeader => 'Betalingskort';
	String get previousPaymentsHeader => 'Tidligere betalinger';
	late final TranslationsPaymentScreenTableHeadersNo tableHeaders = TranslationsPaymentScreenTableHeadersNo.internal(_root);
}

// Path: primaryLocationScreen
class TranslationsPrimaryLocationScreenNo {
	TranslationsPrimaryLocationScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get appbar => 'Primærsenter';
	String get header => 'Ditt primærsenter';
	String updateSuccessful({required Object name}) => '${name} satt som ditt primærsenter.';
}

// Path: profileScreen
class TranslationsProfileScreenNo {
	TranslationsProfileScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get appbar => 'Kontoinformasjon';
	String get personalInformationHeader => 'Personlig informasjon ';
	String get termsHeader => 'Medlemsvilkår';
	String get updateSuccessful => 'Personlig informasjon oppdatert.';
}

// Path: settingsScreen
class TranslationsSettingsScreenNo {
	TranslationsSettingsScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get appBar => 'Instillinger';
	late final TranslationsSettingsScreenAccountMenuItemsNo accountMenuItems = TranslationsSettingsScreenAccountMenuItemsNo.internal(_root);
	late final TranslationsSettingsScreenAppMenuItemsNo appMenuItems = TranslationsSettingsScreenAppMenuItemsNo.internal(_root);
}

// Path: signInScreen
class TranslationsSignInScreenNo {
	TranslationsSignInScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Logg inn';
	String get header => 'Velkommen tilbake!';
	String get subtitle => 'Logg inn med e-posten og passordet ditt.';
	late final TranslationsSignInScreenButtonsNo buttons = TranslationsSignInScreenButtonsNo.internal(_root);
	late final TranslationsSignInScreenErrorMessagesNo errorMessages = TranslationsSignInScreenErrorMessagesNo.internal(_root);
}

// Path: welcomeScreen
class TranslationsWelcomeScreenNo {
	TranslationsWelcomeScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get welcomeHeader => 'Velkommen til';
	String get subtitle => 'Styrken du trenger';
	String get signInButton => 'Logg inn';
}

// Path: workoutsScreen
class TranslationsWorkoutsScreenNo {
	TranslationsWorkoutsScreenNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get appBar => 'Treningsøkter';
	TextSpan title({required InlineSpan totalWorkoutsCount}) => TextSpan(children: [
		totalWorkoutsCount,
		const TextSpan(text: ' treningsøkter'),
	]);
	String get subtitle => 'Du har totalt utført';
	TextSpan monthStatisticBar({required InlineSpan workoutsCount}) => TextSpan(children: [
		workoutsCount,
		const TextSpan(text: ' økter'),
	]);
	List<String> get encouragements => [
		'du er rå!',
		'bra jobba!',
		'råskap!',
		'wow!',
	];
	List<String> get months => [
		'Januar',
		'Februar',
		'Mars',
		'April',
		'Mai',
		'Juni',
		'Juli',
		'August',
		'September',
		'Oktober',
		'November',
		'Desember',
	];
}

// Path: forms.fields
class TranslationsFormsFieldsNo {
	TranslationsFormsFieldsNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsFormsFieldsFirstnameNo firstname = TranslationsFormsFieldsFirstnameNo.internal(_root);
	late final TranslationsFormsFieldsLastNameNo lastName = TranslationsFormsFieldsLastNameNo.internal(_root);
	late final TranslationsFormsFieldsMobileNo mobile = TranslationsFormsFieldsMobileNo.internal(_root);
	late final TranslationsFormsFieldsEmailNo email = TranslationsFormsFieldsEmailNo.internal(_root);
	late final TranslationsFormsFieldsPasswordNo password = TranslationsFormsFieldsPasswordNo.internal(_root);
	late final TranslationsFormsFieldsStreetAddressNo streetAddress = TranslationsFormsFieldsStreetAddressNo.internal(_root);
	late final TranslationsFormsFieldsAddressCityNo addressCity = TranslationsFormsFieldsAddressCityNo.internal(_root);
	late final TranslationsFormsFieldsPostalCodeNo postalCode = TranslationsFormsFieldsPostalCodeNo.internal(_root);
}

// Path: paymentScreen.tableHeaders
class TranslationsPaymentScreenTableHeadersNo {
	TranslationsPaymentScreenTableHeadersNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPaymentScreenTableHeadersDateNo date = TranslationsPaymentScreenTableHeadersDateNo.internal(_root);
	late final TranslationsPaymentScreenTableHeadersAmountNo amount = TranslationsPaymentScreenTableHeadersAmountNo.internal(_root);
	late final TranslationsPaymentScreenTableHeadersPeriodNo period = TranslationsPaymentScreenTableHeadersPeriodNo.internal(_root);
	late final TranslationsPaymentScreenTableHeadersPdfNo pdf = TranslationsPaymentScreenTableHeadersPdfNo.internal(_root);
}

// Path: settingsScreen.accountMenuItems
class TranslationsSettingsScreenAccountMenuItemsNo {
	TranslationsSettingsScreenAccountMenuItemsNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get header => 'Kontoinstillinger';
	late final TranslationsSettingsScreenAccountMenuItemsProfileInformationNo profileInformation = TranslationsSettingsScreenAccountMenuItemsProfileInformationNo.internal(_root);
	late final TranslationsSettingsScreenAccountMenuItemsPaymentNo payment = TranslationsSettingsScreenAccountMenuItemsPaymentNo.internal(_root);
	late final TranslationsSettingsScreenAccountMenuItemsLocationsNo locations = TranslationsSettingsScreenAccountMenuItemsLocationsNo.internal(_root);
	late final TranslationsSettingsScreenAccountMenuItemsReferralNo referral = TranslationsSettingsScreenAccountMenuItemsReferralNo.internal(_root);
	late final TranslationsSettingsScreenAccountMenuItemsSignOutNo signOut = TranslationsSettingsScreenAccountMenuItemsSignOutNo.internal(_root);
}

// Path: settingsScreen.appMenuItems
class TranslationsSettingsScreenAppMenuItemsNo {
	TranslationsSettingsScreenAppMenuItemsNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get header => 'App-innstillinger';
	late final TranslationsSettingsScreenAppMenuItemsAppThemeNo appTheme = TranslationsSettingsScreenAppMenuItemsAppThemeNo.internal(_root);
	late final TranslationsSettingsScreenAppMenuItemsLocaleNo locale = TranslationsSettingsScreenAppMenuItemsLocaleNo.internal(_root);
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

// Path: forms.fields.firstname
class TranslationsFormsFieldsFirstnameNo {
	TranslationsFormsFieldsFirstnameNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Fornavn';
	String get hint => 'Skriv inn fornavnet ditt';
	late final TranslationsFormsFieldsFirstnameValidationNo validation = TranslationsFormsFieldsFirstnameValidationNo.internal(_root);
}

// Path: forms.fields.lastName
class TranslationsFormsFieldsLastNameNo {
	TranslationsFormsFieldsLastNameNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Etternavn';
	String get hint => 'Skriv inn etternavnet idtt';
	late final TranslationsFormsFieldsLastNameValidationNo validation = TranslationsFormsFieldsLastNameValidationNo.internal(_root);
}

// Path: forms.fields.mobile
class TranslationsFormsFieldsMobileNo {
	TranslationsFormsFieldsMobileNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Mobil';
	String get hint => 'Skriv inn mobilnummeret ditt';
	late final TranslationsFormsFieldsMobileValidationNo validation = TranslationsFormsFieldsMobileValidationNo.internal(_root);
}

// Path: forms.fields.email
class TranslationsFormsFieldsEmailNo {
	TranslationsFormsFieldsEmailNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'E-post';
	String get hint => 'Skriv inn e-postaddressen din';
	late final TranslationsFormsFieldsEmailValidationNo validation = TranslationsFormsFieldsEmailValidationNo.internal(_root);
}

// Path: forms.fields.password
class TranslationsFormsFieldsPasswordNo {
	TranslationsFormsFieldsPasswordNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Passord';
	String get hint => 'Skriv inn passordet ditt';
	late final TranslationsFormsFieldsPasswordValidationNo validation = TranslationsFormsFieldsPasswordValidationNo.internal(_root);
}

// Path: forms.fields.streetAddress
class TranslationsFormsFieldsStreetAddressNo {
	TranslationsFormsFieldsStreetAddressNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Addresse';
	late final TranslationsFormsFieldsStreetAddressValidationNo validation = TranslationsFormsFieldsStreetAddressValidationNo.internal(_root);
}

// Path: forms.fields.addressCity
class TranslationsFormsFieldsAddressCityNo {
	TranslationsFormsFieldsAddressCityNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Sted';
	late final TranslationsFormsFieldsAddressCityValidationNo validation = TranslationsFormsFieldsAddressCityValidationNo.internal(_root);
}

// Path: forms.fields.postalCode
class TranslationsFormsFieldsPostalCodeNo {
	TranslationsFormsFieldsPostalCodeNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Postnummer';
	late final TranslationsFormsFieldsPostalCodeValidationNo validation = TranslationsFormsFieldsPostalCodeValidationNo.internal(_root);
}

// Path: paymentScreen.tableHeaders.date
class TranslationsPaymentScreenTableHeadersDateNo {
	TranslationsPaymentScreenTableHeadersDateNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Dato';
}

// Path: paymentScreen.tableHeaders.amount
class TranslationsPaymentScreenTableHeadersAmountNo {
	TranslationsPaymentScreenTableHeadersAmountNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Beløp';
}

// Path: paymentScreen.tableHeaders.period
class TranslationsPaymentScreenTableHeadersPeriodNo {
	TranslationsPaymentScreenTableHeadersPeriodNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Periode';
}

// Path: paymentScreen.tableHeaders.pdf
class TranslationsPaymentScreenTableHeadersPdfNo {
	TranslationsPaymentScreenTableHeadersPdfNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'PDF';
}

// Path: settingsScreen.accountMenuItems.profileInformation
class TranslationsSettingsScreenAccountMenuItemsProfileInformationNo {
	TranslationsSettingsScreenAccountMenuItemsProfileInformationNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Kontoinformasjon';
	String get subtitle => 'Endre dine kontoopplysninger';
}

// Path: settingsScreen.accountMenuItems.payment
class TranslationsSettingsScreenAccountMenuItemsPaymentNo {
	TranslationsSettingsScreenAccountMenuItemsPaymentNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Betaling';
	String get subtitle => 'Kontroller ditt betalingskort';
}

// Path: settingsScreen.accountMenuItems.locations
class TranslationsSettingsScreenAccountMenuItemsLocationsNo {
	TranslationsSettingsScreenAccountMenuItemsLocationsNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Ditt primærsenter';
	String get subtitle => 'Endre ditt primærsenter';
}

// Path: settingsScreen.accountMenuItems.referral
class TranslationsSettingsScreenAccountMenuItemsReferralNo {
	TranslationsSettingsScreenAccountMenuItemsReferralNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Vervekampanje';
	String get subtitle => 'Få ekslusive kampanjer';
}

// Path: settingsScreen.accountMenuItems.signOut
class TranslationsSettingsScreenAccountMenuItemsSignOutNo {
	TranslationsSettingsScreenAccountMenuItemsSignOutNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Logg ut';
	String get subtitle => 'Håper vi sees igjen';
}

// Path: settingsScreen.appMenuItems.appTheme
class TranslationsSettingsScreenAppMenuItemsAppThemeNo {
	TranslationsSettingsScreenAppMenuItemsAppThemeNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Utseende';
	String get subtitle => 'Velg mellom mørkt og lyst tema';
	late final TranslationsSettingsScreenAppMenuItemsAppThemeOptionsNo options = TranslationsSettingsScreenAppMenuItemsAppThemeOptionsNo.internal(_root);
}

// Path: settingsScreen.appMenuItems.locale
class TranslationsSettingsScreenAppMenuItemsLocaleNo {
	TranslationsSettingsScreenAppMenuItemsLocaleNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Språk';
	String get subtitle => 'Endre språk';
	Map<String, String> get optionsMap => {
		'en': 'Engelsk',
		'no': 'Norsk',
	};
}

// Path: forms.fields.firstname.validation
class TranslationsFormsFieldsFirstnameValidationNo {
	TranslationsFormsFieldsFirstnameValidationNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Vennligst skriv inn fornavnet ditt';
}

// Path: forms.fields.lastName.validation
class TranslationsFormsFieldsLastNameValidationNo {
	TranslationsFormsFieldsLastNameValidationNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Vennligst skriv inn etternavnet ditt';
}

// Path: forms.fields.mobile.validation
class TranslationsFormsFieldsMobileValidationNo {
	TranslationsFormsFieldsMobileValidationNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Nummer er påkrevd';
	String get invalid => 'Ugyldig mobilnummer';
}

// Path: forms.fields.email.validation
class TranslationsFormsFieldsEmailValidationNo {
	TranslationsFormsFieldsEmailValidationNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get emptyFull => 'Vennligst skriv inn e-postadressen din';
	String get invalidFull => 'Vennligst skriv inn en gyldig e-post';
	String get emptyShort => 'E-post er påkrevd';
	String get invalidShort => 'Ugyldig e-post';
}

// Path: forms.fields.password.validation
class TranslationsFormsFieldsPasswordValidationNo {
	TranslationsFormsFieldsPasswordValidationNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Vennligst skriv inn passordet ditt';
}

// Path: forms.fields.streetAddress.validation
class TranslationsFormsFieldsStreetAddressValidationNo {
	TranslationsFormsFieldsStreetAddressValidationNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Addresse er påkrevd';
}

// Path: forms.fields.addressCity.validation
class TranslationsFormsFieldsAddressCityValidationNo {
	TranslationsFormsFieldsAddressCityValidationNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Sted er påkrevd';
}

// Path: forms.fields.postalCode.validation
class TranslationsFormsFieldsPostalCodeValidationNo {
	TranslationsFormsFieldsPostalCodeValidationNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'Postnummer er påkrevd';
}

// Path: settingsScreen.appMenuItems.appTheme.options
class TranslationsSettingsScreenAppMenuItemsAppThemeOptionsNo {
	TranslationsSettingsScreenAppMenuItemsAppThemeOptionsNo.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get deviceTheme => 'Følg system';
	String get dark => 'Mørk';
	String get light => 'Lys';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'currentReferralScreen.appbar': return 'Vervekampanje';
			case 'currentReferralScreen.header': return 'Din vervekode';
			case 'errors.generalTitle': return 'Oi! Noe gikk galt';
			case 'errors.generalDescription': return 'Noe gikk i stykker, men vi jobber med det. Prøv igjen om litt.';
			case 'errors.generalRetryButtonText': return 'Prøv igjen';
			case 'errors.failedToLoadMembershipError': return 'Kunne ikke hente informasjon om medlemskapet ditt.';
			case 'errors.failedToLoadLocationData': return 'Klarte ikke å hente lokasjonsdata.';
			case 'errors.failedToLoadLocations': return 'Klarte ikke å hente alle EVO lokasjoner.';
			case 'errors.failedToLoadWorkoutStatistics': return 'Klarte ikke å hente treningsøktene dine.';
			case 'errors.failedToLoadInvoices': return 'Klarte ikke å hente fakturaene dine.';
			case 'errors.failedToOpenUrl': return 'Klarte ikke å åpne URL.';
			case 'errors.failedToLoadCurrentMembershipReferral': return 'Klarte ikke å hente info om din vervekampanje.';
			case 'format.yesterday': return 'i går';
			case 'format.today': return 'i dag';
			case 'format.tomorrow': return 'i morgen';
			case 'forms.cancel': return 'Avbryt';
			case 'forms.ok': return 'OK';
			case 'forms.fields.firstname.label': return 'Fornavn';
			case 'forms.fields.firstname.hint': return 'Skriv inn fornavnet ditt';
			case 'forms.fields.firstname.validation.empty': return 'Vennligst skriv inn fornavnet ditt';
			case 'forms.fields.lastName.label': return 'Etternavn';
			case 'forms.fields.lastName.hint': return 'Skriv inn etternavnet idtt';
			case 'forms.fields.lastName.validation.empty': return 'Vennligst skriv inn etternavnet ditt';
			case 'forms.fields.mobile.label': return 'Mobil';
			case 'forms.fields.mobile.hint': return 'Skriv inn mobilnummeret ditt';
			case 'forms.fields.mobile.validation.empty': return 'Nummer er påkrevd';
			case 'forms.fields.mobile.validation.invalid': return 'Ugyldig mobilnummer';
			case 'forms.fields.email.label': return 'E-post';
			case 'forms.fields.email.hint': return 'Skriv inn e-postaddressen din';
			case 'forms.fields.email.validation.emptyFull': return 'Vennligst skriv inn e-postadressen din';
			case 'forms.fields.email.validation.invalidFull': return 'Vennligst skriv inn en gyldig e-post';
			case 'forms.fields.email.validation.emptyShort': return 'E-post er påkrevd';
			case 'forms.fields.email.validation.invalidShort': return 'Ugyldig e-post';
			case 'forms.fields.password.label': return 'Passord';
			case 'forms.fields.password.hint': return 'Skriv inn passordet ditt';
			case 'forms.fields.password.validation.empty': return 'Vennligst skriv inn passordet ditt';
			case 'forms.fields.streetAddress.label': return 'Addresse';
			case 'forms.fields.streetAddress.validation.empty': return 'Addresse er påkrevd';
			case 'forms.fields.addressCity.label': return 'Sted';
			case 'forms.fields.addressCity.validation.empty': return 'Sted er påkrevd';
			case 'forms.fields.postalCode.label': return 'Postnummer';
			case 'forms.fields.postalCode.validation.empty': return 'Postnummer er påkrevd';
			case 'homeScreen.membershipStatus': return 'Ditt medlemsskap er';
			case 'homeScreen.explore': return 'Utforsk medlemsskap';
			case 'homeScreen.currentLocationStatisticsTitle': return 'Antall personer nå inne på';
			case 'homeScreen.presentOrFutureLocationTimelineTitle': return ({required InlineSpan formattedDate}) => TextSpan(children: [
				const TextSpan(text: 'Forventet besøk '),
				formattedDate,
			]);
			case 'homeScreen.oldLocationTimelineTitle': return ({required InlineSpan formattedDate}) => TextSpan(children: [
				const TextSpan(text: 'Brukt kapasitet '),
				formattedDate,
			]);
			case 'homeScreen.shortcuts.0': return 'Dine nøkler';
			case 'homeScreen.shortcuts.1': return 'Treningsøkter';
			case 'homeScreen.chooseLocation': return 'Velg EVO senter';
			case 'homeScreen.primaryMembershipLocation': return 'Ditt primærsenter';
			case 'keyStatuses.active': return 'Aktiv';
			case 'keyStatuses.inactive': return 'Inaktiv';
			case 'keyTypes.rfid': return 'Adgangsbrikke';
			case 'keyTypes.pinCode': return 'PIN kode';
			case 'keyTypes.unknown': return 'Ukjent nøkkeltype';
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
			case 'paymentScreen.appbar': return 'Betaling';
			case 'paymentScreen.paymentCardHeader': return 'Betalingskort';
			case 'paymentScreen.previousPaymentsHeader': return 'Tidligere betalinger';
			case 'paymentScreen.tableHeaders.date.label': return 'Dato';
			case 'paymentScreen.tableHeaders.amount.label': return 'Beløp';
			case 'paymentScreen.tableHeaders.period.label': return 'Periode';
			case 'paymentScreen.tableHeaders.pdf.label': return 'PDF';
			case 'primaryLocationScreen.appbar': return 'Primærsenter';
			case 'primaryLocationScreen.header': return 'Ditt primærsenter';
			case 'primaryLocationScreen.updateSuccessful': return ({required Object name}) => '${name} satt som ditt primærsenter.';
			case 'profileScreen.appbar': return 'Kontoinformasjon';
			case 'profileScreen.personalInformationHeader': return 'Personlig informasjon ';
			case 'profileScreen.termsHeader': return 'Medlemsvilkår';
			case 'profileScreen.updateSuccessful': return 'Personlig informasjon oppdatert.';
			case 'settingsScreen.appBar': return 'Instillinger';
			case 'settingsScreen.accountMenuItems.header': return 'Kontoinstillinger';
			case 'settingsScreen.accountMenuItems.profileInformation.title': return 'Kontoinformasjon';
			case 'settingsScreen.accountMenuItems.profileInformation.subtitle': return 'Endre dine kontoopplysninger';
			case 'settingsScreen.accountMenuItems.payment.title': return 'Betaling';
			case 'settingsScreen.accountMenuItems.payment.subtitle': return 'Kontroller ditt betalingskort';
			case 'settingsScreen.accountMenuItems.locations.title': return 'Ditt primærsenter';
			case 'settingsScreen.accountMenuItems.locations.subtitle': return 'Endre ditt primærsenter';
			case 'settingsScreen.accountMenuItems.referral.title': return 'Vervekampanje';
			case 'settingsScreen.accountMenuItems.referral.subtitle': return 'Få ekslusive kampanjer';
			case 'settingsScreen.accountMenuItems.signOut.title': return 'Logg ut';
			case 'settingsScreen.accountMenuItems.signOut.subtitle': return 'Håper vi sees igjen';
			case 'settingsScreen.appMenuItems.header': return 'App-innstillinger';
			case 'settingsScreen.appMenuItems.appTheme.title': return 'Utseende';
			case 'settingsScreen.appMenuItems.appTheme.subtitle': return 'Velg mellom mørkt og lyst tema';
			case 'settingsScreen.appMenuItems.appTheme.options.deviceTheme': return 'Følg system';
			case 'settingsScreen.appMenuItems.appTheme.options.dark': return 'Mørk';
			case 'settingsScreen.appMenuItems.appTheme.options.light': return 'Lys';
			case 'settingsScreen.appMenuItems.locale.title': return 'Språk';
			case 'settingsScreen.appMenuItems.locale.subtitle': return 'Endre språk';
			case 'settingsScreen.appMenuItems.locale.optionsMap.en': return 'Engelsk';
			case 'settingsScreen.appMenuItems.locale.optionsMap.no': return 'Norsk';
			case 'signInScreen.title': return 'Logg inn';
			case 'signInScreen.header': return 'Velkommen tilbake!';
			case 'signInScreen.subtitle': return 'Logg inn med e-posten og passordet ditt.';
			case 'signInScreen.buttons.signIn': return 'Logg inn';
			case 'signInScreen.buttons.forgotPassword': return 'Glemt passord?';
			case 'signInScreen.buttons.becomeMember': return 'Bli medlem';
			case 'signInScreen.errorMessages.invalidCredentials': return 'Brukernavn eller passord samsvarer ikke.';
			case 'signInScreen.errorMessages.genericError': return 'En feil oppstod. Prøv igjen senere.';
			case 'welcomeScreen.welcomeHeader': return 'Velkommen til';
			case 'welcomeScreen.subtitle': return 'Styrken du trenger';
			case 'welcomeScreen.signInButton': return 'Logg inn';
			case 'workoutsScreen.appBar': return 'Treningsøkter';
			case 'workoutsScreen.title': return ({required InlineSpan totalWorkoutsCount}) => TextSpan(children: [
				totalWorkoutsCount,
				const TextSpan(text: ' treningsøkter'),
			]);
			case 'workoutsScreen.subtitle': return 'Du har totalt utført';
			case 'workoutsScreen.monthStatisticBar': return ({required InlineSpan workoutsCount}) => TextSpan(children: [
				workoutsCount,
				const TextSpan(text: ' økter'),
			]);
			case 'workoutsScreen.encouragements.0': return 'du er rå!';
			case 'workoutsScreen.encouragements.1': return 'bra jobba!';
			case 'workoutsScreen.encouragements.2': return 'råskap!';
			case 'workoutsScreen.encouragements.3': return 'wow!';
			case 'workoutsScreen.months.0': return 'Januar';
			case 'workoutsScreen.months.1': return 'Februar';
			case 'workoutsScreen.months.2': return 'Mars';
			case 'workoutsScreen.months.3': return 'April';
			case 'workoutsScreen.months.4': return 'Mai';
			case 'workoutsScreen.months.5': return 'Juni';
			case 'workoutsScreen.months.6': return 'Juli';
			case 'workoutsScreen.months.7': return 'August';
			case 'workoutsScreen.months.8': return 'September';
			case 'workoutsScreen.months.9': return 'Oktober';
			case 'workoutsScreen.months.10': return 'November';
			case 'workoutsScreen.months.11': return 'Desember';
			default: return null;
		}
	}
}

