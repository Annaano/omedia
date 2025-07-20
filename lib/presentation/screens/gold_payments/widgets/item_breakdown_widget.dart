import 'package:flutter/material.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/presentation/screens/other_payments/widgets/breakdown_row_widget.dart';

class ItemBreakdownWidget extends StatelessWidget {
  final UpcomingItem item;

  const ItemBreakdownWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BreakdownRowWidget(
          label: 'ძირი:',
          amount:
              '${FormatterWidget.formatNumberWithCommas(item.principalAmount)} ₾',
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: BreakdownRowWidget(
            label: 'პროცენტი:',
            amount:
                '${FormatterWidget.formatNumberWithCommas(item.percentageAmount)} ₾',
          ),
        ),

        if (item.fineAmount > 0) ...[
          BreakdownRowWidget(
            label: 'ჯარიმა:',
            amount:
                '${FormatterWidget.formatNumberWithCommas(item.fineAmount)} ₾',
          ),
        ],
      ],
    );
  }
}
