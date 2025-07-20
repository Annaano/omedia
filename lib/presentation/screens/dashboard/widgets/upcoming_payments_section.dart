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
import 'package:omedia_payment_app/logic/blocs/pdf/pdf_bloc.dart';
import 'package:omedia_payment_app/presentation/screens/gold_payments/widgets/gold_upcoming_payments.dart';
import 'package:omedia_payment_app/presentation/screens/other_payments/widgets/other_upcoming_payments.dart';
import 'package:omedia_payment_app/presentation/screens/pdf/pdf_viewer_bottom_sheet.dart';
import 'package:omedia_payment_app/presentation/widgets/custom_button.dart';

class UpcomingPayments extends StatefulWidget {
  const UpcomingPayments({super.key});

  @override
  State<UpcomingPayments> createState() => _UpcomingPaymentsState();
}

class _UpcomingPaymentsState extends State<UpcomingPayments> {
  void _showPdfViewer() {
    context.read<PdfBloc>().add(LoadPdf());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorConstants.white,
      builder: (context) => const PdfViewerBottomSheet(),
    );
  }

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
            color: ColorConstants.white,
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
                      FormatterWidget.toGeorgianUppercase(
                        'მოახლებული გადახდები',
                      ),
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: 16,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),

                OtherUpcomingPayments(),
                GoldUpcomingPayments(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CustomButton(
                    type: ButtonType.secondary,
                    text: 'ამონაწერის მომზადება',
                    textStyle: TextStyle(
                      color: ColorConstants.primaryDark,
                      fontFamily: AppTextStyles.fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: 0.1,
                    ),
                    iconPath: 'assets/icons/ic_list_alt.svg',
                    customIconColor: ColorConstants.primaryDark,
                    iconPadding: EdgeInsets.zero,
                    showTrailingIcon: true,
                    onPressed: _showPdfViewer,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
