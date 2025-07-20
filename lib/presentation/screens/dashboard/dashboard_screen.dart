import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omedia_payment_app/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:omedia_payment_app/presentation/screens/dashboard/widgets/app_bar_widget.dart';
import 'package:omedia_payment_app/presentation/screens/dashboard/widgets/balance_card.dart';
import 'package:omedia_payment_app/presentation/screens/dashboard/widgets/obligation_summary.dart';
import 'package:omedia_payment_app/presentation/screens/dashboard/widgets/upcoming_payments_section.dart';
import 'package:omedia_payment_app/presentation/widgets/bottom_navigation_bar.dart';
import '../../../core/constants/app_colors_constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(232, 232, 232, 1),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: AppBarWidget(),
        titleSpacing: 16,
        shadowColor: Color.fromRGBO(0, 0, 0, 0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 8),
                blurRadius: 12,
                spreadRadius: 0,
                color: Color.fromRGBO(0, 0, 0, 0.08),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 2),

      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20, top: 20),
        child: ListView.separated(
          itemCount: 3,
          separatorBuilder: (context, index) => SizedBox(height: 20),
          itemBuilder:
              (context, index) =>
                  [
                    ObligationSummary(),
                    BalanceCard(),
                    UpcomingPayments(),
                  ][index],
        ),
      ),
    );
  }
}
