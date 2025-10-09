import 'package:academia/config/router/routes.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
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
      FetchCommunityById(communityId: widget.communityId),
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
              await Future.delayed(const Duration(seconds: 2));
            },
            child: Scaffold(
              // drawer: Drawer(),
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar.medium(
                    centerTitle: false,
                    titleSpacing: 0,
                    title: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Coming soon"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
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
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.community.name),
                              Text(
                                "${NumberFormat.compact().format(state.community.memberCount)} members",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                        child: FilledButton(
                          onPressed: () {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => AlertDialog.adaptive(
                                title: Text("Are you sure you want to join?"),
                                content: Text(
                                  "Welcome to the community! "
                                  "By joining, you'll be the first to know about exciting updates, "
                                  "events, and everything happening here. "
                                  "To ensure a smooth experience, please take a moment to review "
                                  "the community guidelines set by our moderators. "
                                  "Understanding and following these rules will help keep our space "
                                  "welcoming and prevent any issues down the road. "
                                  "Let's make this community thrive together!",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(),
                                    child: Text("Never mind"),
                                  ),
                                  FilledButton(
                                    onPressed: () {},
                                    child: Text("Join Now"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text("Join"),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              showDragHandle: true,
                              builder: (context) => Container(
                                height: 320,
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "More community actions",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    ),
                                    Divider(),
                                    SizedBox(height: 12),
                                    ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text("Edit community information"),
                                    ),

                                    ListTile(
                                      leading: Icon(Icons.groups_2),
                                      title: Text("View community members"),
                                      onTap: () {
                                        CommunityMembersRoute(
                                          role: "user",
                                          communityId: widget.communityId,
                                        ).push(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.exit_to_app),
                                      title: Text("Leave community"),
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      title: Text("Delete community"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.more_vert),
                        ),
                      ),
                    ],
                  ),

                  SliverPadding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                    sliver: MultiSliver(
                      pushPinnedChildren: true,
                      children: [
                        SliverPinnedHeader(
                          child: Text(
                            state.community.description ??
                                'No description available',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                body: const Center(child: Text("Community posts")),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
