import 'package:decimal/decimal.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:evo/common/id.dart';
import 'package:evo/common/pick.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_details.freezed.dart';

@freezed
class InvoiceDetails with _$InvoiceDetails {
  const InvoiceDetails._();

  const factory InvoiceDetails({
    required InvoiceId id,
    required int number,
    required Decimal amount,
    required String currency,
    required InvoiceStatus status,
    required DateTime date,
    required DateTime from,
    required DateTime to,
  }) = _InvoiceDetails;

  factory InvoiceDetails.fromServerJson(Map<String, dynamic> json) =>
      InvoiceDetails.fromPick(pick(json).required());

  factory InvoiceDetails.fromPick(RequiredPick pick) {
    return InvoiceDetails(
      id: pick('id').asInvoiceIdOrThrow(),
      date: pick('date').asDateOrThrow(),
      number: pick('invoice_number').asIntOrThrow(),
      amount: pick('amount').asDecimalOrThrow(),
      currency: pick('currency').asStringOrThrow(),
      status: InvoiceStatusExtensions.fromString(
        pick('status').asStringOrThrow(),
      ),
      from: pick('from').asDateOrThrow(),
      to: pick('to').asDateOrThrow(),
    );
  }
}

@freezed
class SlimInvoiceDetails with _$SlimInvoiceDetails {
  const SlimInvoiceDetails._();

  const factory SlimInvoiceDetails({
    required Decimal amount,
    required DateTime date,
  }) = _SlimInvoiceDetails;

  factory SlimInvoiceDetails.fromServerJson(Map<String, dynamic> json) =>
      SlimInvoiceDetails.fromPick(pick(json).required());

  factory SlimInvoiceDetails.fromPick(RequiredPick pick) {
    return SlimInvoiceDetails(
      date: pick('date').asDateOrThrow(),
      amount: pick('amount').asDecimalOrThrow(),
    );
  }
}

enum InvoiceStatus {
  charged,
  unknown,
}

extension InvoiceStatusExtensions on InvoiceStatus {
  static InvoiceStatus fromString(String status) {
    return InvoiceStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == status.toLowerCase(),
      orElse: () => InvoiceStatus.unknown,
    );
  }

  static String translated(InvoiceStatus status, BuildContext context) {
    return switch (status) {
      InvoiceStatus.charged => context.t.invoiceStatuses.charged,
      InvoiceStatus.unknown => context.t.invoiceStatuses.unknown,
    };
  }
}
