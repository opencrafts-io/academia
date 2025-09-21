import 'package:academia/features/communities/domain/entities/community_users_enum.dart';
import 'package:academia/features/communities/presentation/bloc/community_users/community_users_bloc.dart';
import 'package:academia/features/communities/presentation/widgets/community_user_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityUserListScreen extends StatefulWidget {
  final String communityId;
  final String userId;
  final String title;
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
    context.read<CommunityUsersBloc>().add(
      FetchCommunityMembers(
        communityId: widget.communityId,
        userType: widget.title.toLowerCase() == "members"
            ? UserType.members
            : widget.title.toLowerCase() == "moderators"
            ? UserType.moderators
            : UserType.bannedUsers,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

          BlocBuilder<CommunityUsersBloc, CommunityUsersState>(
            builder: (context, state) {
              if (state is CommunityUsersLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is CommunityUsersFailure) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(state.message)),
                );
              } else if (state is CommunityUsersLoaded) {
                final filteredUsers = state.paginatedResponse.users
                    .where(
                      (user) => user.userName.toLowerCase().contains(
                        _query.toLowerCase(),
                      ),
                    )
                    .toList();

                if (filteredUsers.isEmpty) {
                  return SliverFillRemaining(
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
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverList.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final targetUser = filteredUsers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(targetUser.userName[0].toUpperCase()),
                      ),
                      title: Text(targetUser.userName),
                      onTap: () {
                        showUserActionsSheet(
                          context: context,
                          targetUserName: targetUser.userName,
                          communityId: widget.communityId,
                          userId: widget.userId,
                          targetUserId: targetUser.userId,
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
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),

          // Optional spacing at the bottom
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}
