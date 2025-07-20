import 'package:flutter/material.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/presentation/screens/gold_payments/widgets/payment_break_down_card.dart';
import 'package:omedia_payment_app/presentation/widgets/custom_app_bar.dart';
import 'package:omedia_payment_app/presentation/widgets/payment_info_card.dart';
import 'package:omedia_payment_app/presentation/widgets/custom_button.dart';
import 'package:omedia_payment_app/presentation/widgets/payment_breakdown_bottom_sheet.dart';

class GoldPaymentDetailScreen extends StatefulWidget {
  final Upcoming upcomingPayment;
  final List<Loan>? loans;

  const GoldPaymentDetailScreen({
    super.key,
    required this.upcomingPayment,
    this.loans,
  });

  @override
  State<GoldPaymentDetailScreen> createState() =>
      _GoldPaymentDetailScreenState();
}

class _GoldPaymentDetailScreenState extends State<GoldPaymentDetailScreen> {
  Set<int> expandedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grayLight,
      appBar: CustomAppBar(
        title: FormatterWidget.toGeorgianUppercase('დავალიანების გადახდა'),
        subtitle: 'მთავარი',
        showBackButton: true,
      ),
      bottomNavigationBar: Container(
        color: ColorConstants.grayLight,
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
          text: FormatterWidget.toGeorgianUppercase('შემდეგი'),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder:
                  (context) => PaymentBreakdownBottomSheet(
                    upcomingPayment: widget.upcomingPayment,
                    loans: widget.loans,
                    isGoldPayment: true,
                  ),
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentInfoCard(
            title: 'ოქროს ლომბარდი',
            iconPath: 'assets/icons/ic_gold_obligations.svg',

            upcomingPayment: widget.upcomingPayment,
            loans: widget.loans,
            iconPaddingHorizontal: 4.0,
            isGoldPayment: true,
          ),
          Expanded(
            child: PaymentBreakdownCard(
              upcomingPayment: widget.upcomingPayment,
              loans: widget.loans,
            ),
          ),
        ],
      ),
    );
  }
}
