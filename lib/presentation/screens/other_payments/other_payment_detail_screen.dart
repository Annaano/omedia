import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/presentation/screens/other_payments/widgets/expandable_payment_tile.dart';
import 'package:omedia_payment_app/presentation/widgets/custom_app_bar.dart';
import 'package:omedia_payment_app/presentation/widgets/payment_selection_modal.dart';
import 'package:omedia_payment_app/presentation/screens/other_payments/widgets/other_payment_modal_bottom_sheet.dart';
import 'package:omedia_payment_app/presentation/widgets/custom_button.dart';
import 'package:omedia_payment_app/presentation/widgets/upcoming_payment_tile.dart';
import 'package:omedia_payment_app/presentation/screens/other_payments/widgets/breakdown_row_widget.dart';
import 'package:omedia_payment_app/presentation/widgets/payment_info_card.dart';

class OtherPaymentDetailScreen extends StatefulWidget {
  final Upcoming upcomingPayment;
  final List<Loan>? loans;

  const OtherPaymentDetailScreen({
    super.key,
    required this.upcomingPayment,
    this.loans,
  });

  @override
  State<OtherPaymentDetailScreen> createState() =>
      _OtherPaymentDetailScreenState();
}

class _OtherPaymentDetailScreenState extends State<OtherPaymentDetailScreen> {
  Set<int> expandedItems = {};
  Upcoming? selectedPayment;
  String selectedTitle = 'სხვა სესხები';
  String selectedIconPath = 'assets/icons/ic_other_obligations.svg';

  void _showPaymentSelectionBottomSheet() {
    PaymentModalBottomSheet.show(
      context: context,
      upcomingPayment: selectedPayment ?? widget.upcomingPayment,
      loans: widget.loans,
      onPaymentSelected: (selectedPayment, title, iconPath) {
        setState(() {
          this.selectedPayment = selectedPayment;
          this.selectedTitle = title;
          this.selectedIconPath = iconPath;
        });
      },
    );
  }

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
            _showPaymentSelectionBottomSheet();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentInfoCard(
              iconPath: selectedIconPath,
              title: selectedTitle,
              upcomingPayment: selectedPayment ?? widget.upcomingPayment,
              loans: widget.loans,
            ),
            ExpandablePaymentTile(
              upcomingPayment: selectedPayment ?? widget.upcomingPayment,
              loans: widget.loans,
            ),
          ],
        ),
      ),
    );
  }
}
