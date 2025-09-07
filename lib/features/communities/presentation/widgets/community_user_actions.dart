import 'package:academia/features/communities/domain/entities/community_moderation_enum.dart';
import 'package:academia/features/communities/presentation/bloc/community_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A reusable function to show user actions modal.
///
/// [name] - the user's display name
/// [isModerator] - whether the user is a moderator (hides "promote/ban/remove")
/// [isBanned] - whether the user is banned (if true, only "Unban" is shown)
Future<void> showUserActionsSheet(
  BuildContext context,
  String name,
  String communityId,
  String userId, {
  // target user state
  bool isTargetModerator = false,
  bool isTargetBanned = false,
  bool isTargetMember = false,

  // current logged-in user role
  required bool isCreator,
  required bool isModerator,
  required bool isMember,
  required bool isBanned,
  bool isPrivate = false,
}) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      final isPrivileged = isCreator || isModerator; // only these can moderate

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            ListTile(
              leading: CircleAvatar(child: Text(name[0].toUpperCase())),
              title: Text(name, style: Theme.of(context).textTheme.titleMedium),
            ),
            const Divider(),

            // If target user is banned → only show "Unban" (for privileged roles)
            if (isTargetBanned && isPrivileged) ...[
              ListTile(
                leading: const Icon(Icons.lock_open, color: Colors.green),
                title: Text("Unban $name"),
                onTap: () {
                  context.read<CommunityHomeBloc>().add(
                    ModerateMembers(
                      communityId: communityId,
                      action: CommunityModerationAction.unbanUser,
                      userId: userId,
                    ),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$name has been unbanned")),
                  );
                },
              ),
            ] else ...[
              // Always available: message
              ListTile(
                leading: const Icon(Icons.message),
                title: Text("Message $name"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Messaging $name...")));
                },
              ),

              // Only moderators/creators can promote, ban, or remove
              if (isPrivileged && !isTargetModerator) ...[
                ListTile(
                  leading: const Icon(Icons.shield_moon),
                  title: Text("Make $name moderator"),
                  onTap: () {
                    context.read<CommunityHomeBloc>().add(
                      ModerateMembers(
                        communityId: communityId,
                        action: CommunityModerationAction.addModerator,
                        userId: userId,
                      ),
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("$name is now a moderator")),
                    );
                  },
                ),
              ],
              if (isPrivileged && isTargetMember) ...[
                ListTile(
                  leading: const Icon(Icons.block, color: Colors.red),
                  title: Text("Ban $name"),
                  onTap: () {
                    context.read<CommunityHomeBloc>().add(
                      ModerateMembers(
                        communityId: communityId,
                        action: CommunityModerationAction.banUser,
                        userId: userId,
                      ),
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("$name has been banned")),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person_remove,
                    color: Colors.orange,
                  ),
                  title: Text("Remove $name"),
                  onTap: () {
                    context.read<CommunityHomeBloc>().add(
                      ModerateMembers(
                        communityId: communityId,
                        action: CommunityModerationAction.removeMember,
                        userId: userId,
                      ),
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("$name has been removed")),
                    );
                  },
                ),
              ],
            ],
          ],
        ),
      );
    },
  );
}
