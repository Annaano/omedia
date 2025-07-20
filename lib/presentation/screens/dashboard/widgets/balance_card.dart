import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omedia_payment_app/core/constants/app_colors_constants.dart';
import 'package:omedia_payment_app/core/constants/app_text_styles.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:omedia_payment_app/logic/blocs/obligation_gold/obligation_gold_bloc.dart';
import 'package:omedia_payment_app/logic/blocs/obligation_other/obligation_other_bloc.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({super.key});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObligationOtherBloc, ObligationOtherState>(
      builder: (context, otherState) {
        dynamic transitBalance = 'Loading...';

        if (otherState is ObligationOtherLoaded) {
          transitBalance = otherState.obligation.transitBalance.toStringAsFixed(
            2,
          );
        } else {
          transitBalance = "Loading...";
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorConstants.grayVeryLight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ხელმისაწვდომი თანხა',
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: 13,
                        letterSpacing: 0.1,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorConstants.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, top: 6),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: FormatterWidget.formatNumberWithCommas(
                                    transitBalance,
                                  ),
                                  style: TextStyle(
                                    color: ColorConstants.black,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontSize: 14,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      !(otherState is ObligationOtherLoaded)
                                          ? ''
                                          : ' ₾',
                                  style: TextStyle(
                                    color: ColorConstants.grayMedium,
                                    fontSize: 14,
                                    fontFamily: AppTextStyles.fontFamily,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'ცნობილი ფაქტია, რომ გვერდის წაკითხვად შიგთავსს შეუძლია მკითხველის ყურადღება მიიზიდოს და დიზაინის აღქმაში ხელი შეუშალოს.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          fontSize: 11,
                          color: ColorConstants.grayDark,
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppTextStyles.fontFamily,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
