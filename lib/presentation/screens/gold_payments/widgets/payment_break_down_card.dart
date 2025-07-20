import 'package:flutter/material.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/presentation/screens/gold_payments/widgets/item_breakdown_widget.dart';
import 'package:omedia_payment_app/presentation/screens/other_payments/widgets/breakdown_row_widget.dart';

class PaymentBreakdownCard extends StatelessWidget {
  final Upcoming upcomingPayment;
  final List<Loan>? loans;

  const PaymentBreakdownCard({
    super.key,
    required this.upcomingPayment,
    this.loans,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BreakdownRowWidget(
              label: 'გადახდის თარიღი:',
              amount: FormatterWidget.convertDateFormatWithZeroPad(
                upcomingPayment.paymentDate,
              ),

              showDivider: true,
            ),

            BreakdownRowWidget(
              label: 'გადასახდელი თანხა:',
              amount: '${upcomingPayment.paymentAmount.toStringAsFixed(2)} ₾',
              showDivider: true,
            ),

            ...upcomingPayment.items
                .map((item) => ItemBreakdownWidget(item: item))
                .toList(),
          ],
        ),
      ),
    );
  }
}
