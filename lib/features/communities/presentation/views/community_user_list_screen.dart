import 'package:academia/features/communities/presentation/widgets/community_user_actions.dart';
import 'package:flutter/material.dart';

class CommunityUserListScreen extends StatefulWidget {
  final String communityId;
  final String title;
  final List<Map<String, String>> users;
  final bool isModerator;

  const CommunityUserListScreen({
    super.key,
    required this.communityId,
    required this.title,
    required this.users,
    required this.isModerator,
  });

  @override
  State<CommunityUserListScreen> createState() =>
      _CommunityUserListScreenState();
}

class _CommunityUserListScreenState extends State<CommunityUserListScreen> {
  String _query = "";
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = widget.users
        .where(
          (userMap) =>
              userMap['name']!.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            pinned: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(widget.title),
          ),

          // Search bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  hintText: "Search...",
                  hintStyle: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                          onPressed: () {
                            _controller.clear();
                            setState(() => _query = "");
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (val) => setState(() => _query = val),
              ),
            ),
          ),

          // User list or empty state
          filteredUsers.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_search,
                          size: 64,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "No users found",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final userMap = filteredUsers[index]; // Get the user map
                    final name = userMap['name']!; // Extract the name
                    final userId = userMap['id']!;
                    return ListTile(
                      leading: CircleAvatar(child: Text(name[0].toUpperCase())),
                      title: Text(name),
                      onTap: () {
                        showUserActionsSheet(
                          context,
                          name,
                          widget.communityId,
                          userId,
                          isModerator: widget.isModerator,
                        );
                      },
                    );
                  },
                ),

          // Optional spacing at the bottom
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}
