import 'package:academia/config/config.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class CommunityMembershipPage extends StatefulWidget {
  const CommunityMembershipPage({super.key});

  @override
  State<CommunityMembershipPage> createState() =>
      _CommunityMembershipPageState();
}

class _CommunityMembershipPageState extends State<CommunityMembershipPage> {
  final List<Community> communities = [];
  @override
  void initState() {
    context.read<CommunityListingCubit>().getPostableCommunities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<CommunityListingCubit>().getPostableCommunities();
          await Future.delayed(Duration(seconds: 2));
        },
        child: BlocListener<CommunityListingCubit, CommunityListingState>(
          listener: (context, state) {
            if (state is CommunityListingErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state is CommunityListingLoadedState) {
              communities.addAll(state.paginatedCommunity.communities);
              setState(() {});
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                floating: true,
                snap: true,
                pinned: true,
                title: Text("Your communities"),
              ),
              SliverPadding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                sliver:
                    BlocBuilder<CommunityListingCubit, CommunityListingState>(
                      builder: (context, state) {
                        return SliverList.separated(
                          itemCount: communities.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final community = communities[index];
                            return ListTile(
                              isThreeLine: true,
                              leading: Container(
                                padding: EdgeInsets.all(16),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  image: community.profilePicture == null
                                      ? null
                                      : DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            community.profilePicture!,
                                          ),
                                        ),
                                ),
                                child: Center(
                                  child: community.profilePicture == null
                                      ? Text(
                                          community.name[0],
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleSmall,
                                        )
                                      : null,
                                ),
                              ),
                              title: Text(community.name),
                              subtitle: Text(
                                community.description ??
                                    "No description available",
                              ),
                              subtitleTextStyle: Theme.of(
                                context,
                              ).textTheme.bodySmall,
                              contentPadding: EdgeInsets.zero,
                              onTap: () => CommunitiesRoute(
                                communityId: community.id.toString(),
                              ).push(context),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 0,
                                    child: Text("View community"),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: Text("Leave community"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MembershipTile extends StatelessWidget {
  final ChirpCommunityMembership membership;

  const MembershipTile({super.key, required this.membership});

  @override
  Widget build(BuildContext context) {
    final joinedAtFormatted = DateFormat(
      'EEEE, MMM d, y • h:mm a',
    ).format(membership.joinedAt);

    final isBanned = membership.banned;

    return Slidable(
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            onPressed: (context) {},
            icon: Icons.group_remove,
            label: "Leave Community",
          ),
          SlidableAction(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            onPressed: (context) {
              CommunitiesRoute(
                communityId: membership.communityID.toString(),
              ).push(context);
            },
            icon: Icons.open_in_new,
            label: "View Community",
          ),
        ],
      ),
      key: ValueKey(membership.id),

      child: ListTile(
        onTap: () {
          CommunitiesRoute(
            communityId: membership.communityID.toString(),
          ).push(context);
        },
        leading: Icon(
          isBanned ? Icons.block : Icons.group,
          color: isBanned ? Colors.red : Colors.green,
        ),
        title: Text(membership.role.toUpperCase()),
        isThreeLine: isBanned,
        subtitle: Text(
          "Joined on $joinedAtFormatted"
          "${isBanned ? '\nBanned: ${membership.bannedReason ?? 'No reason given'}' : ''}",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isBanned ? Colors.redAccent : Colors.grey[700],
          ),
        ),
        trailing: Icon(
          isBanned ? Icons.warning_amber_rounded : Icons.verified_outlined,
          color: isBanned
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
