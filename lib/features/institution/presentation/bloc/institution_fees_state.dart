part of 'institution_fees_bloc.dart';

enum FeesStatus { initial, loading, success, failure }

class InstitutionFeesState extends Equatable {
  final FeesStatus status;
  final List<InstitutionFeeTransaction?> transactions;
  final Failure? failure;

  const InstitutionFeesState({
    this.status = FeesStatus.initial,
    this.transactions = const [],
    this.failure,
  });

  // Helper getters for the "Expressive" UI
  double get totalDebit =>
      transactions.fold(0, (sum, item) => sum + (item?.debit ?? 0));
  double get totalCredit =>
      transactions.fold(0, (sum, item) => sum + (item?.credit ?? 0));
  double get currentBalance => totalCredit - totalDebit;

  bool get isInDebt => currentBalance < 0;

  InstitutionFeesState copyWith({
    FeesStatus? status,
    List<InstitutionFeeTransaction?>? transactions,
    Failure? failure,
  }) {
    return InstitutionFeesState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, transactions, failure];
}
