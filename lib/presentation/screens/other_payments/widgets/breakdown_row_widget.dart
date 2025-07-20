import 'package:flutter/material.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';

class BreakdownRowWidget extends StatelessWidget {
  final String label;
  final String amount;
  final bool showDivider;

  const BreakdownRowWidget({
    super.key,
    required this.label,
    required this.amount,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    final parts = amount.split(' ');
    final numericPart = parts[0];
    final currencySymbol = parts.length > 1 ? parts[1] : '';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: ColorConstants.grayDark,
                fontFamily: AppTextStyles.fontFamily,
                letterSpacing: 0.1,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: numericPart,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.black,
                      letterSpacing: 0.1,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  if (currencySymbol.isNotEmpty)
                    TextSpan(
                      text: ' $currencySymbol',
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorConstants.grayMedium,
                        letterSpacing: 0.1,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          SizedBox(height: 12),
          Divider(height: 1, thickness: 1, color: ColorConstants.grayLight),
          SizedBox(height: 12),
        ],
      ],
    );
  }
}
