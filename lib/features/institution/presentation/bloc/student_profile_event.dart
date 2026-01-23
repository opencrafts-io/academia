part of 'student_profile_bloc.dart';

abstract class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();

  @override
  List<Object?> get props => [];
}

// Watch Events

class WatchProfileByIdEvent extends StudentProfileEvent {
  final int profileId;

  const WatchProfileByIdEvent({required this.profileId});

  @override
  List<Object> get props => [profileId];
}

class WatchProfileByUserAndInstitutionEvent extends StudentProfileEvent {
  final int institutionID;
  final String userID;

  const WatchProfileByUserAndInstitutionEvent({
    required this.userID,
    required this.institutionID,
  });

  @override
  List<Object> get props => [institutionID, userID];
}

class WatchProfilesByUserEvent extends StudentProfileEvent {
  final String userId;

  const WatchProfilesByUserEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class WatchLatestProfileByStudentEvent extends StudentProfileEvent {
  final String studentId;

  const WatchLatestProfileByStudentEvent({required this.studentId});

  @override
  List<Object> get props => [studentId];
}

// Fetch Events

class FetchProfileByIdEvent extends StudentProfileEvent {
  final int profileId;

  const FetchProfileByIdEvent({required this.profileId});

  @override
  List<Object> get props => [profileId];
}

class FetchProfilesEvent extends StudentProfileEvent {
  final int? institutionId;
  final String? studentId;
  final String? program;

  const FetchProfilesEvent({this.institutionId, this.studentId, this.program});

  @override
  List<Object?> get props => [institutionId, studentId, program];
}

class FetchCurrentUserProfileEvent extends StudentProfileEvent {
  const FetchCurrentUserProfileEvent();
}

// Create Event

class CreateProfileEvent extends StudentProfileEvent {
  final InstitutionProfile profile;

  const CreateProfileEvent({required this.profile});

  @override
  List<Object> get props => [profile];
}

// Update Events

class UpdateProfileEvent extends StudentProfileEvent {
  final int profileId;
  final InstitutionProfile profile;

  const UpdateProfileEvent({required this.profileId, required this.profile});

  @override
  List<Object> get props => [profileId, profile];
}

class PartialUpdateProfileEvent extends StudentProfileEvent {
  final int profileId;
  final Map<String, dynamic> updates;

  const PartialUpdateProfileEvent({
    required this.profileId,
    required this.updates,
  });

  @override
  List<Object> get props => [profileId, updates];
}

// Delete Events

class DeleteProfileEvent extends StudentProfileEvent {
  final int profileId;

  const DeleteProfileEvent({required this.profileId});

  @override
  List<Object> get props => [profileId];
}

class DeleteUserProfilesEvent extends StudentProfileEvent {
  final String userId;

  const DeleteUserProfilesEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class ClearProfileCacheEvent extends StudentProfileEvent {
  const ClearProfileCacheEvent();
}

// Internal Events

class ProfileLoadedEvent extends StudentProfileEvent {
  final InstitutionProfile? profile;

  const ProfileLoadedEvent({this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfilesLoadedEvent extends StudentProfileEvent {
  final List<InstitutionProfile> profiles;

  const ProfilesLoadedEvent({required this.profiles});

  @override
  List<Object> get props => [profiles];
}

class LatestProfileLoadedEvent extends StudentProfileEvent {
  final InstitutionProfile? profile;

  const LatestProfileLoadedEvent({this.profile});

  @override
  List<Object?> get props => [profile];
}

class StudentProfileErrorEvent extends StudentProfileEvent {
  final String message;
  final Failure failure;

  const StudentProfileErrorEvent({
    required this.message,
    required this.failure,
  });

  @override
  List<Object> get props => [message, failure];
}
