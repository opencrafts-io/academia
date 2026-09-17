import 'package:academia/core/core.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution_fees_state.freezed.dart';

@freezed
sealed class InstitutionFeesState with _$InstitutionFeesState {
  const InstitutionFeesState._();

  const factory InstitutionFeesState.initial() = _Initial;
  const factory InstitutionFeesState.loading() = _Loading;
  const factory InstitutionFeesState.success(
    List<InstitutionFeeTransaction?> transactions,
  ) = _Success;
  const factory InstitutionFeesState.failure(Failure failure) = _Failure;

  double get totalDebit => maybeWhen(
    success: (transactions) =>
        transactions.fold(0.0, (sum, item) => sum + (item?.debit ?? 0)),
    orElse: () => 0.0,
  );

  double get totalCredit => maybeWhen(
    success: (transactions) =>
        transactions.fold(0.0, (sum, item) => sum + (item?.credit ?? 0)),
    orElse: () => 0.0,
  );

  double get currentBalance => totalCredit - totalDebit;

  bool get isInDebt => currentBalance < 0;
}
