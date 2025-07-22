part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class RefreshProfileEvent extends ProfileEvent {}

class GetCachedProfileEvent extends ProfileEvent {}

class UpdateUserProfileEvent extends ProfileEvent {
  final UserProfile profile;
  UpdateUserProfileEvent({required this.profile});
}

class UpdateUserPhoneEvent extends ProfileEvent {
  final UserProfile profile;
  UpdateUserPhoneEvent({required this.profile});
}
