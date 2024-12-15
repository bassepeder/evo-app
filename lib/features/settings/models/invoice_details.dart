import 'package:decimal/decimal.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:evo/common/id.dart';
import 'package:evo/common/pick.dart';
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
    required String status,
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
      number: pick('number').asIntOrThrow(),
      amount: pick('id').asDecimalOrThrow(),
      currency: pick('currency').asStringOrThrow(),
      status: pick('id').asStringOrThrow(),
      from: pick('from').asDateOrThrow(),
      to: pick('to').asDateOrThrow(),
    );
  }
}
