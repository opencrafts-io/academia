import 'package:flutter/material.dart';

class CommunityMembers extends StatefulWidget {
  const CommunityMembers({super.key});

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
                      children: List.generate(5, (index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            child: Text(
                              ["A", "B", "C", "D", "E"][index],
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          title: Text("Member ${index + 1}"),
                        );
                      }),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navigate to all members page
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
                      children: List.generate(5, (index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                            child: Text(
                              ["M", "N", "O", "P", "Q"][index],
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ),
                          title: Text("Moderator ${index + 1}"),
                        );
                      }),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navigate to all moderators page
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
