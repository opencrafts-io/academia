part of 'magnet_bloc.dart';

sealed class MagnetEvent extends Equatable {
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}

class InitializeMagnetInstancesEvent extends MagnetEvent {}

class GetCachedMagnetProfileEvent extends MagnetEvent {
  final int institutionID;
  final String userID;
  GetCachedMagnetProfileEvent({
    required this.institutionID,
    required this.userID,
  });

  @override
  List<Object?> get props => [institutionID, userID];
}

class FetchMagnetProfileEvent extends MagnetEvent {
  final int institutionID;
  final String userID;
  FetchMagnetProfileEvent({required this.institutionID, required this.userID});

  @override
  List<Object?> get props => [institutionID, userID];
}

class GetCachedMagnetCredentialEvent extends MagnetEvent {
  final int institutionID;
  final String userID;
  GetCachedMagnetCredentialEvent({
    required this.institutionID,
    required this.userID,
  });

  @override
  List<Object?> get props => [institutionID, userID];
}

class FetchMagnetStudentTimeTableEvent extends MagnetEvent {
  final int institutionID;
  final String userID;
  FetchMagnetStudentTimeTableEvent({
    required this.institutionID,
    required this.userID,
  });

  @override
  List<Object?> get props => [institutionID, userID];
}

class FetchMagnetFeeStatementTransactionsEvent extends MagnetEvent {
  final int institutionID;
  final String userID;
  FetchMagnetFeeStatementTransactionsEvent({
    required this.institutionID,
    required this.userID,
  });

  @override
  List<Object?> get props => [institutionID, userID];
}

class GetCachedMagnetStudentTimetableEvent extends MagnetEvent {
  final int institutionID;
  final String userID;
  GetCachedMagnetStudentTimetableEvent({
    required this.institutionID,
    required this.userID,
  });

  @override
  List<Object?> get props => [institutionID, userID];
}

class DeleteCachedMagnetStudentTimetableEvent extends MagnetEvent {
  final int institutionID;
  final String userID;
  final String courseCode;
  DeleteCachedMagnetStudentTimetableEvent({
    required this.institutionID,
    required this.userID,
    required this.courseCode,
  });

  @override
  List<Object?> get props => [institutionID, userID, courseCode];
}

class LinkMagnetAccountEvent extends MagnetEvent {
  final Credentials credentials;
  final int institutionID;
  final String userID;
  LinkMagnetAccountEvent({
    required this.credentials,
    required this.institutionID,
    required this.userID,
  });

  @override
  List<Object?> get props => [credentials, institutionID, userID];
}

class RefreshMagnetAuthenticationEvent extends MagnetEvent {
  final Credentials credentials;
  final int institutionID;
  final String userID;
  RefreshMagnetAuthenticationEvent({
    required this.credentials,
    required this.institutionID,
    required this.userID,
  });

  @override
  List<Object?> get props => [credentials, institutionID, userID];
}
