import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/obligation_gold_model.dart';
import '../../../data/repositories/obligation_repository.dart';

part 'obligation_gold_event.dart';
part 'obligation_gold_state.dart';

class ObligationGoldBloc
    extends Bloc<ObligationGoldEvent, ObligationGoldState> {
  final ObligationRepository repository;

  ObligationGoldBloc(this.repository) : super(ObligationGoldInitial()) {
    on<LoadObligationGold>((event, emit) async {
      emit(ObligationGoldLoading());
      try {
        final data = await repository.getGoldObligations();
        emit(ObligationGoldLoaded(data));
      } catch (e) {
        emit(ObligationGoldError("Failed to fetch obligations: $e"));
      }
    });
  }
}
