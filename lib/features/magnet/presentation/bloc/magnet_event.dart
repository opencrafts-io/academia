part of 'magnet_bloc.dart';

sealed class MagnetEvent extends Equatable {
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}

class InitializeMagnetInstanceEvent extends MagnetEvent {}

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
