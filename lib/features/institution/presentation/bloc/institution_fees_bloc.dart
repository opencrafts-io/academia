import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';

part 'institution_fees_state.dart';
part 'institution_fees_event.dart';

class InstitutionFeesBloc
    extends Bloc<InstitutionFeesEvent, InstitutionFeesState> {
  final WatchInstitutionFees _watchInstitutionFees;
  final SaveFeeTransaction _saveFeeTransaction;

  InstitutionFeesBloc({
    required WatchInstitutionFees watchInstitutionFees,
    required SaveFeeTransaction saveFeeTransaction,
  }) : _watchInstitutionFees = watchInstitutionFees,
       _saveFeeTransaction = saveFeeTransaction,
       super(const InstitutionFeesState()) {
    on<WatchFeesStarted>(_onWatchFeesStarted);
    on<TransactionSaved>(_onTransactionSaved);
  }

  Future<void> _onWatchFeesStarted(
    WatchFeesStarted event,
    Emitter<InstitutionFeesState> emit,
  ) async {
    emit(state.copyWith(status: FeesStatus.loading));

    await emit.forEach<Either<Failure, List<InstitutionFeeTransaction?>>>(
      _watchInstitutionFees(event.institutionId),
      onData: (result) => result.fold(
        (failure) =>
            state.copyWith(status: FeesStatus.failure, failure: failure),
        (transactions) => state.copyWith(
          status: FeesStatus.success,
          transactions: transactions,
        ),
      ),
    );
  }

  Future<void> _onTransactionSaved(
    TransactionSaved event,
    Emitter<InstitutionFeesState> emit,
  ) async {
    final result = await _saveFeeTransaction(event.transaction);

    result.fold(
      (failure) =>
          emit(state.copyWith(status: FeesStatus.failure, failure: failure)),
      (_) {},
    );
  }
}
