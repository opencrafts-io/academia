import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CommunityMembershipPage extends StatefulWidget {
  const CommunityMembershipPage({super.key});

  @override
  State<CommunityMembershipPage> createState() =>
      _CommunityMembershipPageState();
}

class _CommunityMembershipPageState extends State<CommunityMembershipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<ChirpCommunityMembershipBloc>().add(
            GetRemotePersonalChirpCommunityMembershipEvent(
              page: 1,
              pageSize: 100,
            ),
          );
          await Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: Text("Community memberships"),
              actions: [
                IconButton(
                  onPressed: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) => AlertDialog.adaptive(
                        title: Text("Help"),
                        content: Text(
                          "Here you can see all the communities you're part of. "
                          "To leave any community, just swipe it to the left. "
                          "Stay connected and enjoy engaging with your groups!",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(),
                            child: Text("Got It!"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(Icons.help_outline),
                ),
              ],
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              sliver: MultiSliver(
                children: [
                  BlocBuilder<
                    ChirpCommunityMembershipBloc,
                    ChirpCommunityMembershipState
                  >(
                    builder: (context, state) {
                      if (state is ChirpCommunityMembershipStateLoadingState) {
                        return Center(child: SpinningScallopIndicator());
                      }
                      if (state is ChirpCommunityMembershipStateLoadedState) {
                        if (state.memberships.isEmpty) {
                          return Text("Empty data");
                        }
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MembershipTile(
                              membership: state.memberships[index],
                            );
                          },
                          separatorBuilder: (index, state) => Divider(),
                          itemCount: state.memberships.length,
                        );
                      }
                      return Center(child: Text(state.runtimeType.toString()));
                    },
                  ),
                ],
              ),
            ),
            // SliverList.builder(),
          ],
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
