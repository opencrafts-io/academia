enum CommunityModerationAction {
  addMember,
  removeMember,
  banUser,
  unbanUser,
  addModerator,
  removeModerator,
}

extension CommunityModerationActionX on CommunityModerationAction {
  String get asApiString {
    switch (this) {
      case CommunityModerationAction.addMember:
        return "add_member";
      case CommunityModerationAction.removeMember:
        return "remove_member";
      case CommunityModerationAction.banUser:
        return "ban";
      case CommunityModerationAction.unbanUser:
        return "unban";
      case CommunityModerationAction.addModerator:
        return "add_moderator";
      case CommunityModerationAction.removeModerator:
        return "remove_moderator";
    }
  }
}
