import 'package:academia/config/router/routes.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/presentation/bloc/community_home_bloc.dart';
import 'package:academia/features/communities/presentation/widgets/community_user_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityMembers extends StatefulWidget {
  final String communityId;
  final List<String> members;
  final List<String> memberNames;
  final List<String> moderators;
  final List<String> moderatorNames;
  final List<String> banned;
  final List<String> bannedUserNames;
  final bool isCreator;
  final bool isModerator;
  final bool isMember;
  final bool isBanned;
  final bool isPrivate;
  final String userId;
  final String userName;

  const CommunityMembers({
    super.key,
    required this.communityId,
    required this.members,
    required this.memberNames,
    required this.moderators,
    required this.moderatorNames,
    required this.banned,
    required this.bannedUserNames,
    this.isCreator = false,
    this.isModerator = false,
    this.isMember = false,
    this.isBanned = false,
    this.isPrivate = false,
    required this.userId,
    required this.userName,
  });

  @override
  State<CommunityMembers> createState() => _CommunityMembersState();
}

class _CommunityMembersState extends State<CommunityMembers> {
  // Helper to combine member IDs and names
  List<Map<String, String>> _getCombinedMembers() {
    // Ensure lists are of the same length, or handle potential mismatches
    final length = widget.members.length < widget.memberNames.length
        ? widget.members.length
        : widget.memberNames.length;

    return List<Map<String, String>>.generate(length, (index) {
      return {'id': widget.members[index], 'name': widget.memberNames[index]};
    });
  }

  // Helper to combine moderator IDs and names
  List<Map<String, String>> _getCombinedModerators() {
    // Ensure lists are of the same length, or handle potential mismatches
    final length = widget.members.length < widget.moderatorNames.length
        ? widget.moderators.length
        : widget.moderatorNames.length;

    return List<Map<String, String>>.generate(length, (index) {
      return {
        'id': widget.moderators[index],
        'name': widget.moderatorNames[index],
      };
    });
  }

  List<Map<String, String>> _getCombinedBannedUsers() {
    // Ensure lists are of the same length, or handle potential mismatches
    final length = widget.banned.length < widget.bannedUserNames.length
        ? widget.banned.length
        : widget.bannedUserNames.length;

    return List<Map<String, String>>.generate(length, (index) {
      return {
        'id': widget.banned[index],
        'name': widget.bannedUserNames[index],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final combinedMembers = _getCombinedMembers();
    final combinedModerators = _getCombinedModerators();
    final combinedBannedUsers = _getCombinedBannedUsers();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Members Section
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.all(12),
              color: Theme.of(context).colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isCreator || widget.isModerator) ...[
                      // Actions
                      ListTile(
                        leading: const Icon(Icons.person_add_outlined),
                        title: const Text("Add Members"),
                        onTap: () async {
                          final updatedCommunity = await AddMembersRoute(
                            communityId: widget.communityId,
                            userId: widget.userId,
                          ).push<Community>(context);

                          if (updatedCommunity != null && context.mounted) {
                            context.read<CommunityHomeBloc>().add(
                              UpdateCommunity(community: updatedCommunity),
                            );
                          }
                        },
                      ),

                      //Put on hold for now and will uncomment in next iteration
                      // ListTile(
                      //   leading: const Icon(Icons.link_outlined),
                      //   title: const Text("Invite via Link"),
                      //   onTap: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (context) {
                      //         return Dialog(
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(16),
                      //           ),
                      //           child: const Padding(
                      //             padding: EdgeInsets.all(16.0),
                      //             child: InviteLinkWidget(),
                      //           ),
                      //         );
                      //       },
                      //     );
                      //   },
                      // ),
                      const Divider(),
                    ],
                    // Members
                    const Text(
                      "Members",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    Column(
                      children: combinedMembers.take(5).map((memberData) {
                        final name = memberData['name']!;
                        final memberId = memberData['id']!;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            child: Text(
                              name.isNotEmpty ? name[0].toUpperCase() : "?",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          title: Text(name),
                          onTap: () => showUserActionsSheet(
                            context: context,
                            targetUserName: name,
                            communityId: widget.communityId,
                            targetUserId: memberId,
                            userId: widget.userId,
                            isTargetMember: true,
                            isCreator: widget.isCreator,
                            isModerator: widget.isModerator,
                            isMember: widget.isMember,
                            isBanned: widget.isBanned,
                          ),
                        );
                      }).toList(),
                    ),

                    if (widget.isPrivate && widget.isMember ||
                        !widget.isPrivate && widget.isMember)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            CommunityUserListRoute(
                              communityId: widget.communityId,
                              userId: widget.userId,
                              title: "Members",
                              isTargetMember: true,
                              isCreator: widget.isCreator,
                              isModerator: widget.isModerator,
                              isMember: widget.isMember,
                              isBanned: widget.isBanned,
                              isPrivate: widget.isPrivate,
                            ).push(context);
                          },
                          child: const Text("View all members"),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Moderators Section
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.all(12),
              color: Theme.of(context).colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Moderators",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    Column(
                      children: combinedModerators.take(5).map((moderatorData) {
                        final name = moderatorData['name']!;
                        final moderatorId = moderatorData['id']!;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.secondaryContainer,
                            child: Text(
                              name.isNotEmpty ? name[0].toUpperCase() : "?",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ),
                          title: Text(name),
                          onTap: () => showUserActionsSheet(
                            context: context,
                            targetUserName: name,
                            communityId: widget.communityId,
                            targetUserId: moderatorId,
                            userId: widget.userId,
                            isTargetModerator: true,
                            isCreator: widget.isCreator,
                            isModerator: widget.isModerator,
                            isMember: widget.isMember,
                            isBanned: widget.isBanned,
                          ),
                        );
                      }).toList(),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          CommunityUserListRoute(
                            communityId: widget.communityId,
                            userId: widget.userId,
                            title: "Moderators",
                            isTargetModerator: true,
                            isCreator: widget.isCreator,
                            isModerator: widget.isModerator,
                            isMember: widget.isMember,
                            isBanned: widget.isBanned,
                            isPrivate: widget.isPrivate,
                          ).push(context);
                        },
                        child: const Text("View all moderators"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (combinedBannedUsers.isEmpty ||
              !widget.isModerator ||
              !widget.isCreator)
            const SliverToBoxAdapter()
          else
            // Banned Users Section
            SliverToBoxAdapter(
              child: Card(
                margin: const EdgeInsets.all(12),
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Banned Users",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      Column(
                        children: combinedBannedUsers.take(5).map((
                          bannedUserData,
                        ) {
                          final name = bannedUserData['name']!;
                          final bannedUserId = bannedUserData['id']!;
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : "?",
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ),
                            title: Text(name),
                            onTap: () => showUserActionsSheet(
                              context: context,
                              targetUserName: name,
                              communityId: widget.communityId,
                              targetUserId: bannedUserId,
                              userId: widget.userId,
                              isTargetBanned: true,
                              isCreator: widget.isCreator,
                              isModerator: widget.isModerator,
                              isMember: widget.isMember,
                              isBanned: widget.isBanned,
                            ),
                          );
                        }).toList(),
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            CommunityUserListRoute(
                              communityId: widget.communityId,
                              userId: widget.userId,
                              title: "Banned Users",
                              isTargetBannedUsers: true,
                              isCreator: widget.isCreator,
                              isModerator: widget.isModerator,
                              isMember: widget.isMember,
                              isBanned: widget.isBanned,
                              isPrivate: widget.isPrivate,
                            ).push(context);
                          },
                          child: const Text("View all Banned Users"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Critical Actions Section
          if ((widget.isMember || widget.isModerator || widget.isCreator) &&
              !widget.isBanned)
            SliverToBoxAdapter(
              child: Card(
                margin: const EdgeInsets.all(12),
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Critical Actions",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      // Show Leave Group ONLY if not creator
                      if (!widget.isCreator)
                        ListTile(
                          leading: const Icon(
                            Icons.exit_to_app_outlined,
                            color: Colors.orange,
                          ),
                          title: const Text("Leave Group"),
                          onTap: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Leave Community"),
                                content: const Text(
                                  "Are you sure you want to leave this community?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("Cancel"),
                                  ),
                                  FilledButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text("Leave"),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Leaving community..."),
                                ),
                              );

                              context.read<CommunityHomeBloc>().add(
                                LeaveCommunity(
                                  communityId: widget.communityId,
                                  userId: widget.userId,
                                  userName: widget.userName,
                                ),
                              );
                            }
                          },
                        ),

                      // Show Delete Group ONLY if creator
                      if (widget.isCreator)
                        ListTile(
                          leading: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          title: const Text("Delete Group"),
                          onTap: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Delete Community"),
                                content: const Text(
                                  "This action cannot be undone. Do you really want to delete this community?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("Cancel"),
                                  ),
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Deleting community..."),
                                ),
                              );

                              context.read<CommunityHomeBloc>().add(
                                DeleteCommunity(
                                  communityId: widget.communityId,
                                  userId: widget.userId,
                                ),
                              );
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ),
            )
          else
            const SliverToBoxAdapter(),

          // Some spacing at the bottom
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
