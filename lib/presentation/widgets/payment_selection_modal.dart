import 'package:flutter/material.dart';
import 'package:omedia_payment_app/presentation/screens/gold_payments/widgets/payment_selection_bottom_sheet.dart';

class PaymentSelectionModal {
  static void show({
    required BuildContext context,
    required dynamic upcomingPayment,
    List<dynamic>? loans,
    required Function(dynamic selectedItem) onPaymentSelected,
    bool isGoldPayment = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => GoldPaymentSelectionBottomSheet(
            upcomingPayment: upcomingPayment,
            loans: loans,
            isGoldPayment: isGoldPayment,
            onPaymentSelected: onPaymentSelected,
          ),
    );
  }
}
