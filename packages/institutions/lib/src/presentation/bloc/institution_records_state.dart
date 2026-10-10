import '../../domain/entities/entities.dart';

class InstitutionRecordsState {
  const InstitutionRecordsState({
    this.profile,
    this.feeStatements = const [],
    this.isLoading = false,
    this.error,
  });

  final AcademicProfileEntity? profile;
  final List<FeeStatementEntity> feeStatements;
  final bool isLoading;
  final String? error;

  InstitutionRecordsState copyWith({
    AcademicProfileEntity? profile,
    bool clearProfile = false,
    List<FeeStatementEntity>? feeStatements,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) => InstitutionRecordsState(
    profile: clearProfile ? null : profile ?? this.profile,
    feeStatements: feeStatements ?? this.feeStatements,
    isLoading: isLoading ?? this.isLoading,
    error: clearError ? null : error ?? this.error,
  );
}
