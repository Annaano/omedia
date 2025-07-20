import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/logic/blocs/obligation_other/obligation_other_bloc.dart';
import 'package:omedia_payment_app/presentation/widgets/upcoming_payment_tile.dart';
import 'package:omedia_payment_app/routes/app_router.dart';

class OtherUpcomingPayments extends StatefulWidget {
  const OtherUpcomingPayments({super.key});

  @override
  State<OtherUpcomingPayments> createState() => _OtherUpcomingPaymentsState();
}

class _OtherUpcomingPaymentsState extends State<OtherUpcomingPayments> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObligationOtherBloc, ObligationOtherState>(
      builder: (context, otherState) {
        dynamic otherUpComingObligationsAmount = 'Loading...';
        dynamic remainingDaysText = 'Loading...';

        if (otherState is ObligationOtherLoaded &&
            otherState.obligation.upcoming != null) {
          try {
            otherUpComingObligationsAmount = otherState
                .obligation
                .upcoming
                .paymentAmount
                .toStringAsFixed(2);
            remainingDaysText =
                otherState.obligation.upcoming.remainingDays == 0 &&
                        otherState.obligation.upcoming.today
                    ? 'დღეს'
                    : '${otherState.obligation.upcoming.remainingDays} დღეში';
          } catch (e) {
            otherUpComingObligationsAmount = "Loading...";
            remainingDaysText = "Loading...";
          }
        } else {
          otherUpComingObligationsAmount = "Loading...";
          remainingDaysText = "Loading...";
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: UpcomingPaymentTile(
            title: 'სხვა სესხები',
            paymentText: 'გადახდა ',
            iconPath: 'assets/icons/ic_other_obligations.svg',
            amount: FormatterWidget.formatNumberWithCommas(
              otherUpComingObligationsAmount,
            ),
            remainingDaysText: remainingDaysText,
            showWarningIcon: false,
            isExpired: false,
            endIconPath: 'assets/icons/ic_forward_arrow.svg',

            onTap: () {
              if (otherState is ObligationOtherLoaded &&
                  otherState.obligation.upcoming != null) {
                try {
                  AppRouter.navigateToPaymentDetail(
                    context,
                    otherState.obligation.upcoming,
                    loans: otherState.obligation.loans,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error navigating to payment details: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Payment data not available yet'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
