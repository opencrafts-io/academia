import 'package:academia/config/router/routes.dart';
import 'package:academia/features/chirp/communities/presentation/bloc/community_home_bloc.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:animated_emoji/animated_emoji.dart';

class CommunityHome extends StatefulWidget {
  final int communityId;

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
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
            },
            child: Scaffold(
              // drawer: Drawer(),
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar.large(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(state.community.name)],
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person_add_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: CircleAvatar(
                          backgroundImage:
                              state.community.profilePictureUrl == null
                              ? null
                              : CachedNetworkImageProvider(
                                  state.community.profilePictureUrl!,
                                  errorListener: (error) {},
                                ),
                          child: state.community.profilePictureUrl == null
                              ? Text(state.community.name[0])
                              : null,
                        ),
                      ),
                    ],
                  ),

                  SliverPinnedHeader(
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: Row(
                        spacing: 4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Chip(
                            label: Text(
                              "${NumberFormat.compact().format(state.community.memberCount)} members",
                            ),
                            avatar: AnimatedEmoji(
                              AnimatedEmojis.clown,
                              repeat: false,
                            ),
                          ),
                          Chip(
                            label: Text(
                              "${NumberFormat.compact().format(state.community.moderatorCount)} moderators",
                            ),
                            avatar: AnimatedEmoji(
                              AnimatedEmojis.wink,
                              repeat: false,
                            ),
                          ),
                          Chip(
                            label: Text(
                              "${NumberFormat.compact().format(state.community.weeklyVisitorCount)} visitors",
                            ),
                            avatar: AnimatedEmoji(
                              AnimatedEmojis.nerdFace,
                              repeat: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                body: Center(child: Text("Community posts")),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
