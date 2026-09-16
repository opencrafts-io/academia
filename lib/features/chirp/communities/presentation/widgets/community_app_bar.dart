import 'package:academia/config/router/routes.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// The community screen's collapsing header: avatar/name/member-count (tap
/// to view guidelines), the pinned description, and the overflow action
/// menu - combined into one [MultiSliver] so [NestedScrollView]'s
/// `headerSliverBuilder` sees it as a single list entry.
class CommunityAppBar extends StatelessWidget {
  const CommunityAppBar({
    super.key,
    required this.community,
    required this.communityId,
  });

  final Community community;
  final int communityId;

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(HomeRoute().location);
    }
  }

  void _showGuidelines(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Community guidelines",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Divider(),
              community.guidelines.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: community.guidelines.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: Text((index + 1).toString()),
                          title: Text(community.guidelines[index]),
                        ),
                      ),
                    )
                  : const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No community guidelines"
                        " were provided by the mods",
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverAppBar.medium(
          centerTitle: false,
          titleSpacing: 0,
          leading: BackButton(onPressed: () => _goBack(context)),
          title: GestureDetector(
            onTap: () => _showGuidelines(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: community.profilePictureUrl == null
                      ? null
                      : CachedNetworkImageProvider(
                          community.profilePictureUrl!,
                          errorListener: (error) {},
                        ),
                  child: community.profilePictureUrl == null
                      ? Text(community.name[0])
                      : null,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(community.name),
                    Text(
                      "${NumberFormat.compact().format(community.memberCount)} members",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Builder(
              builder: (context) =>
                  CommunityActionSection(communityID: communityId),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: MultiSliver(
            pushPinnedChildren: true,
            children: [
              SliverPinnedHeader(
                child: Text(
                  community.description ?? 'No description available',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
