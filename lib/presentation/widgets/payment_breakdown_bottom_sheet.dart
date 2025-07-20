import 'package:flutter/material.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/presentation/widgets/custom_button.dart';
import 'package:omedia_payment_app/routes/app_router.dart';

class PaymentBreakdownBottomSheet extends StatefulWidget {
  final Upcoming upcomingPayment;
  final List<Loan>? loans;
  final Function(Upcoming selectedPayment, String title, String iconPath)?
  onPaymentSelected;
  final bool isGoldPayment;

  const PaymentBreakdownBottomSheet({
    super.key,
    required this.upcomingPayment,
    this.loans,
    this.onPaymentSelected,
    this.isGoldPayment = false,
  });

  @override
  State<PaymentBreakdownBottomSheet> createState() =>
      _PaymentBreakdownBottomSheetState();
}

class _PaymentBreakdownBottomSheetState
    extends State<PaymentBreakdownBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20.0, top: 10),
            child: Row(
              children: [
                Text(
                  FormatterWidget.toGeorgianUppercase('გადახდა'),
                  style: TextStyle(
                    color: ColorConstants.black,
                    fontSize: 16,
                    fontFamily: AppTextStyles.fontFamily,

                    letterSpacing: 0.1,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    color: ColorConstants.grayDark,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Divider(),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Text(
              'გაითვალისწინე, რომ სესხების თანხები დაიფარება პრიორიტეტის შესაბამისად',
              style: TextStyle(
                color: ColorConstants.grayDark,
                fontSize: 12,
                fontFamily: AppTextStyles.fontFamily,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.1,
                height: 1.5,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.grayVeryLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstants.grayLight, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      FormatterWidget.formatNumberWithCommas(
                        widget.upcomingPayment.paymentAmount,
                      ),
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 16,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '₾',
                    style: TextStyle(
                      color: ColorConstants.grayDark,
                      fontSize: 16,
                      fontFamily: AppTextStyles.fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          Container(
            width: double.infinity,
            color: ColorConstants.grayLight,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: CustomButton(
              text: FormatterWidget.toGeorgianUppercase('გადახდა'),
              onPressed: () {
                Navigator.of(context).pop();

                AppRouter.navigateToSuccess(
                  context,
                  widget.upcomingPayment,
                  loans: widget.loans,
                  isGoldPayment: widget.isGoldPayment,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
