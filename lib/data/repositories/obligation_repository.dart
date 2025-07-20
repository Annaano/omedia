import 'dart:typed_data';
import 'package:omedia_payment_app/data/models/obligation_other_model.dart';
import 'package:omedia_payment_app/data/models/obligation_gold_model.dart';

import '../providers/obligation_api_provider.dart';
import '../models/obligation_other_model.dart';

class ObligationRepository {
  final ObligationApiProvider apiProvider;
  ObligationRepository({required this.apiProvider});

  Future<ObligationOtherModel> getOtherObligations() async {
    final response = await apiProvider.fetchOtherObligations();
    return ObligationOtherModel.fromJson(response.data);
  }

  Future<ObligationGoldModel> getGoldObligations() async {
    final response = await apiProvider.fetchGoldObligations();
    return ObligationGoldModel.fromJson(response.data);
  }

  /// Fetch PDF file (Obligation Transactions)
  Future<Uint8List> fetchTransactionsPdf() async {
    final response = await apiProvider.fetchPdfTransactions();
    return response.data; // This is raw PDF bytes
  }
}
