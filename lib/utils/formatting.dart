import 'package:evo/i18n/translations.g.dart';
import 'package:intl/intl.dart';

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
