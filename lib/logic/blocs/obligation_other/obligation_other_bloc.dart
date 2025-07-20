import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/obligation_other_model.dart';
import '../../../data/repositories/obligation_repository.dart';

part 'obligation_other_event.dart';
part 'obligation_other_state.dart';

class ObligationOtherBloc
    extends Bloc<ObligationOtherEvent, ObligationOtherState> {
  final ObligationRepository repository;

  ObligationOtherBloc(this.repository) : super(ObligationOtherInitial()) {
    on<LoadObligationOther>((event, emit) async {
      emit(ObligationOtherLoading());
      try {
        final data = await repository.getOtherObligations();
        emit(ObligationOtherLoaded(data));
      } catch (e) {
        emit(ObligationOtherError("Failed to fetch obligations: $e"));
      }
    });
  }
}
