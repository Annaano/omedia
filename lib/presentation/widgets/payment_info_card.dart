import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/presentation/widgets/upcoming_payment_tile.dart';

class PaymentInfoCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final Upcoming upcomingPayment;
  final List<Loan>? loans;
  final String contactNumber;
  final double iconPaddingHorizontal;
  final double iconPaddingVertical;
  final bool isGoldPayment;

  const PaymentInfoCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.upcomingPayment,
    this.loans,
    this.contactNumber = '2 300 300',
    this.iconPaddingHorizontal = 8.5,
    this.iconPaddingVertical = 2.5,
    this.isGoldPayment = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayTitle = isGoldPayment ? 'ოქროს ლომბარდი' : title;
    final displayIconPath =
        isGoldPayment ? 'assets/icons/ic_gold_obligations.svg' : iconPath;

    final isExpired = isGoldPayment && upcomingPayment.expired;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorConstants.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FormatterWidget.toGeorgianUppercase('სანამ გადაიხდი'),
                        style: TextStyle(
                          color: ColorConstants.black,
                          fontSize: 16,
                          letterSpacing: 0.1,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                      Text(
                        'გაეცანი და დაეთანხმე, როგორ გადანაწილდება შენ მიერ გადახდილი თანხა',
                        style: TextStyle(
                          color: ColorConstants.grayDark,
                          fontSize: 13,
                          letterSpacing: 0.2,
                          fontFamily: AppTextStyles.fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                UpcomingPaymentTile(
                  title: displayTitle,
                  paymentText: isExpired ? 'გადაცილება: ' : 'ბოლო ვადა: ',
                  iconPath: displayIconPath,
                  iconPaddingHorizontal: iconPaddingHorizontal,
                  iconPaddingVertical: iconPaddingVertical,
                  containerBorderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  iconContainerColor: ColorConstants.primaryLight,
                  amount: FormatterWidget.formatNumberWithCommas(
                    upcomingPayment.paymentAmount,
                  ),
                  remainingDaysText:
                      upcomingPayment.remainingDays == 0
                          ? 'დღეს'
                          : isExpired
                          ? "${upcomingPayment.remainingDays.toString()} დღე"
                          : "${upcomingPayment.remainingDays.toString()} დღეში",
                  isExpired: isExpired,
                  showWarningIcon: isExpired,
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            bottom: 16,
            left: 20,
            right: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                offset: Offset(0, 2),
                child: SvgPicture.asset('assets/icons/ic_warning.svg'),
              ),
              SizedBox(width: 8),
              Expanded(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'ბალანსით სესხის წინსწრებით დასაფარად, დაგვირეკე კონტაქტ ცენტრში: ',
                        style: TextStyle(
                          color: ColorConstants.grayDark,
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 12,
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.w700,
                          height: 1.7,
                        ),
                      ),
                      TextSpan(
                        text: contactNumber,
                        style: TextStyle(
                          color: ColorConstants.primaryDark,
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 12,
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.w700,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
