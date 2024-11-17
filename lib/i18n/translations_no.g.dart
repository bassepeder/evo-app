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
	late final TranslationsSignInScreenNo signInScreen = TranslationsSignInScreenNo.internal(_root);
	late final TranslationsValidationNo validation = TranslationsValidationNo.internal(_root);
	late final TranslationsWelcomeScreenNo welcomeScreen = TranslationsWelcomeScreenNo.internal(_root);
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
	String get signInButton => 'Logg inn';
	String get forgotPassword => 'Glemt passord?';
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
			case 'signInScreen.title': return 'Logg inn';
			case 'signInScreen.header': return 'Velkommen tilbake!';
			case 'signInScreen.subtitle': return 'Logg inn med e-posten og passordet ditt.';
			case 'signInScreen.form.email.label': return 'E-post';
			case 'signInScreen.form.email.hint': return 'Skriv inn e-postaddressen din';
			case 'signInScreen.form.password.label': return 'Passord';
			case 'signInScreen.form.password.hint': return 'Skriv inn passordet ditt';
			case 'signInScreen.signInButton': return 'Logg inn';
			case 'signInScreen.forgotPassword': return 'Glemt passord?';
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

