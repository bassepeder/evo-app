import 'package:deep_pick/deep_pick.dart';

extension PickDateParsing on Pick {
  /// Converts a string in "YYYY-MM-DD" format to a `DateTime` object.
  /// Throws an exception if the string is null or invalid.
  DateTime asDateOrThrow() {
    final dateString = asStringOrThrow();
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      throw PickException(
        'Expected a valid date in "YYYY-MM-DD" format, but got: $dateString',
      );
    }
  }

  /// Converts a string in "YYYY-MM-DD" format to a `DateTime` object.
  /// Returns null if the string is null or invalid.
  DateTime? asDateOrNull() {
    final dateString = asStringOrNull();
    if (dateString == null) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }
}
