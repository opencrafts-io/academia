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

class LinkMagnetAccountEvent extends MagnetEvent {
  final Credentials credentials;
  final int institutionID;
  LinkMagnetAccountEvent({
    required this.credentials,
    required this.institutionID,
  });

  @override
  List<Object?> get props => [credentials];
}
