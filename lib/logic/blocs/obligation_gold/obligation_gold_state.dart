part of 'obligation_gold_bloc.dart';

abstract class ObligationGoldState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ObligationGoldInitial extends ObligationGoldState {}

class ObligationGoldLoading extends ObligationGoldState {}

class ObligationGoldLoaded extends ObligationGoldState {
  final ObligationGoldModel obligation;

  ObligationGoldLoaded(this.obligation);

  double get totalGoldIssueAmount {
    return obligation.loans.fold(0.0, (sum, loan) => sum + loan.issueAmount);
  }

  @override
  List<Object?> get props => [obligation];
}

class ObligationGoldError extends ObligationGoldState {
  final String message;

  ObligationGoldError(this.message);

  @override
  List<Object?> get props => [message];
}
