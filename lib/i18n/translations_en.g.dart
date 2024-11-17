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
	@override late final _TranslationsSignInScreenEn signInScreen = _TranslationsSignInScreenEn._(_root);
	@override late final _TranslationsValidationEn validation = _TranslationsValidationEn._(_root);
	@override late final _TranslationsWelcomeScreenEn welcomeScreen = _TranslationsWelcomeScreenEn._(_root);
}

// Path: signInScreen
class _TranslationsSignInScreenEn extends TranslationsSignInScreenNo {
	_TranslationsSignInScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get header => 'Welcome back!';
	@override String get subtitle => 'Sign in with your e-mail and password.';
	@override late final _TranslationsSignInScreenFormEn form = _TranslationsSignInScreenFormEn._(_root);
	@override String get signInButton => 'Sign in';
	@override String get forgotPassword => 'Forgot password?';
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

// Path: signInScreen.form
class _TranslationsSignInScreenFormEn extends TranslationsSignInScreenFormNo {
	_TranslationsSignInScreenFormEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSignInScreenFormEmailEn email = _TranslationsSignInScreenFormEmailEn._(_root);
	@override late final _TranslationsSignInScreenFormPasswordEn password = _TranslationsSignInScreenFormPasswordEn._(_root);
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
			case 'signInScreen.header': return 'Welcome back!';
			case 'signInScreen.subtitle': return 'Sign in with your e-mail and password.';
			case 'signInScreen.form.email.label': return 'Email';
			case 'signInScreen.form.email.hint': return 'Type your e-mail';
			case 'signInScreen.form.password.label': return 'Password';
			case 'signInScreen.form.password.hint': return 'Type your password';
			case 'signInScreen.signInButton': return 'Sign in';
			case 'signInScreen.forgotPassword': return 'Forgot password?';
			case 'validation.forms.inputFields.email.empty': return 'Please enter your e-mail';
			case 'validation.forms.inputFields.email.invalid': return 'Please enter a valid e-mail';
			case 'validation.forms.inputFields.password.empty': return 'Please enter password';
			case 'welcomeScreen.welcomeHeader': return 'Welcome to ';
			case 'welcomeScreen.subtitle': return 'The strength you need';
			case 'welcomeScreen.signInButton': return 'Sign in';
			default: return null;
		}
	}
}

