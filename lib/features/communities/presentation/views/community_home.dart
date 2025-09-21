import 'package:academia/config/router/routes.dart';
import 'package:academia/features/communities/presentation/bloc/community_home_bloc.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:academia/features/communities/presentation/views/community_about.dart';
import 'package:academia/features/communities/presentation/views/community_members.dart';

class CommunityHome extends StatefulWidget {
  final String communityId;

  const CommunityHome({super.key, required this.communityId});

  @override
  State<CommunityHome> createState() => _CommunityHomeState();
}

class _CommunityHomeState extends State<CommunityHome>
    with SingleTickerProviderStateMixin {
  late String currentUserId;
  late String currentUserName;

  @override
  void initState() {
    super.initState();

    final profileState = context.read<ProfileBloc>().state;

    if (profileState is ProfileLoadedState) {
      currentUserId = profileState.profile.id;
      currentUserName = profileState.profile.name;
    }

    context.read<CommunityHomeBloc>().add(
      FetchCommunityById(
        communityId: widget.communityId,
        userId: currentUserId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityHomeBloc, CommunityHomeState>(
      listener: (context, state) {
        if (state is CommunityLeft) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You left the community")),
          );
          HomeRoute().go(context);
        }

        if (state is CommunityDeleted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Community deleted")));
          HomeRoute().go(context);
        }

        if (state is CommunityCriticalActionFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is CommunityHomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CommunityHomeFailure) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        } else if (state is CommunityHomeLoaded) {
          final isCreator = currentUserId == state.community.creatorId;
          final isModerator = state.community.canModerate == true;
          final isMember = state.community.canPost == true;
          final isBanned = state.community.isBanned == true;
          final hasGuidelines = state.community.rules.isEmpty ? false : true;

          //building the tabs dynamically
          final tabs = <Tab>[
            const Tab(text: "Posts"),
            if (hasGuidelines || isCreator || isModerator)
              const Tab(text: "About"),
            const Tab(text: "Members"),
          ];

          final tabViews = <Widget>[
            const Center(child: Text("Community Posts Page")),
            if (hasGuidelines || isCreator || isModerator)
              CommunityAbout(
                isModerator: isCreator || isModerator,
                communityId: state.community.id.toString(),
                userId: currentUserId,
                guidelines: state.community.rules,
              ),
            CommunityMembers(
              communityId: widget.communityId,
              members: state.community.members,
              memberNames: state.community.memberNames,
              moderators: state.community.moderators,
              moderatorNames: state.community.moderatorNames,
              banned: state.community.bannedUsers,
              bannedUserNames: state.community.bannedUserNames,
              isCreator: isCreator,
              isModerator: isModerator,
              isMember: isMember,
              isBanned: isBanned,
              isPrivate: state.community.isPrivate,
              userId: currentUserId,
              userName: currentUserName,
            ),
          ];

          return DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar.large(
                    expandedHeight: MediaQuery.of(context).size.height * 0.4,
                    pinned: true,
                    floating: false,
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    // Collapsed title (logo + details row)
                    title: Row(
                      children: [
                        ClipOval(
                          child: state.community.logoUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: state.community.logoUrl!,
                                  width: 45,
                                  height: 45,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.errorContainer,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.error,
                                          size: 18,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onErrorContainer,
                                        ),
                                      ),
                                )
                              : Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.group,
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.community.name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${state.community.memberCount} members",
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    actions: [
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          // handle actions
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: ListTile(
                              leading: Icon(Icons.edit),
                              title: Text("Edit Community Details"),
                            ),
                          ),
                        ],
                      ),
                    ],

                    flexibleSpace: FlexibleSpaceBar(
                    
                      background: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Banner at the top
                          if (state.community.bannerUrl != null)
                            CachedNetworkImage(
                              imageUrl: state.community.bannerUrl!,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.18,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                color: Theme.of(
                                  context,
                                ).colorScheme.errorContainer,
                                child: const Icon(Icons.broken_image, size: 48),
                              ),
                            )
                          else
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.18,
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              child: const Icon(Icons.image, size: 48),
                            ),

                          // Community details below banner
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: state.community.logoUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: state.community.logoUrl!,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                                width: 80,
                                                height: 80,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surfaceContainerHighest,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                      ),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                width: 80,
                                                height: 80,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.errorContainer,
                                                child: Icon(
                                                  Icons.error,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onErrorContainer,
                                                ),
                                              ),
                                        )
                                      : Container(
                                          width: 80,
                                          height: 80,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surfaceContainerHighest,
                                          child: Icon(
                                            Icons.group,
                                            size: 40,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.community.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      if (state.community.description != null)
                                        Text(
                                          state.community.description!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${state.community.memberCount} members",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      SizedBox(height: 5),
                                      if (isCreator || isModerator || isMember)
                                        FilledButton.icon(
                                          icon: Icon(Icons.post_add),
                                          onPressed: () {},
                                          label: const Text("Create Post"),
                                        )
                                      else if (isBanned)
                                        Text(
                                          "You are banned from this community",
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                          ),
                                        )
                                      else if (!isMember &&
                                          state.community.isPrivate)
                                        const Text(
                                          "This is a private community, request to join.",
                                        )
                                      else
                                        FilledButton.icon(
                                          icon: Icon(Icons.person_add_alt_1),
                                          onPressed: () {
                                            context
                                                .read<CommunityHomeBloc>()
                                                .add(
                                                  JoinCommunity(
                                                    communityId: state
                                                        .community
                                                        .id
                                                        .toString(),
                                                    userId: currentUserId,
                                                    userName: currentUserName,
                                                  ),
                                                );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Joining community...",
                                                ),
                                              ),
                                            );
                                          },
                                          label: const Text("Join"),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    bottom: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.center,
                      dividerHeight: 0,
                      tabs: tabs,
                    ),
                  ),
                ],
                body: TabBarView(children: tabViews),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
