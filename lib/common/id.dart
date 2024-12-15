import 'package:deep_pick/deep_pick.dart';

extension type const StringId(String value) {
  StringId.fromJson(dynamic json) : this(json as String);

  String toJson() => value;

  int get length => value.length;

  bool startsWith(String prefix) => value.startsWith(prefix);
}

extension type const MembershipId(String value) implements StringId {
  MembershipId.fromJson(dynamic json) : this(json as String);
}

extension type const LocationId(String value) implements StringId {
  LocationId.fromJson(dynamic json) : this(json as String);
}

extension type const InvoiceId(String value) implements StringId {
  InvoiceId.fromJson(dynamic json) : this(json as String);
}

extension IDPick on Pick {
  MembershipId asMembershipIdOrThrow() {
    final value = required().value;
    if (value is String) {
      return MembershipId(value);
    }
    throw PickException(
      "Value $value at $debugParsingExit can't be casted to MembershipId",
    );
  }

  LocationId asLocationIdOrThrow() {
    final value = required().value;
    if (value is String) {
      return LocationId(value);
    }
    throw PickException(
      "Value $value at $debugParsingExit can't be casted to LocationId",
    );
  }

  InvoiceId asInvoiceIdOrThrow() {
    final value = required().value;
    if (value is String) {
      return InvoiceId(value);
    }
    throw PickException(
      "Value $value at $debugParsingExit can't be casted to InvoiceId",
    );
  }
}
