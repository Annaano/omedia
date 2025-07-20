import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omedia_payment_app/data/repositories/obligation_repository.dart';
import 'package:omedia_payment_app/logic/blocs/obligation_other/obligation_other_bloc.dart';
import 'package:omedia_payment_app/logic/blocs/obligation_gold/obligation_gold_bloc.dart';
import 'package:omedia_payment_app/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:omedia_payment_app/logic/blocs/pdf/pdf_bloc.dart';

import 'data/providers/obligation_api_provider.dart';
import 'routes/app_router.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';

void main() {
  final apiProvider = ObligationApiProvider();
  final repository = ObligationRepository(apiProvider: apiProvider);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  ObligationOtherBloc(repository)..add(LoadObligationOther()),
        ),
        BlocProvider(
          create:
              (_) => ObligationGoldBloc(repository)..add(LoadObligationGold()),
        ),
        BlocProvider(create: (_) => DashboardBloc()..add(LoadDashboardData())),
        BlocProvider(create: (_) => PdfBloc(repository)),
      ],
      child: OmediaApp(),
    ),
  );
}

class OmediaApp extends StatelessWidget {
  OmediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Omedia Payments',
      home: const DashboardScreen(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
