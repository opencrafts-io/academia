import 'package:academia/features/communities/presentation/widgets/community_user_actions.dart';
import 'package:flutter/material.dart';

class CommunityUserListScreen extends StatefulWidget {
  final String communityId;
  final String userId;
  final String title;
  final List<Map<String, String>> users;
  final bool isTargetModerator;
  final bool isTargetBannedUsers;
  final bool isTargetMembers;
  final bool isCreator;
  final bool isModerator;
  final bool isMember;
  final bool isBanned;
  final bool isPrivate;

  const CommunityUserListScreen({
    super.key,
    required this.communityId,
    required this.userId,
    required this.title,
    required this.users,
    required this.isTargetModerator,
    required this.isTargetBannedUsers,
    required this.isTargetMembers,
    this.isCreator = false,
    this.isModerator = false,
    this.isMember = false,
    this.isBanned = false,
    this.isPrivate = false,
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
                    final targetUserMap = filteredUsers[index]; // Get the user map
                    final targetUserName = targetUserMap['name']!; // Extract the name
                    final targetUserId = targetUserMap['id']!;
                    return ListTile(
                      leading: CircleAvatar(child: Text(targetUserName[0].toUpperCase())),
                      title: Text(targetUserName),
                      onTap: () {
                        showUserActionsSheet(
                          context: context,
                          targetUserName: targetUserName,
                          communityId: widget.communityId,
                          userId: widget.userId,
                          targetUserId: targetUserId,
                          isTargetModerator: widget.isTargetModerator,
                          isTargetBanned: widget.isTargetBannedUsers,
                          isTargetMember: widget.isTargetMembers,
                          isCreator: widget.isCreator,
                          isModerator: widget.isModerator,
                          isMember: widget.isMember,
                          isBanned: widget.isBanned,
                          isPrivate: widget.isPrivate,
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
