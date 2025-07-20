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

class ObligationSummary extends StatefulWidget {
  const ObligationSummary({super.key});

  @override
  State<ObligationSummary> createState() => _ObligationSummaryState();
}

class _ObligationSummaryState extends State<ObligationSummary> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObligationGoldBloc, ObligationGoldState>(
      builder: (context, goldState) {
        return BlocBuilder<ObligationOtherBloc, ObligationOtherState>(
          builder: (context, otherState) {
            dynamic issueAmount = 'Loading...';

            if (goldState is ObligationGoldLoaded &&
                otherState is ObligationOtherLoaded) {
              issueAmount =
                  goldState.totalGoldIssueAmount +
                  otherState.totalOtherIssueAmount;
              issueAmount = issueAmount.toStringAsFixed(2);
            } else if (goldState is ObligationGoldLoading) {
              issueAmount = "Loading...";
            } else if (goldState is ObligationGoldError) {
              issueAmount = "Loading...";
            } else {
              issueAmount = "Loading...";
            }

            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorConstants.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FormatterWidget.toGeorgianUppercase('ჩემი ვალდებულებები'),
                      style: TextStyle(
                        color: ColorConstants.grayDark,
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: 16,
                        letterSpacing: 0.1,
                      ),
                    ),
                    SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '${FormatterWidget.formatNumberWithCommas(issueAmount)}',
                            style: TextStyle(
                              fontSize: 20,
                              color: ColorConstants.black,
                              letterSpacing: 0.1,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                          ),
                          TextSpan(
                            text:
                                !(goldState is ObligationGoldLoaded &&
                                        otherState is ObligationOtherLoaded)
                                    ? ''
                                    : ' ₾',
                            style: TextStyle(
                              color: ColorConstants.grayMedium,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
