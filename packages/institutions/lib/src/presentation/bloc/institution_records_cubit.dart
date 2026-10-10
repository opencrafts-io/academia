import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/institution_repositories.dart';
import 'institution_records_state.dart';

/// Loads the signed-in student's saved academic profile and fee statements
/// for one institution membership. This Cubit only reads already-saved,
/// reviewed records -- it has no knowledge of portal capture, analysis, or
/// the AI provider; that boundary stays in `packages/portal_sync` and the
/// app composition root.
class InstitutionRecordsCubit extends Cubit<InstitutionRecordsState> {
  InstitutionRecordsCubit({
    required this.profileRepository,
    required this.feeRepository,
  }) : super(const InstitutionRecordsState());

  final InstitutionProfileRepository profileRepository;
  final InstitutionFeeRepository feeRepository;

  Future<void> load({
    required String accountId,
    required int institutionId,
  }) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final profileResult = await profileRepository.getProfile(
      accountId: accountId,
      institutionId: institutionId,
    );
    final feesResult = await feeRepository.listFeeStatements(
      accountId: accountId,
      institutionId: institutionId,
    );
    final error = profileResult.fold(
      (failure) => failure.message,
      (_) => feesResult.fold((failure) => failure.message, (_) => null),
    );
    emit(
      state.copyWith(
        profile: profileResult.fold((_) => null, (value) => value),
        clearProfile: profileResult.fold((_) => false, (value) => value == null),
        feeStatements: feesResult.fold((_) => const [], (value) => value),
        isLoading: false,
        error: error,
        clearError: error == null,
      ),
    );
  }
}
