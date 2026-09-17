import 'package:academia/features/features.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class CommunitySearchField extends StatelessWidget {
  final SearchController searchController;
  final ValueChanged<Community> onCommunitySelected;

  const CommunitySearchField({
    super.key,
    required this.searchController,
    required this.onCommunitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      searchController: searchController,
      barElevation: WidgetStateProperty.all(0),
      barHintText: "Choose a community",
      barHintStyle: WidgetStateProperty.all(
        Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      barBackgroundColor: WidgetStateProperty.all(
        Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      barTextStyle: WidgetStatePropertyAll(
        Theme.of(context).textTheme.bodyLarge,
      ),
      barLeading: Icon(
        Icons.search_rounded,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      onTap: () => context.read<CommunityListingCubit>().getPostableCommunities(
        page: 1,
      ),
      suggestionsBuilder: (context, controller) {
        if (controller.text.trim().isNotEmpty) {
          context.read<CommunityListingCubit>().getPostableCommunities(
            page: 1,
          );
        }
        return [
          BlocBuilder<CommunityListingCubit, CommunityListingState>(
            builder: (context, state) {
              return switch (state) {
                CommunityListingLoadingState() => const _SearchLoading(),
                CommunityListingErrorState() => _SearchError(
                  message: state.message,
                ),
                CommunityListingLoadedState() => _SearchResults(
                  communities: state.communities,
                  onSelected: (community) {
                    onCommunitySelected(community);
                    controller.closeView(community.name);
                  },
                ),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ];
      },
    );
  }
}

class _SearchLoading extends StatelessWidget {
  const _SearchLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(child: LoadingIndicatorM3E()),
    );
  }
}

class _SearchError extends StatelessWidget {
  const _SearchError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.cloud_off_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Couldn't load communities: $message",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => context
                .read<CommunityListingCubit>()
                .getPostableCommunities(page: 1),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.communities, required this.onSelected});
  final List<Community> communities;
  final ValueChanged<Community> onSelected;

  @override
  Widget build(BuildContext context) {
    if (communities.isEmpty) {
      return ListTile(
        leading: Icon(
          Icons.search_off_rounded,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        title: const Text("No communities found, try joining one"),
      );
    }
    return Column(
      children: communities.map((community) {
        return ListTile(
          onTap: () => onSelected(community),
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
          title: Text(community.name),
          subtitle: Text(community.description ?? 'No description'),
        );
      }).toList(),
    );
  }
}
