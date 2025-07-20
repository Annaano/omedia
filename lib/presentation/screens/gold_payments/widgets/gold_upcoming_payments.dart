import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omedia_payment_app/core/utils/formatter_widget.dart';
import 'package:omedia_payment_app/logic/blocs/obligation_gold/obligation_gold_bloc.dart';
import 'package:omedia_payment_app/presentation/widgets/upcoming_payment_tile.dart';
import 'package:omedia_payment_app/presentation/widgets/payment_selection_modal.dart';
import 'package:omedia_payment_app/routes/app_router.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/data/models/obligation_gold_model.dart';

class GoldUpcomingPayments extends StatefulWidget {
  const GoldUpcomingPayments({super.key});

  @override
  State<GoldUpcomingPayments> createState() => _GoldUpcomingPaymentsState();
}

class _GoldUpcomingPaymentsState extends State<GoldUpcomingPayments> {
  Upcoming _convertGoldPaymentItemToUpcoming(UpcomingPaymentItem item) {
    return Upcoming(
      paymentAmount: item.paymentAmount,
      remainingDays: item.remainingDays,
      expired: item.expired,
      today: item.today,
      paymentDate: item.paymentDate,
      items: [
        UpcomingItem(
          accountNumber: item.accountNumber,
          paymentAmount: item.paymentAmount,
          principalAmount: item.principalAmount,
          percentageAmount: item.percentageAmount,
          fineAmount: item.fineAmount,
          remainingDays: item.remainingDays,
          expired: item.expired,
          today: item.today,
          paymentDate: item.paymentDate,
        ),
      ],
    );
  }

  void _showPaymentSelectionBottomSheet(dynamic upcomingPayment) {
    PaymentSelectionModal.show(
      context: context,
      upcomingPayment: upcomingPayment,
      loans: null,
      isGoldPayment: true,
      onPaymentSelected: (item) {
        if (item is UpcomingPaymentItem) {
          final convertedUpcoming = _convertGoldPaymentItemToUpcoming(item);
          AppRouter.navigateToGoldPaymentDetail(context, convertedUpcoming);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObligationGoldBloc, ObligationGoldState>(
      builder: (context, otherState) {
        dynamic otherUpComingObligationsAmount = 'Loading...';
        dynamic remainingDaysText = 'Loading...';
        bool isExpired = false;

        if (otherState is ObligationGoldLoaded &&
            otherState.obligation.upcoming != null) {
          try {
            otherUpComingObligationsAmount = otherState
                .obligation
                .upcoming
                .paymentAmount
                .toStringAsFixed(2);
            isExpired = otherState.obligation.upcoming.expired;
            remainingDaysText =
                isExpired
                    ? '${otherState.obligation.upcoming.remainingDays.toString()} დღე'
                    : '${otherState.obligation.upcoming.remainingDays}';
          } catch (e) {
            otherUpComingObligationsAmount = "Loading...";
            remainingDaysText = "Loading...";
          }
        } else {
          otherUpComingObligationsAmount = "Loading...";
          remainingDaysText = "Loading...";
        }

        return UpcomingPaymentTile(
          title: 'ოქროს ლომბარდი',
          iconPath: 'assets/icons/ic_gold_obligations.svg',
          amount: FormatterWidget.formatNumberWithCommas(
            otherUpComingObligationsAmount,
          ),
          remainingDaysText: remainingDaysText,
          showWarningIcon: true,
          isExpired: isExpired,
          iconPaddingHorizontal: 6.5,
          iconPaddingVertical: 6.5,
          endIconPath: 'assets/icons/ic_forward_arrow.svg',

          onTap: () {
            if (otherState is ObligationGoldLoaded &&
                otherState.obligation.upcoming != null) {
              _showPaymentSelectionBottomSheet(otherState.obligation.upcoming);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment data not available yet'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
        );
      },
    );
  }
}
