import 'package:flutter/material.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';

class PaymentOptionTile extends StatelessWidget {
  final int index;
  final dynamic item;
  final String description;
  final bool isSelected;
  final Function(int index) onTap;

  const PaymentOptionTile({
    super.key,
    required this.index,
    required this.item,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accountNumber = item.accountNumber ?? '';
    final paymentAmount = item.paymentAmount ?? 0.0;
    final remainingDays = item.remainingDays ?? 0;
    final expired = item.expired ?? false;
    final today = item.today ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.grayLight, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(index),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorConstants.primary, width: 2),
                  ),
                  child:
                      isSelected
                          ? Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.primary,
                              ),
                            ),
                          )
                          : null,
                ),

                SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: TextStyle(
                          color: ColorConstants.black,
                          fontSize: 14,
                          fontFamily: AppTextStyles.fontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.1,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        expired
                            ? 'გადაცილება ${remainingDays.toString()} დღე'
                            : today
                            ? 'გადახდა დღეს'
                            : 'გადახდა ${remainingDays.toString()} დღეში',
                        style: TextStyle(
                          color:
                              expired
                                  ? ColorConstants.error
                                  : ColorConstants.grayDark,
                          fontSize: 12,
                          fontFamily: AppTextStyles.fontFamily,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${FormatterWidget.formatNumberWithCommas(paymentAmount)} ₾',
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 16,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
