part of 'student_profile_bloc.dart';

enum StudentProfileStatus { initial, loading, success, error }

class StudentProfileState extends Equatable {
  final StudentProfileStatus status;
  final InstitutionProfile? profile;
  final List<InstitutionProfile>? profiles;
  final InstitutionProfile? latestProfile;
  final String? errorMessage;
  final Failure? failure;

  const StudentProfileState({
    required this.status,
    this.profile,
    this.profiles,
    this.latestProfile,
    this.errorMessage,
    this.failure,
  });

  /// Initial state
  factory StudentProfileState.initial() =>
      StudentProfileState(status: StudentProfileStatus.initial);

  /// Loading state
  factory StudentProfileState.loading() =>
      const StudentProfileState(status: StudentProfileStatus.loading);

  /// Success state with a single profile
  factory StudentProfileState.success({required InstitutionProfile profile}) =>
      StudentProfileState(
        status: StudentProfileStatus.success,
        profile: profile,
      );

  /// Success state with multiple profiles
  factory StudentProfileState.successList({
    required List<InstitutionProfile> profiles,
  }) => StudentProfileState(
    status: StudentProfileStatus.success,
    profiles: profiles,
  );

  /// Error state
  factory StudentProfileState.error({
    required String message,
    required Failure failure,
  }) => StudentProfileState(
    status: StudentProfileStatus.error,
    errorMessage: message,
    failure: failure,
  );

  /// Copy with method for immutable updates
  StudentProfileState copyWith({
    StudentProfileStatus? status,
    InstitutionProfile? profile,
    List<InstitutionProfile>? profiles,
    InstitutionProfile? latestProfile,
    String? errorMessage,
    Failure? failure,
  }) {
    return StudentProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      profiles: profiles ?? this.profiles,
      latestProfile: latestProfile ?? this.latestProfile,
      errorMessage: errorMessage ?? this.errorMessage,
      failure: failure ?? this.failure,
    );
  }

  /// Getters for convenience
  bool get isLoading => status == StudentProfileStatus.loading;

  bool get isSuccess => status == StudentProfileStatus.success;

  bool get isError => status == StudentProfileStatus.error;

  bool get isInitial => status == StudentProfileStatus.initial;

  @override
  List<Object?> get props => [
    status,
    profile,
    profiles,
    latestProfile,
    errorMessage,
    failure,
  ];
}
