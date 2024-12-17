import 'package:deep_pick/deep_pick.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_membership_referral.freezed.dart';

@freezed
class CurrentMembershipReferral with _$CurrentMembershipReferral {
  const CurrentMembershipReferral._();

  const factory CurrentMembershipReferral({
    required String id,
    required String name,
    required String description,
    required int discountMonthsCount,
    required int discountPercentage,
    required int includedPtHoursAmount,
    required DateTime validFrom,
    required DateTime? validUntil,
  }) = _CurrentMembershipReferral;

  factory CurrentMembershipReferral.fromServerJson(Map<String, dynamic> json) =>
      CurrentMembershipReferral.fromPick(pick(json).required());

  factory CurrentMembershipReferral.fromPick(RequiredPick pick) {
    return CurrentMembershipReferral(
      id: pick('id').asStringOrThrow(),
      name: pick('name').asStringOrThrow(),
      description: pick('description').asStringOrThrow(),
      discountMonthsCount: pick('discount_months_count').asIntOrThrow(),
      discountPercentage: pick('discount_percentage').asIntOrThrow(),
      includedPtHoursAmount: pick('included_pt_hours_amount').asIntOrThrow(),
      validFrom: pick('valid_from').asDateTimeOrThrow(),
      validUntil: pick('valid_until').asDateTimeOrNull(),
    );
  }
}
