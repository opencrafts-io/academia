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
  bool isModerator = false,
  bool isBanned = false,
}) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User header
            ListTile(
              leading: CircleAvatar(child: Text(name[0].toUpperCase())),
              title: Text(name, style: Theme.of(context).textTheme.titleMedium),
            ),
            const Divider(),

            if (isBanned) ...[
              // If banned → only show "Unban"
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
              // Always available
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

              // Extra actions for members (not moderators)
              if (!isModerator) ...[
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
