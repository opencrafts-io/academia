import 'package:academia/features/features.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

/// The composer's "posting to" pill. Tapping it opens
/// [showCommunityPickerSheet].
class CommunityPickerButton extends StatelessWidget {
  final Community? community;
  final VoidCallback onPressed;

  /// Outline the pill in the error color: the user tried to post without
  /// choosing a community.
  final bool showError;

  const CommunityPickerButton({
    super.key,
    required this.community,
    required this.onPressed,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selected = community;

    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: colorScheme.surfaceContainerHigh,
        shape: StadiumBorder(
          side: showError
              ? BorderSide(color: colorScheme.error, width: 1.5)
              : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected != null)
                  CommunityAvatar(community: selected, radius: 14)
                else
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(
                      Icons.groups_rounded,
                      size: 16,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    selected == null
                        ? 'Choose a community'
                        : 'a/${selected.name}',
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: showError ? colorScheme.error : null,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommunityAvatar extends StatelessWidget {
  final Community community;
  final double radius;

  const CommunityAvatar({super.key, required this.community, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    final url = community.profilePictureUrl;
    return CircleAvatar(
      radius: radius,
      backgroundImage: url == null
          ? null
          : CachedNetworkImageProvider(url, errorListener: (_) {}),
      child: url == null
          ? Text(
              community.name.isEmpty ? '?' : community.name[0].toUpperCase(),
              style: TextStyle(fontSize: radius * 0.9),
            )
          : null,
    );
  }
}

/// Lets the user pick one of the communities they can post in. Resolves
/// with the chosen community, or null when dismissed.
Future<Community?> showCommunityPickerSheet(
  BuildContext context, {
  Community? selected,
}) {
  final listing = context.read<CommunityListingCubit>();
  // The cubit is shared app-wide; it may hold search results from elsewhere.
  final state = listing.state;
  if (state is! CommunityListingLoadedState || state.searchTerm != null) {
    listing.getPostableCommunities(page: 1);
  }

  return showModalBottomSheet<Community>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => BlocProvider.value(
      value: listing,
      child: _CommunityPickerSheet(selected: selected),
    ),
  );
}

class _CommunityPickerSheet extends StatefulWidget {
  final Community? selected;

  const _CommunityPickerSheet({this.selected});

  @override
  State<_CommunityPickerSheet> createState() => _CommunityPickerSheetState();
}

class _CommunityPickerSheetState extends State<_CommunityPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text('Post to', style: theme.textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (value) => setState(() => _query = value.trim()),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search your communities',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHigh,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<CommunityListingCubit, CommunityListingState>(
                builder: (context, state) => switch (state) {
                  CommunityListingLoadedState() => _results(
                    context,
                    state,
                    scrollController,
                  ),
                  CommunityListingErrorState(:final message) => _PickerError(
                    message: message,
                  ),
                  _ => const Center(child: LoadingIndicatorM3E()),
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _results(
    BuildContext context,
    CommunityListingLoadedState state,
    ScrollController scrollController,
  ) {
    final theme = Theme.of(context);
    final query = _query.toLowerCase();
    final communities = query.isEmpty
        ? state.communities
        : state.communities
              .where((c) => c.name.toLowerCase().contains(query))
              .toList();

    if (state.communities.isEmpty) {
      return const _PickerMessage(
        icon: Icons.group_add_outlined,
        title: "You haven't joined any communities yet",
        message: 'Join a community to start posting.',
      );
    }
    if (communities.isEmpty) {
      return _PickerMessage(
        icon: Icons.search_off_rounded,
        title: 'No communities match "$_query"',
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: communities.length + (state.hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        if (index == communities.length) {
          return Center(
            child: state.isLoadingMore
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: LoadingIndicatorM3E(),
                  )
                : TextButton(
                    onPressed: () => context
                        .read<CommunityListingCubit>()
                        .getPostableCommunities(page: 2),
                    child: const Text('Load more'),
                  ),
          );
        }
        final community = communities[index];
        final isSelected = community.id == widget.selected?.id;
        return ListTile(
          onTap: () => Navigator.pop(context, community),
          leading: CommunityAvatar(community: community),
          title: Text(community.name),
          subtitle: community.memberCount > 0
              ? Text(
                  '${community.memberCount} '
                  '${community.memberCount == 1 ? 'member' : 'members'}',
                )
              : null,
          trailing: isSelected
              ? Icon(Icons.check_rounded, color: theme.colorScheme.primary)
              : null,
          selected: isSelected,
        );
      },
    );
  }
}

class _PickerMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;

  const _PickerMessage({required this.icon, required this.title, this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
          if (message != null) ...[
            const SizedBox(height: 4),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PickerError extends StatelessWidget {
  final String message;

  const _PickerError({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 40,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 12),
          Text(
            "Couldn't load your communities",
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
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

/// "Where does this post go" state shared by the composer sheets. Starts from
/// the preselected community, else the last one posted to, else the only one
/// the user can post in. Wrap the sheet in [communityListener] so the
/// fallbacks apply once the user's communities load.
mixin PostCommunitySelection<T extends StatefulWidget> on State<T> {
  Community? selectedCommunity;

  /// Id of the community last posted to; cleared once the user picks one.
  int? _lastCommunityId;

  void initCommunitySelection(Community? preselected) {
    if (preselected != null) {
      selectedCommunity = preselected;
      return;
    }
    _loadLastCommunity();
  }

  Future<void> _loadLastCommunity() async {
    final listing = context.read<CommunityListingCubit>();
    final state = listing.state;
    if (state is! CommunityListingLoadedState || state.searchTerm != null) {
      listing.getPostableCommunities(page: 1);
    }
    final id = await LastPostCommunity.read();
    if (!mounted) return;
    _lastCommunityId = id;
    _restoreCommunity(listing.state);
  }

  void _restoreCommunity(CommunityListingState state) {
    if (selectedCommunity != null) return;
    if (state is! CommunityListingLoadedState || state.searchTerm != null) {
      return;
    }
    final communities = state.communities;
    final remembered = communities
        .where((c) => c.id == _lastCommunityId)
        .firstOrNull;
    final restored =
        remembered ?? (communities.length == 1 ? communities.single : null);
    if (restored != null) setState(() => selectedCommunity = restored);
  }

  Future<Community?> pickCommunity() async {
    final picked = await showCommunityPickerSheet(
      context,
      selected: selectedCommunity,
    );
    if (picked != null && mounted) {
      setState(() {
        selectedCommunity = picked;
        _lastCommunityId = null;
      });
    }
    return picked;
  }

  Widget communityListener({required Widget child}) =>
      BlocListener<CommunityListingCubit, CommunityListingState>(
        listener: (context, state) => _restoreCommunity(state),
        child: child,
      );
}
