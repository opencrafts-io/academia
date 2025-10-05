enum UserType {
  members,
  moderators,
  bannedUsers,
}

// Helper method to convert UserType to its string representation for the URL
extension UserTypeExtension on UserType {
  String get endpointPath {
    switch (this) {
      case UserType.members:
        return "members";
      case UserType.moderators:
        return "moderators";
      case UserType.bannedUsers:
        return "banned";
    }
  }
}