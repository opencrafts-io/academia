import 'package:academia/config/router/routes.dart';
import 'package:academia/features/communities/presentation/widgets/community_user_actions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommunityMembers extends StatefulWidget {
  final String communityId;
  final List<String> members;
  final List<String> memberNames;
  final List<String> moderators;
  final List<String> moderatorNames;
  const CommunityMembers({
    super.key,
    required this.communityId,
    required this.members,
    required this.memberNames,
    required this.moderators,
    required this.moderatorNames,
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

  @override
  Widget build(BuildContext context) {
    final combinedMembers = _getCombinedMembers();
    final combinedModerators = _getCombinedModerators();
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
                    // Actions
                    ListTile(
                      leading: const Icon(Icons.person_add_outlined),
                      title: const Text("Add Members"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.link_outlined),
                      title: const Text("Invite via Link"),
                      onTap: () {},
                    ),

                    const Divider(),

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
                            context,
                            name,
                            widget.communityId,
                            memberId,
                          ),
                        );
                      }).toList(),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          final path = CommunityUserListRoute(
                            communityId: widget.communityId,
                            title: "All Members",
                          ).location;

                          context.push(path, extra: combinedMembers);
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
                            context,
                            name,
                            widget.communityId,
                            moderatorId,
                            isModerator: true,
                          ),
                        );
                      }).toList(),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // Construct the path string with query parameters
                          final String path = CommunityUserListRoute(
                            communityId: widget.communityId,
                            title: "All Moderators",
                            isModerator: true,
                          ).location;

                          // Use context.push with the path and the extra parameter
                          context.push(path, extra: _getCombinedModerators());
                        },
                        child: const Text("View all moderators"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Critical Actions Section
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

                    ListTile(
                      leading: const Icon(
                        Icons.exit_to_app_outlined,
                        color: Colors.orange,
                      ),
                      title: const Text("Leave Group"),
                      onTap: () {
                        // TODO: Leave group logic
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      title: const Text("Delete Group"),
                      onTap: () {
                        // TODO: Delete group logic
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Some spacing at the bottom
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
