import 'package:academia/database/database.dart';

import '../../domain/entities/user_profile.dart';

extension UserProfileModelHelper on UserProfileData {
  UserProfile toEntity() => UserProfile(
    id: id,
    name: name,
    email: email,
    onboarded: onboarded,
    termsAccepted: termsAccepted,
    createdAt: createdAt,
    updatedAt: updatedAt,
    vibePoints: vibePoints,
    bio: bio,
    phone: phone,
    username: username,
    nationalID: nationalID,
    avatarUrl: avatarUrl,
  );
}

extension UserProfileHelper on UserProfile {
  UserProfileData toData() => UserProfileData(
    id: id,
    name: name,
    email: email,
    onboarded: onboarded,
    termsAccepted: termsAccepted,
    createdAt: createdAt,
    updatedAt: updatedAt,
    vibePoints: vibePoints,
    bio: bio,
    phone: phone,
    username: username,
    nationalID: nationalID,
    avatarUrl: avatarUrl,
  );
}
