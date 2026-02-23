import 'package:academia/config/config.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class _CommunitySearchCard extends StatelessWidget {
  const _CommunitySearchCard({super.key, required this.community});
  final Community community;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          if (community.nsfw) {
            showAdaptiveDialog(
              context: context,
              builder: (context) => AlertDialog.adaptive(
                title: Text("Proceed"),
                content: Text(
                  "${community.name} is marked as Not Safe For Work, are you sure you want to continue.. ",
                ),
                actions: [
                  FilledButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text("Back to safety"),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pop();
                      CommunitiesRoute(communityId: community.id).push(context);
                    },
                    child: Text("Continue"),
                  ),
                ],
              ),
            );
          } else {
            CommunitiesRoute(communityId: community.id).push(context);
          }
        },
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: community.banner ?? '',
                errorWidget: (context, error, child) => Assets
                    .icons
                    .userIconUserGroup
                    .image(width: 200, fit: BoxFit.cover),
                height: 200,
                fit: BoxFit.fill,
              ),
            ),

            ListTile(
              leading: CircleAvatar(
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
              title: Row(
                children: [
                  Text(community.name),
                  Visibility(
                    visible: community.nsfw,
                    child: Card.filled(
                      color: Theme.of(context).colorScheme.errorContainer,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "NSFW",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                community.description ?? 'No description available yet',
              ),
              subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
              trailing: Icon(Icons.open_in_new),
            ),
          ],
        ),
      ),
    );
  }
}


class GlobalSearchDelegate extends SearchDelegate<void> {
  GlobalSearchDelegate() : super(searchFieldLabel: 'Search communities...');

  void _performSearch(BuildContext context) {
    if (query.trim().isEmpty) return;
    context.read<CommunityListingCubit>().searchForCommunity(query, page: 1);
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.close),
        tooltip: 'Clear',
      ),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, null),
    icon: const Icon(Icons.arrow_back),
    tooltip: 'Back',
  );


  @override
  Widget buildResults(BuildContext context) {
    _performSearch(context);
    return _SearchBody(query: query);
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    _performSearch(context);
    return _SearchBody(query: query);
  }
}


class _SearchBody extends StatelessWidget {
  const _SearchBody({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    if (query.trim().isEmpty) {
      return _SearchEmptyPrompt();
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<CommunityListingCubit, CommunityListingState>(
        builder: (context, state) {
          if (state is CommunityListingLoadingState) {
            return const Center(child: LoadingIndicatorM3E());
          }

          if (state is CommunityListingLoadedState) {
            if (state.communities.isEmpty) {
              return _SearchNoResults();
            }

            return ListView.builder(
              itemCount: state.communities.length,
              itemBuilder: (context, index) => _CommunitySearchCard(
                community: state.communities[index],
              ),
            );
          }

          return _SearchEmptyPrompt();
        },
      ),
    );
  }
}


class _SearchEmptyPrompt extends StatelessWidget {
  const _SearchEmptyPrompt();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedEmoji(AnimatedEmojis.hugFace, size: 120),
        const SizedBox(height: 12),
        Text(
          'Find groups that share your interests',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SearchNoResults extends StatelessWidget {
  const _SearchNoResults();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedEmoji(AnimatedEmojis.seeNoEvilMonkey, size: 80),
        const SizedBox(height: 12),
        Text(
          'No communities found',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

