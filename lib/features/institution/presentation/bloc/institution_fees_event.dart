part of 'institution_fees_bloc.dart';

abstract class InstitutionFeesEvent extends Equatable {
  const InstitutionFeesEvent();
  @override
  List<Object?> get props => [];
}

class WatchFeesStarted extends InstitutionFeesEvent {
  final int institutionId;
  const WatchFeesStarted(this.institutionId);
  @override
  List<Object?> get props => [institutionId];
}

class TransactionSaved extends InstitutionFeesEvent {
  final InstitutionFeeTransaction transaction;
  const TransactionSaved(this.transaction);
}
