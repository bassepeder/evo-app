import 'package:deep_pick/deep_pick.dart';
import 'package:evo/common/id.dart';
import 'package:evo/common/pick.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'membership_details.freezed.dart';
part 'membership_details.g.dart';

@freezed
class MembershipDetails with _$MembershipDetails {
  const MembershipDetails._();

  const factory MembershipDetails({
    required MembershipSummary membershipDetails,
    required Profile profile,
    required List<KeyInfo> keys,
    required Product product,
    required MembershipLocation location,
    required String referralCode,
    required String locale,
    required bool gdprConsentGiven,
    required PaymentMethod currentPaymentMethod,
  }) = _MembershipDetails;

  factory MembershipDetails.fromServerJson(Map<String, dynamic> json) =>
      MembershipDetails.fromPick(pick(json).required());

  factory MembershipDetails.fromPick(RequiredPick pick) {
    return MembershipDetails(
      membershipDetails: MembershipSummary(
        id: pick('membership_details', 'id').asMembershipIdOrThrow(),
        number: pick('membership_details', 'number').asIntOrThrow(),
        status: MembershipStatusExtensions.fromString(
          pick('membership_details', 'status').asStringOrThrow(),
        ),
        createdAt: pick('membership_details', 'created_at').asDateTimeOrThrow(),
        beganAt: pick('membership_details', 'began_at').asDateOrThrow(),
        endsAt: pick('membership_details', 'ends_at').asDateOrNull(),
        freezes: pick('membership_details', 'freezes').asListOrEmpty(
          (freezePick) => FreezePeriod.fromPick(
            freezePick.required(),
          ),
        ),
      ),
      profile: Profile.fromPick(pick('profile').required()),
      keys: pick('keys').asListOrEmpty(
        (pick) => KeyInfo.fromPick(
          pick.required(),
        ),
      ),
      product: Product.fromPick(pick('product').required()),
      location: MembershipLocation.fromPick(pick('location').required()),
      referralCode: pick('referral_code').asStringOrThrow(),
      locale: pick('locale').asStringOrThrow(),
      gdprConsentGiven: pick('gdpr_consent_given').asBoolOrThrow(),
      currentPaymentMethod: PaymentMethod.fromPick(
        pick('current_payment_method').required(),
      ),
    );
  }
}

@freezed
class MembershipSummary with _$MembershipSummary {
  const factory MembershipSummary({
    required MembershipId id,
    required int number,
    required MembershipStatus status,
    required DateTime createdAt,
    required DateTime beganAt,
    required DateTime? endsAt,
    required List<dynamic> freezes,
  }) = _MembershipSummary;

  factory MembershipSummary.fromJson(Map<String, dynamic> json) =>
      _$MembershipSummaryFromJson(json);
}

@freezed
class FreezePeriod with _$FreezePeriod {
  const FreezePeriod._(); // Private constructor for Freezed

  const factory FreezePeriod({
    required String id,
    required DateTime beginDate,
    required DateTime endDate,
    DateTime? cancelDate,
  }) = _FreezePeriod;

  factory FreezePeriod.fromPick(RequiredPick pick) {
    return FreezePeriod(
      id: pick('id').asStringOrThrow(),
      beginDate: pick('begin_date').asDateOrThrow(),
      endDate: pick('end_date').asDateOrThrow(),
      cancelDate: pick('cancel_date').asDateOrNull(),
    );
  }
}

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String name,
    required String firstName,
    required String lastName,
    required String email,
    required Address address,
    required Mobile mobile,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  factory Profile.fromPick(RequiredPick pick) {
    return Profile(
      name: pick('name').asStringOrThrow(),
      firstName: pick('first_name').asStringOrThrow(),
      lastName: pick('last_name').asStringOrThrow(),
      email: pick('email').asStringOrThrow(),
      address: Address.fromPick(pick('address').required()),
      mobile: Mobile.fromPick(pick('mobile').required()),
    );
  }
}

@freezed
class Address with _$Address {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Address({
    required String street,
    required String postalCode,
    required String postalLocation,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  factory Address.fromPick(RequiredPick pick) {
    return Address(
      street: pick('street').asStringOrThrow(),
      postalCode: pick('postal_code').asStringOrThrow(),
      postalLocation: pick('postal_location').asStringOrThrow(),
    );
  }
}

@freezed
class Mobile with _$Mobile {
  const factory Mobile({
    required String number,
    required String prefix,
  }) = _Mobile;

  const Mobile._();

  String get internationalNumber => '$prefix$number';

  factory Mobile.fromJson(Map<String, dynamic> json) => _$MobileFromJson(json);

  factory Mobile.fromPick(RequiredPick pick) {
    return Mobile(
      number: pick('number').asStringOrThrow(),
      prefix: pick('prefix').asStringOrThrow(),
    );
  }
}

enum KeyType {
  rfid,
  pinCode,
  unknown;
}

enum KeyStatus {
  active,
  inactive,
  unknown;
}

KeyType parseKeyType(String type) {
  switch (type) {
    case 'Rfid':
      return KeyType.rfid;
    case 'PinCode':
      return KeyType.pinCode;
    default:
      return KeyType.unknown;
  }
}

KeyStatus parseKeyStatus(String status) {
  switch (status) {
    case 'Active':
      return KeyStatus.active;
    case 'Inactive':
      return KeyStatus.inactive;
    default:
      return KeyStatus.unknown;
  }
}

@freezed
class KeyInfo with _$KeyInfo {
  const factory KeyInfo({
    required String id,
    required String code,
    required KeyType type,
    required KeyStatus status,
    required DateTime createdAt,
    required DateTime validFrom,
    DateTime? validTo,
  }) = _KeyInfo;

  factory KeyInfo.fromJson(Map<String, dynamic> json) =>
      _$KeyInfoFromJson(json);

  factory KeyInfo.fromPick(RequiredPick pick) {
    return KeyInfo(
      id: pick('id').asStringOrThrow(),
      code: pick('code').asStringOrThrow(),
      type: parseKeyType(pick('type').asStringOrThrow()),
      status: parseKeyStatus(pick('status').asStringOrThrow()),
      createdAt: pick('created_at').asDateTimeOrThrow(),
      validFrom: pick('valid_from').asDateOrThrow(),
      validTo: pick('valid_to').asDateOrNull(),
    );
  }
}

@freezed
class Product with _$Product {
  const factory Product({
    required String postSignupPresentation,
    required bool requiresPhoneVerification,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  factory Product.fromPick(RequiredPick pick) {
    return Product(
      postSignupPresentation:
          pick('post_signup_presentation').asStringOrThrow(),
      requiresPhoneVerification:
          pick('requires_phone_verification').asBoolOrThrow(),
    );
  }
}

@freezed
class MembershipLocation with _$MembershipLocation {
  const factory MembershipLocation({
    required LocationId id,
    required String name,
  }) = _MembershipLocation;

  factory MembershipLocation.fromJson(Map<String, dynamic> json) =>
      _$MembershipLocationFromJson(json);

  factory MembershipLocation.fromPick(RequiredPick pick) {
    return MembershipLocation(
      id: pick('id').asLocationIdOrThrow(),
      name: pick('name').asStringOrThrow(),
    );
  }
}

@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required String id,
    required String brand,
    required String details,
    required int expiryYear,
    required int expiryMonth,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  factory PaymentMethod.fromPick(RequiredPick pick) {
    return PaymentMethod(
      id: pick('id').asStringOrThrow(),
      brand: pick('brand').asStringOrThrow(),
      details: pick('details').asStringOrThrow(),
      expiryYear: pick('expiry_year').asIntOrThrow(),
      expiryMonth: pick('expiry_month').asIntOrThrow(),
    );
  }
}

enum MembershipStatus {
  presale,
  inTrial,
  active,
  freezed,
  pendingCancellation,
  cancelled,
  cancelledInPresale,
  cancelledInTrial,
  stopped,
  unknown,
}

extension MembershipStatusExtensions on MembershipStatus {
  static MembershipStatus fromString(String status) {
    return MembershipStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == status.toLowerCase(),
      orElse: () => MembershipStatus.unknown,
    );
  }

  static String translated(MembershipStatus status, BuildContext context) {
    return switch (status) {
      MembershipStatus.presale => context.t.membershipStatuses.presale,
      MembershipStatus.inTrial => context.t.membershipStatuses.inTrial,
      MembershipStatus.active => context.t.membershipStatuses.active,
      MembershipStatus.freezed => context.t.membershipStatuses.freezed,
      MembershipStatus.pendingCancellation =>
        context.t.membershipStatuses.pendingCancellation,
      MembershipStatus.cancelled => context.t.membershipStatuses.cancelled,
      MembershipStatus.cancelledInPresale =>
        context.t.membershipStatuses.cancelledInPresale,
      MembershipStatus.cancelledInTrial =>
        context.t.membershipStatuses.cancelledInTrial,
      MembershipStatus.stopped => context.t.membershipStatuses.stopped,
      MembershipStatus.unknown => context.t.membershipStatuses.unknown,
    };
  }
}
