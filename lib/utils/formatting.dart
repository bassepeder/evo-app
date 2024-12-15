import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Formats a [DateTime] object into a localized string.
///
/// - If the date is today, yesterday, or tomorrow, it returns a localized
///   string like "Today", "Yesterday", or "Tomorrow" using the `slang` library.
/// - If the date is within the current year, it formats as "MMMM d" (e.g., "December 3").
/// - For dates in a different year, it formats as "MMMM d, y" (e.g., "December 3, 2023").
///
/// The formatting is localized based on the provided [locale] or the current
/// locale from `slang`.
///
/// Parameters:
/// - [dateTime]: The date to be formatted.
/// - [locale]: Optional. The locale to use for formatting. Defaults to the
///   current locale from `slang`.
///
/// Returns:
/// - A localized string representation of the date.
String formatDateTime(DateTime dateTime, {String? locale}) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  final difference = targetDate.difference(today).inDays;

  if (difference == 0) {
    return t.format.today;
  } else if (difference == -1) {
    return t.format.yesterday;
  } else if (difference == 1) {
    return t.format.tomorrow;
  }

  final isSameYear = dateTime.year == now.year;
  final dateFormat = DateFormat(
    isSameYear ? 'MMMM d' : 'MMMM d, y',
    locale ?? t.$meta.locale.languageCode,
  );

  return dateFormat.format(dateTime);
}

String formatDate(BuildContext context, DateTime dateTime) {
  final locale = TranslationProvider.of(context).flutterLocale;

  if (locale.languageCode == 'en') {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  } else {
    return DateFormat('dd.MM.yyyy', locale.languageCode).format(dateTime);
  }
}

String formatCurrencyToProfileLocale(double amount, String locale) {
  final formatter = NumberFormat.currency(
    locale: locale,
  );

  return formatter.format(amount);
}
