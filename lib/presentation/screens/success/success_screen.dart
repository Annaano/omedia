import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/presentation/widgets/custom_app_bar.dart';
import 'package:omedia_payment_app/presentation/widgets/custom_button.dart';
import 'package:omedia_payment_app/routes/app_router.dart';

class SuccessScreen extends StatefulWidget {
  final Upcoming? upcomingPayment;
  final List<Loan>? loans;
  final bool isGoldPayment;
  const SuccessScreen({
    super.key,
    this.upcomingPayment,
    this.loans,
    this.isGoldPayment = false,
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: ColorConstants.grayLight,
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
          text: FormatterWidget.toGeorgianUppercase('დახურვა'),
          onPressed: () {
            AppRouter.navigateToDashboard(context);
          },
        ),
      ),
      backgroundColor: ColorConstants.white,
      appBar: CustomAppBar(
        title: FormatterWidget.toGeorgianUppercase('დავალიანების გადახდა'),
        subtitle: 'მთავარი',
        showBackButton: false,
        endIconPath: Icon(Icons.close),
        onEndIconPressed: () {
          AppRouter.navigateToDashboard(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConstants.successLight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 20,
                  ),
                  child: SvgPicture.asset('assets/icons/ic_check.svg'),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  FormatterWidget.toGeorgianUppercase('გადახდა შესრულებულია'),
                  style: TextStyle(
                    color: ColorConstants.black,
                    fontSize: 16,
                    fontFamily: AppTextStyles.fontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                    height: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 16,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.1,
                        height: 2,
                      ),
                      children: [
                        TextSpan(
                          text: 'შენ წარმატებით გადაიხადე ',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: AppTextStyles.fontFamily,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.grayDark,
                            letterSpacing: 0.1,
                            height: 2,
                          ),
                        ),

                        TextSpan(
                          text:
                              '${FormatterWidget.formatNumberWithCommas(widget.upcomingPayment?.paymentAmount) ?? '0.00 '} ₾ ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            letterSpacing: 0.1,
                            color: ColorConstants.black,
                          ),
                        ),
                        if (widget.isGoldPayment)
                          TextSpan(
                            text: ' ოქროს ლომბარდის სესხზე ',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.grayDark,
                              letterSpacing: 0.1,
                            ),
                          ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
