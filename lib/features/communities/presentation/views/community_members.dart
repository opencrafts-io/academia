import 'package:academia/config/router/routes.dart';
import 'package:academia/features/communities/presentation/widgets/community_user_actions.dart';
import 'package:flutter/material.dart';

class CommunityMembers extends StatefulWidget {
  final String communityId;
  final List<String> memberNames;
  final List<String> moderatorNames;
  const CommunityMembers({
    super.key,
    required this.communityId,
    required this.memberNames,
    required this.moderatorNames,
  });

  @override
  State<CommunityMembers> createState() => _CommunityMembersState();
}

class _CommunityMembersState extends State<CommunityMembers> {
  @override
  Widget build(BuildContext context) {
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
                      children: widget.memberNames.take(5).map((name) {
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
                          onTap: () => showUserActionsSheet(context, name),
                        );
                      }).toList(),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          CommunityUserListRoute(
                            communityId: widget.communityId,
                            title: "All Members",
                            users: widget.memberNames,
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
                      children: widget.moderatorNames.take(5).map((name) {
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
                            isModerator: true,
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
                            title: "All Moderators",
                            users: widget.moderatorNames,
                            isModerator: true,
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
