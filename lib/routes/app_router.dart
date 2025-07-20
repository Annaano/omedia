import 'package:flutter/material.dart';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:omedia_payment_app/presentation/screens/other_payments/other_payment_detail_screen.dart';
import 'package:omedia_payment_app/presentation/screens/gold_payments/gold_payments_detail_screen.dart';
import 'package:omedia_payment_app/presentation/screens/success/success_screen.dart';
import 'package:omedia_payment_app/routes/route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == null) {
      return MaterialPageRoute(builder: (_) => const DashboardScreen());
    }

    switch (settings.name) {
      case RouteNames.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      case RouteNames.paymentDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        final upcomingPayment = args?['upcomingPayment'] as Upcoming?;
        final loans = args?['loans'] as List<Loan>?;

        if (upcomingPayment == null) {
          return MaterialPageRoute(
            builder:
                (_) => const Scaffold(
                  body: Center(child: Text('Error: Payment data not found')),
                ),
          );
        }

        return MaterialPageRoute(
          builder:
              (_) => OtherPaymentDetailScreen(
                upcomingPayment: upcomingPayment,
                loans: loans,
              ),
        );

      case RouteNames.goldPayments:
        final args = settings.arguments as Map<String, dynamic>?;
        final upcomingPayment = args?['upcomingPayment'] as Upcoming?;
        final loans = args?['loans'] as List<Loan>?;

        if (upcomingPayment == null) {
          return MaterialPageRoute(
            builder:
                (_) => const Scaffold(
                  body: Center(child: Text('Error: Payment data not found')),
                ),
          );
        }

        return MaterialPageRoute(
          builder:
              (_) => GoldPaymentDetailScreen(
                upcomingPayment: upcomingPayment,
                loans: loans,
              ),
        );

      case RouteNames.success:
        final args = settings.arguments as Map<String, dynamic>?;
        final upcomingPayment = args?['upcomingPayment'] as Upcoming?;
        final loans = args?['loans'] as List<Loan>?;
        final isGoldPayment = args?['isGoldPayment'] as bool? ?? false;

        return MaterialPageRoute(
          builder:
              (_) => SuccessScreen(
                upcomingPayment: upcomingPayment,
                loans: loans,
                isGoldPayment: isGoldPayment,
              ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
    }
  }

  static Future<dynamic> navigateToPaymentDetail(
    BuildContext context,
    Upcoming upcomingPayment, {
    List<Loan>? loans,
  }) {
    return Navigator.of(context).pushNamed(
      RouteNames.paymentDetail,
      arguments: {'upcomingPayment': upcomingPayment, 'loans': loans},
    );
  }

  static Future<dynamic> navigateToGoldPaymentDetail(
    BuildContext context,
    Upcoming upcomingPayment, {
    List<Loan>? loans,
  }) {
    return Navigator.of(context).pushNamed(
      RouteNames.goldPayments,
      arguments: {'upcomingPayment': upcomingPayment, 'loans': loans},
    );
  }

  static void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Future<dynamic> navigateToDashboard(BuildContext context) {
    return Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(RouteNames.dashboard, (route) => false);
  }

  static Future<dynamic> navigateToSuccess(
    BuildContext context,
    Upcoming upcomingPayment, {
    List<Loan>? loans,
    bool isGoldPayment = false,
  }) {
    return Navigator.of(context).pushNamed(
      RouteNames.success,
      arguments: {
        'upcomingPayment': upcomingPayment,
        'loans': loans,
        'isGoldPayment': isGoldPayment,
      },
    );
  }
}
