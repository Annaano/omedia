import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';

class UpcomingPaymentTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final String amount;
  final String remainingDaysText;
  final bool showWarningIcon;
  final bool isExpired;
  final VoidCallback? onTap;
  final double iconPaddingHorizontal;
  final double iconPaddingVertical;
  final String? endIconPath;
  final BorderRadius? containerBorderRadius;
  final Color? iconContainerColor;
  final Color? containerColor;
  final Color? endIconColor;
  final String? paymentText;

  const UpcomingPaymentTile({
    super.key,
    required this.title,
    required this.iconPath,
    required this.amount,
    required this.remainingDaysText,
    this.showWarningIcon = false,
    this.isExpired = false,
    this.onTap,
    this.iconPaddingHorizontal = 10.5,
    this.iconPaddingVertical = 7.5,
    this.endIconPath,
    this.containerBorderRadius,
    this.iconContainerColor,
    this.containerColor,
    this.endIconColor,
    this.paymentText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: containerBorderRadius ?? BorderRadius.circular(12),
          color: containerColor ?? ColorConstants.grayVeryLight,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: iconContainerColor ?? ColorConstants.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: iconPaddingHorizontal,
                            vertical: iconPaddingVertical,
                          ),
                          child: SvgPicture.asset(iconPath),
                        ),
                      ),
                      if (showWarningIcon)
                        Positioned(
                          top: -6,
                          right: -6,
                          child: SvgPicture.asset(
                            'assets/icons/ic_warning_mark.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 12,
                          letterSpacing: 0.1,
                          color: ColorConstants.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  remainingDaysText == 'Loading...'
                                      ? 'Loading... '
                                      : (isExpired
                                          ? 'გადაცილება '
                                          : (paymentText ?? '')),
                              style: TextStyle(
                                fontFamily: AppTextStyles.fontFamily,
                                fontSize: 11,
                                letterSpacing: 0.1,
                                color:
                                    remainingDaysText == 'Loading...'
                                        ? ColorConstants.grayDark
                                        : (isExpired
                                            ? ColorConstants.error
                                            : ColorConstants.grayDark),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text:
                                  remainingDaysText == 'Loading...'
                                      ? ''
                                      : remainingDaysText,
                              style: TextStyle(
                                fontFamily: AppTextStyles.fontFamily,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.1,
                                color:
                                    remainingDaysText == 'Loading...'
                                        ? ColorConstants.grayDark
                                        : (isExpired
                                            ? ColorConstants.error
                                            : ColorConstants.grayDark),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: amount,
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 14,
                            letterSpacing: 0.1,
                            color: ColorConstants.black,
                          ),
                        ),
                        TextSpan(
                          text: amount == 'Loading...' ? '' : ' ₾',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.1,
                            color: ColorConstants.grayMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (endIconPath != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12,
                        bottom: 1,
                      ),
                      child: SvgPicture.asset(
                        endIconPath!,
                        color: endIconColor ?? ColorConstants.grayDark,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
