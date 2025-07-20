import 'package:flutter/material.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/presentation/screens/other_payments/widgets/breakdown_row_widget.dart';
import 'package:omedia_payment_app/presentation/widgets/upcoming_payment_tile.dart';

class ExpandablePaymentTile extends StatefulWidget {
  final Upcoming upcomingPayment;
  final List<Loan>? loans;

  const ExpandablePaymentTile({
    super.key,
    required this.upcomingPayment,
    this.loans,
  });

  @override
  State<ExpandablePaymentTile> createState() => _ExpandablePaymentTileState();
}

class _ExpandablePaymentTileState extends State<ExpandablePaymentTile> {
  final Set<int> expandedItems = <int>{};

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...widget.upcomingPayment.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              String description = 'სხვა სესხები';
              if (widget.loans != null && widget.loans!.isNotEmpty) {
                final loanIndex = index % widget.loans!.length;
                description = widget.loans![loanIndex].description;
              }

              BorderRadius? containerBorderRadius;
              if (index == 0) {
                containerBorderRadius = null;
              } else if (index == widget.upcomingPayment.items.length - 1) {
                containerBorderRadius = BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                );
              }

              return Column(
                children: [
                  UpcomingPaymentTile(
                    title: description,
                    iconPath:
                        description == 'ავტო სესხი'
                            ? 'assets/icons/ic_car.svg'
                            : 'assets/icons/ic_other_obligations.svg',
                    iconPaddingHorizontal: 8.5,
                    iconPaddingVertical: 2.5,
                    containerColor: ColorConstants.white,
                    containerBorderRadius: containerBorderRadius,
                    iconContainerColor: ColorConstants.primaryLight,
                    amount: FormatterWidget.formatNumberWithCommas(
                      item.paymentAmount,
                    ),
                    remainingDaysText:
                        FormatterWidget.convertDateFormatWithZeroPad(
                          widget.upcomingPayment.paymentDate,
                        ),
                    endIconPath:
                        expandedItems.contains(index)
                            ? 'assets/icons/ic_arrow_up.svg'
                            : 'assets/icons/ic_arrow_down.svg',
                    endIconColor:
                        !expandedItems.contains(index)
                            ? ColorConstants.grayMedium
                            : ColorConstants.primary,
                    onTap: () {
                      setState(() {
                        if (expandedItems.contains(index)) {
                          expandedItems.remove(index);
                        } else {
                          expandedItems.add(index);
                        }
                      });
                    },
                  ),
                  if (expandedItems.contains(index))
                    Container(
                      color: ColorConstants.grayVeryLight,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          BreakdownRowWidget(
                            label: 'ძირი:',
                            amount:
                                '${FormatterWidget.formatNumberWithCommas(item.principalAmount)} ₾',
                          ),
                          SizedBox(height: 8),
                          BreakdownRowWidget(
                            label: 'პროცენტი:',
                            amount:
                                '${FormatterWidget.formatNumberWithCommas(item.percentageAmount)} ₾',
                          ),
                          if (item.fineAmount > 0) ...[
                            SizedBox(height: 8),
                            BreakdownRowWidget(
                              label: 'ჯარიმა:',
                              amount:
                                  '${FormatterWidget.formatNumberWithCommas(item.fineAmount)} ₾',
                            ),
                          ],
                        ],
                      ),
                    ),
                  if (index < widget.upcomingPayment.items.length - 1)
                    !expandedItems.contains(index)
                        ? Divider(
                          height: 1,
                          thickness: 1,
                          color: ColorConstants.grayLight,
                          indent: 16,
                          endIndent: 16,
                        )
                        : SizedBox.shrink(),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
