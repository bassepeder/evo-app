import 'package:evo/features/settings/models/invoice_details.dart';
import 'package:evo/network/http.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invoice_repository.g.dart';

@riverpod
Future<IList<InvoiceDetails>> invoices(Ref ref) async {
  return ref.withClientCacheFor(
    (client) => InvoiceRepository(client).getInvoices(),
    const Duration(
      hours: 1,
    ),
  );
}

@riverpod
Future<SlimInvoiceDetails> nextInvoice(Ref ref) async {
  return ref.withClientCacheFor(
    (client) => InvoiceRepository(client).getNextInvoice(),
    const Duration(
      hours: 1,
    ),
  );
}

class InvoiceRepository {
  InvoiceRepository(this.client);

  final EvoClient client;

  Future<IList<InvoiceDetails>> getInvoices() {
    return client.readJsonList(
      evoUri('api/v1/invoices'),
      mapper: InvoiceDetails.fromServerJson,
    );
  }

  Future<SlimInvoiceDetails> getNextInvoice() {
    return client.readJson(
      evoUri('api/v1/invoices/next'),
      mapper: SlimInvoiceDetails.fromServerJson,
    );
  }
}
