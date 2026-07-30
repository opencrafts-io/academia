import 'package:academia/config/router/routes.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class CommunityActionSection extends StatelessWidget {
  const CommunityActionSection({super.key, required this.communityID});
  final int communityID;

  void _showBlockCommunityDialog(BuildContext context, String communityName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Block Community?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to block $communityName?'),
            const SizedBox(height: 16),
            Text(
              '• You won\'t see posts from this community\n'
              '• You can unblock it anytime from settings',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<BlockBloc>().add(
                BlockCommunityEvent(communityId: communityID),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Blocked $communityName'),
                  behavior: SnackBarBehavior.floating,
                ),
              );

              //Navigate to home page
              context.go('/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  void _showReportCommunityDialog(BuildContext context) {
    String? selectedReason;
    final TextEditingController customReasonController =
        TextEditingController();

    final reasons = [
      'Inappropriate content',
      'Harassment or hate speech',
      'Spam community',
      'Violates platform rules',
      'Other',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => StatefulBuilder(
        builder: (context, setState) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 1.0,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Report Community',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: RadioGroup(
                      onChanged: (val) {
                        setState(() => selectedReason = val.toString());
                      },
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(20),
                        children: [
                          Text(
                            'Why are you reporting this community?',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 16),
                          ...reasons.map((reason) {
                            final isSelected = selectedReason == reason;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: RadioListTile.adaptive(
                                value: reason,
                                title: Text(reason),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).dividerColor,
                                  ),
                                ),
                              ),
                            );
                          }),
                          if (selectedReason == 'Other') ...[
                            const SizedBox(height: 16),
                            TextField(
                              controller: customReasonController,
                              maxLines: 4,
                              maxLength: 500,
                              decoration: InputDecoration(
                                hintText: 'Please provide more details...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        top: BorderSide(color: Theme.of(context).dividerColor),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: selectedReason == null
                            ? null
                            : () {
                                final reason = selectedReason == 'Other'
                                    ? customReasonController.text.trim()
                                    : selectedReason!;

                                if (reason.isEmpty) return;

                                context.read<ReportBloc>().add(
                                  ReportContentEvent(
                                    reportType: 'community',
                                    entityId: communityID.toString(),
                                    reason: reason,
                                  ),
                                );

                                Navigator.pop(context);

                                ScaffoldMessenger.of(
                                  bottomSheetContext,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Post reported successfully.',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onError,
                        ),
                        child: const Text('Submit Report'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      ChirpCommunityMembershipCubit,
      ChirpCommunityMembershipState
    >(
      listener: (context, state) {
        if (state is ChirpCommunityMembershipCommunityLeftState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You've successfully left the community."),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ChirpCommunityMembershipStateLoadingState ||
            state is ChirpCommunityMembershipInitialState) {
          return Padding(
            padding: EdgeInsets.all(12),
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is ChirpCommunityMembershipLoadedState) {
          return IconButton(
            onPressed: () {
              final cubit = context.read<ChirpCommunityMembershipCubit>();
              final communityHomeBloc = context.read<CommunityHomeBloc>();

              final communityState = communityHomeBloc.state;
              final communityName = communityState is CommunityHomeLoaded
                  ? communityState.community.name
                  : 'this community';

              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                isScrollControlled: true,
                builder: (modalContext) => DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.4,
                  maxChildSize: 0.9,
                  expand: false,
                  builder: (context, scrollController) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          "More community actions",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Divider(),
                        const SizedBox(height: 12),
                        Visibility(
                          visible:
                              state.membership.role == "super-mod" ||
                              state.membership.role == "mod",
                          child: ListTile(
                            onTap: () {
                              EditCommunityInfoRoute(
                                communityId: communityID,
                              ).push(context);
                            },
                            leading: const Icon(Icons.edit),
                            title: const Text("Edit community information"),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.add_box_outlined),
                          title: const Text("Add post"),
                          onTap: () {
                            final communityState = communityHomeBloc.state;
                            final router = GoRouter.of(context);

                            // Close modal
                            Navigator.of(modalContext).pop();

                            // FeedBloc's own _onCreatePost handler updates
                            // the feed reactively on success, so there's
                            // nothing to do with the pushed route's result -
                            // the PostCreated BlocListener elsewhere already
                            // shows the confirmation snackbar.
                            if (communityState is CommunityHomeLoaded) {
                              router.push(
                                AddPostRoute().location,
                                extra: communityState.community,
                              );
                            }
                          },
                        ),

                        // Share Community
                        ListTile(
                          leading: const Icon(Icons.share_outlined),
                          title: const Text("Share Community"),
                          onTap: () {
                            Navigator.pop(modalContext);
                            final url =
                                'https://academia.opencrafts.io${CommunitiesRoute(communityId: communityID).location}';
                            final box =
                                context.findRenderObject() as RenderBox?;
                            Share.share(
                              '$communityName\n\n'
                              'Join this community on Academia\n'
                              '$url',
                              sharePositionOrigin: box != null
                                  ? box.localToGlobal(Offset.zero) & box.size
                                  : null,
                            );
                          },
                        ),

                        // Block Community
                        ListTile(
                          leading: const Icon(Icons.block_outlined),
                          title: const Text("Block Community"),
                          onTap: () {
                            Navigator.pop(modalContext);
                            _showBlockCommunityDialog(context, communityName);
                          },
                        ),

                        // Report Community
                        ListTile(
                          leading: const Icon(Icons.flag_outlined),
                          title: const Text("Report Community"),
                          onTap: () {
                            Navigator.pop(modalContext);
                            _showReportCommunityDialog(context);
                          },
                        ),

                        ListTile(
                          leading: const Icon(Icons.groups_2),
                          title: const Text("View community members"),
                          onTap: () {
                            CommunityMembersRoute(
                              role: "user",
                              communityId: communityID,
                            ).push(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.exit_to_app),
                          title: const Text("Leave community"),
                          onTap: () {
                            context.pop();
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => AlertDialog.adaptive(
                                title: const Text(
                                  "Are you sure you want to leave? ",
                                ),
                                content: const Text(
                                  "By leaving you will no longer recieve"
                                  "updates from this community nor see posts"
                                  " from this community",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                      cubit.leaveCommunity(
                                        communityID: communityID,
                                      );
                                    },
                                    child: const Text("Im sure"),
                                  ),

                                  FilledButton(
                                    onPressed: () => context.pop(),
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Visibility(
                          visible: state.membership.role == "super-mod",
                          child: ListTile(
                            onTap: () {
                              showAdaptiveDialog(
                                context: context,
                                builder: (context) => AlertDialog.adaptive(
                                  title: const Text("Delete this community"),
                                  content: const Text(
                                    "Are yout absolutely sure you want to delete "
                                    "this community? "
                                    "This is a permanent irreversible action. "
                                    "All associated content, including all posts,"
                                    "chats, images and membership data will be "
                                    "instantly and permanently removed."
                                    "This community cannot be resored. \n\n"
                                    "Proceed only if you understand and accept the"
                                    " outcome.",
                                  ),
                                  actions: [
                                    TextButton.icon(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                      ),
                                      onPressed: () async {
                                        context.pop();
                                        BlocProvider.of<CommunityHomeBloc>(
                                          context,
                                        ).add(
                                          DeleteCommunity(
                                            communityID: communityID,
                                          ),
                                        );
                                        context.pop();
                                      },
                                      label: const Text("Im sure delete it"),
                                    ),
                                    FilledButton(
                                      onPressed: () => context.pop(),
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            leading: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            title: const Text("Delete community"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.more_vert),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FilledButton(
            onPressed: () {
              final cubit = context.read<ChirpCommunityMembershipCubit>();
              showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: const Text("Are you sure you want to join?"),
                  content: const Text(
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
                      child: const Text("Never mind"),
                    ),
                    FilledButton(
                      onPressed: () {
                        cubit.joinCommunity(communityID: communityID);
                        context.pop();
                      },
                      child: const Text("Join Now"),
                    ),
                  ],
                ),
              );
            },
            child: const Text("Join"),
          ),
        );
      },
    );
  }
}
