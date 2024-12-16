import 'package:evo/common/widgets/error_screen.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/features/settings/invoice_repository.dart';
import 'package:evo/features/settings/models/invoice_details.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/formatting.dart';
import 'package:evo/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class PaymentInformationScreen extends ConsumerWidget {
  const PaymentInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.read(membershipDetailsProvider).requireValue!;
    final invoicesAsync = ref.watch(invoicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.paymentScreen.appbar),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Header(title: context.t.paymentScreen.paymentCardHeader),
              const SizedBox(height: 8),
              PaymentCardDetails(
                cardNumber: membership.currentPaymentMethod.details,
                brand: membership.currentPaymentMethod.brand,
              ),
              const SizedBox(height: 48),
              Header(title: context.t.paymentScreen.previousPaymentsHeader),
              const SizedBox(height: 8),
              invoicesAsync.when(
                data: (invoices) {
                  return Column(
                    children: invoices
                        .asMap()
                        .map((index, invoice) {
                          return MapEntry(
                            index,
                            FadeInPaymentCard(invoice: invoice, index: index),
                          );
                        })
                        .values
                        .toList(),
                  );
                },
                loading: () {
                  return const Padding(
                    padding: EdgeInsets.only(left: 4, top: 8),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                error: (error, stack) {
                  return Expanded(
                    child: ErrorScreen(
                      subtitle: context.t.errors.failedToLoadInvoices,
                      onRetryClicked: () => ref.invalidate(invoicesProvider),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FadeInPaymentCard extends StatefulWidget {
  final InvoiceDetails invoice;
  final int index;

  const FadeInPaymentCard({
    super.key,
    required this.invoice,
    required this.index,
  });

  @override
  _FadeInPaymentCardState createState() => _FadeInPaymentCardState();
}

class _FadeInPaymentCardState extends State<FadeInPaymentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Delay each card's animation slightly for a staggered effect
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: PreviousPaymentCard(invoice: widget.invoice),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PreviousPaymentCard extends ConsumerWidget {
  final InvoiceDetails invoice;

  const PreviousPaymentCard({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipLocale =
        ref.read(membershipDetailsProvider).requireValue!.locale;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  style: const TextStyle(fontSize: 16),
                  TextSpan(
                    children: [
                      TextSpan(
                        text: formatDate(context, invoice.date),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const TextSpan(text: ' - '),
                      TextSpan(
                        text: formatDate(context, invoice.to),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatCurrencyToProfileLocale(
                        invoice.amount.toDouble(),
                        membershipLocale,
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () async {
                await tryOpenUrlWithFeedback(
                  'https://me.evofitness.no/invoice/${invoice.id}',
                  context,
                );
              },
              icon: const Icon(Icons.picture_as_pdf_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentCardDetails extends StatelessWidget {
  final String cardNumber;
  final String brand;

  const PaymentCardDetails({
    super.key,
    required this.cardNumber,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          cardNumber,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 8),
        if (brand == 'VISA') ...[
          SvgPicture.string(
            visaCardSvg,
            width: 24,
            height: 24,
          ),
        ],
      ],
    );
  }
}

class Header extends StatelessWidget {
  final String title;

  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

const visaCardSvg = '''
<svg viewBox="0 -140 780 780" xmlns="http://www.w3.org/2000/svg"><rect width="780" height="500" fill="#0E4595"/><path d="m293.2 348.73l33.361-195.76h53.36l-33.385 195.76h-53.336zm246.11-191.54c-10.57-3.966-27.137-8.222-47.822-8.222-52.725 0-89.865 26.55-90.18 64.603-0.299 28.13 26.514 43.822 46.752 53.186 20.771 9.595 27.752 15.714 27.654 24.283-0.131 13.121-16.586 19.116-31.922 19.116-21.357 0-32.703-2.967-50.227-10.276l-6.876-3.11-7.489 43.823c12.463 5.464 35.51 10.198 59.438 10.443 56.09 0 92.5-26.246 92.916-66.882 0.199-22.269-14.016-39.216-44.801-53.188-18.65-9.055-30.072-15.099-29.951-24.268 0-8.137 9.668-16.839 30.557-16.839 17.449-0.27 30.09 3.535 39.938 7.5l4.781 2.26 7.232-42.429m137.31-4.223h-41.232c-12.773 0-22.332 3.487-27.941 16.234l-79.244 179.4h56.031s9.16-24.123 11.232-29.418c6.125 0 60.555 0.084 68.338 0.084 1.596 6.853 6.49 29.334 6.49 29.334h49.514l-43.188-195.64zm-65.418 126.41c4.412-11.279 21.26-54.723 21.26-54.723-0.316 0.522 4.379-11.334 7.074-18.684l3.605 16.879s10.219 46.729 12.354 56.528h-44.293zm-363.3-126.41l-52.24 133.5-5.567-27.13c-9.725-31.273-40.025-65.155-73.898-82.118l47.766 171.2 56.456-0.064 84.004-195.39h-56.521" fill="#ffffff"/><path d="m146.92 152.96h-86.041l-0.681 4.073c66.938 16.204 111.23 55.363 129.62 102.41l-18.71-89.96c-3.23-12.395-12.597-16.094-24.186-16.527" fill="#F2AE14"/></svg>
 ''';
