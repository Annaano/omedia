import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/data/models/obligation_gold_model.dart';
import 'package:omedia_payment_app/presentation/widgets/custom_button.dart';
import 'package:omedia_payment_app/presentation/screens/gold_payments/widgets/payment_option_tile.dart';

class GoldPaymentSelectionBottomSheet extends StatefulWidget {
  final dynamic upcomingPayment;
  final List<dynamic>? loans;
  final Function(dynamic selectedItem) onPaymentSelected;
  final bool isGoldPayment;

  const GoldPaymentSelectionBottomSheet({
    super.key,
    required this.upcomingPayment,
    this.loans,
    required this.onPaymentSelected,
    this.isGoldPayment = false,
  });

  @override
  State<GoldPaymentSelectionBottomSheet> createState() =>
      _GoldPaymentSelectionBottomSheetState();
}

class _GoldPaymentSelectionBottomSheetState
    extends State<GoldPaymentSelectionBottomSheet> {
  int? selectedIndex;

  List<dynamic> get items {
    if (widget.isGoldPayment) {
      return widget.upcomingPayment.items ?? [];
    } else {
      return widget.upcomingPayment.items ?? [];
    }
  }

  String getItemDescription(int index) {
    return 'ოქროს ლომბარდი';
  }

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
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20.0),
            child: Row(
              children: [
                Text(
                  FormatterWidget.toGeorgianUppercase(
                    'აირჩიე რისი გადახდა გსურს',
                  ),
                  style: TextStyle(
                    color: ColorConstants.black,
                    fontSize: 16,
                    fontFamily: AppTextStyles.fontFamily,
                    fontWeight: FontWeight.w600,
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
          SizedBox(height: 20),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final description = getItemDescription(index);
                final isSelected = selectedIndex == index;

                return PaymentOptionTile(
                  index: index,
                  item: item,
                  description: description,
                  isSelected: isSelected,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),

          SizedBox(height: 20),
          Container(
            color: ColorConstants.grayLight,
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              text: FormatterWidget.toGeorgianUppercase('დავალიანების არჩევა'),
              onPressed:
                  selectedIndex != null
                      ? () {
                        Navigator.of(context).pop();
                        final selectedItem = items[selectedIndex!];
                        widget.onPaymentSelected(selectedItem);
                      }
                      : null,
              isDisabled: selectedIndex == null,
            ),
          ),
        ],
      ),
    );
  }
}
