import 'package:flutter/material.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/presentation/widgets/payment_breakdown_bottom_sheet.dart';

class PaymentModalBottomSheet {
  static void show({
    required BuildContext context,
    required Upcoming upcomingPayment,
    List<Loan>? loans,
    Function(Upcoming selectedPayment, String title, String iconPath)?
    onPaymentSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => PaymentBreakdownBottomSheet(
            upcomingPayment: upcomingPayment,
            loans: loans,
            onPaymentSelected: onPaymentSelected,
            isGoldPayment: false,
          ),
    );
  }
}
