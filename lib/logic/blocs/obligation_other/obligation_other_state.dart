part of 'obligation_other_bloc.dart';

abstract class ObligationOtherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ObligationOtherInitial extends ObligationOtherState {}

class ObligationOtherLoading extends ObligationOtherState {}

class ObligationOtherLoaded extends ObligationOtherState {
  final ObligationOtherModel obligation;

  ObligationOtherLoaded(this.obligation);
  double get totalOtherIssueAmount {
    return obligation.loans.fold(0.0, (sum, loan) => sum + loan.issueAmount);
  }

  @override
  List<Object?> get props => [obligation];
}

class ObligationOtherError extends ObligationOtherState {
  final String message;

  ObligationOtherError(this.message);

  @override
  List<Object?> get props => [message];
}
