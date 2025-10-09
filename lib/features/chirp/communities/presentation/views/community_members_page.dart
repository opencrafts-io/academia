import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_since/time_since.dart';

class CommunityMembersPage extends StatefulWidget {
  final int communityID;
  final String role;

  const CommunityMembersPage({
    super.key,
    required this.communityID,
    required this.role,
  });

  @override
  State<CommunityMembersPage> createState() => _CommunityMembersPageState();
}

class _CommunityMembersPageState extends State<CommunityMembersPage> {
  String getTitle() {
    if (widget.role == "member") {
      return "Community Members";
    } else if (widget.role == "mod") {
      return "Community Moderators";
    } else if (widget.role == "banned") {
      return "Banned Users";
    }
    return "Community Memberships";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChirpCommunityMembershipListingCubit(
        getCommunityMembershipsUsecase: sl(),
      )..getCommunityMembers(communityID: widget.communityID),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              snap: true,
              pinned: true,
              floating: true,
              title: Text(getTitle()),
            ),

            SliverPadding(
              padding: EdgeInsetsGeometry.only(left: 2, right: 2, bottom: 16),
              sliver:
                  BlocConsumer<
                    ChirpCommunityMembershipListingCubit,
                    ChirpCommunityMembershipListingState
                  >(
                    listener: (context, state) {
                      if (state
                          is ChirpCommunityMembershipListingLoadingState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              spacing: 8,
                              children: [
                                SizedBox(
                                  height: 20,
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                                Text("Loading community users"),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is ChirpCommunityMembershipListingLoadedState) {
                        return SliverList.separated(
                          addAutomaticKeepAlives: true,
                          itemCount: state.memberships.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) => ListTile(
                            title: CommunityMembershipUserTile(
                              chirpCommunityMembership:
                                  state.memberships[index],
                            ),
                          ),
                        );
                      }
                      return SliverToBoxAdapter(child: SizedBox.shrink());
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommunityMembershipUserTile extends StatelessWidget {
  const CommunityMembershipUserTile({
    super.key,
    required this.chirpCommunityMembership,
  });
  final ChirpCommunityMembership chirpCommunityMembership;

  Widget buildRoleCard(BuildContext context) => Card.filled(
    child: Text(
      chirpCommunityMembership.role == "super-mod"
          ? "Owner"
          : chirpCommunityMembership.role == "mod"
          ? "mod"
          : "",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChirpUserCubit(
        getChirpUserByUsernameUsecase: sl(),
        getChirpUserByIdUsecase: sl(),
      )..getChirpUserByID(chirpCommunityMembership.userID),
      child: BlocBuilder<ChirpUserCubit, ChirpUserState>(
        builder: (context, state) {
          if (state is! ChirpUserLoadedState) {
            return SizedBox.shrink();
          }
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage: state.user.avatarUrl == null
                  ? null
                  : CachedNetworkImageProvider(state.user.avatarUrl!),
              child: state.user.avatarUrl == null
                  ? Text(state.user.username?[0].toUpperCase() ?? 'A')
                  : null,
            ),
            title: Text("@${state.user.username ?? 'Anonymous'}"),
            subtitle: Text(
              "Joined ${timeSince(chirpCommunityMembership.joinedAt)}",
            ),
            trailing: buildRoleCard(context),
          );
        },
      ),
    );
  }
}
