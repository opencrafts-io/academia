import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:time_since/time_since.dart';

/// Opens the "View votes" sheet for the poll on [postCubit]'s post.
/// The cubit is passed through so counts stay live while the sheet is open.
Future<void> showPollVotersSheet(
  BuildContext context, {
  required PostCubit postCubit,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) =>
        BlocProvider.value(value: postCubit, child: const PollVotersSheet()),
  );
}

class PollVotersSheet extends StatefulWidget {
  const PollVotersSheet({super.key});

  @override
  State<PollVotersSheet> createState() => _PollVotersSheetState();
}

class _PollVotersSheetState extends State<PollVotersSheet> {
  static const int _pageSize = 20;

  final GetPollVotersUsecase _getVoters = sl<GetPollVotersUsecase>();

  /// null = every voter.
  int? _optionId;
  final List<PollVoter> _voters = [];
  int _page = 1;
  bool _hasMore = false;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load(reset: true);
  }

  Poll? get _poll => context.read<PostCubit>().state.poll;

  /// Incremented on every reset so a response from a superseded filter is
  /// discarded instead of being rendered under the new chip.
  int _requestId = 0;

  Future<void> _load({bool reset = false}) async {
    final poll = _poll;
    if (poll == null) return;
    if (reset) {
      _requestId++;
      _page = 1;
      _voters.clear();
      _hasMore = false;
      _error = null;
    } else if (_loading) {
      return;
    }
    final requestId = _requestId;
    setState(() => _loading = true);

    final result = await _getVoters(
      pollId: poll.id,
      optionId: _optionId,
      page: _page,
      pageSize: _pageSize,
    );
    if (!mounted || requestId != _requestId) return;
    result.fold(
      (failure) => setState(() {
        _loading = false;
        _error = failure.message;
      }),
      (data) => setState(() {
        _loading = false;
        _voters.addAll(data.results);
        _hasMore = data.hasMore;
        _page++;
      }),
    );
  }

  void _selectOption(int? optionId) {
    if (_optionId == optionId) return;
    setState(() => _optionId = optionId);
    _load(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: BlocBuilder<PostCubit, Post>(
            buildWhen: (a, b) => a.poll != b.poll,
            builder: (context, post) {
              final poll = post.poll;
              if (poll == null) return const SizedBox.shrink();
              final options = poll.sortedOptions;
              final optionById = {for (final o in options) o.id: o};

              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(Icons.people_outline, color: colorScheme.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Votes',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                poll.question,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  if (poll.isAnonymous)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'This poll is anonymous — only you, as the '
                              'author, can see who voted.',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _filterChip(
                          label: 'All',
                          count: poll.totalVotes,
                          selected: _optionId == null,
                          onTap: () => _selectOption(null),
                        ),
                        for (final o in options)
                          _filterChip(
                            label: o.text,
                            count: o.voteCount,
                            selected: _optionId == o.id,
                            onTap: () => _selectOption(o.id),
                          ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: _buildList(
                      context,
                      scrollController,
                      optionById,
                      showChoices: _optionId == null && options.length > 1,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _filterChip({
    required String label,
    required int count,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text('$label · $count'),
        selected: selected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    ScrollController controller,
    Map<int, PollOption> optionById, {
    required bool showChoices,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_error != null && _voters.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off_rounded, size: 48, color: colorScheme.error),
              const SizedBox(height: 12),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                onPressed: () => _load(reset: true),
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }

    if (_loading && _voters.isEmpty) {
      return const Center(child: LoadingIndicatorM3E());
    }

    if (_voters.isEmpty) {
      return Center(
        child: Text(
          'No votes here yet',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (_hasMore &&
            !_loading &&
            n.metrics.pixels >= n.metrics.maxScrollExtent * 0.9) {
          _load();
        }
        return false;
      },
      child: ListView.builder(
        controller: controller,
        itemCount: _voters.length + (_hasMore || _error != null ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _voters.length) {
            if (_error != null) {
              return Center(
                child: TextButton.icon(
                  onPressed: _load,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry loading more'),
                ),
              );
            }
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: LoadingIndicatorM3E()),
            );
          }
          final voter = _voters[index];
          final choices = voter.optionIds
              .map((id) => optionById[id]?.text)
              .whereType<String>()
              .join(', ');
          return BlocProvider(
            key: ValueKey(voter.userId),
            create: (_) => sl<ChirpUserCubit>()..getChirpUserByID(voter.userId),
            child: _VoterTile(
              voter: voter,
              subtitle: showChoices && choices.isNotEmpty
                  ? '$choices • ${timeSince(voter.votedAt)}'
                  : timeSince(voter.votedAt),
            ),
          );
        },
      ),
    );
  }
}

class _VoterTile extends StatelessWidget {
  final PollVoter voter;
  final String subtitle;

  const _VoterTile({required this.voter, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChirpUserCubit, ChirpUserState>(
      builder: (context, state) {
        String avatarUrl =
            'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg';
        String username = 'Unknown User';
        if (state is ChirpUserLoadedState) {
          avatarUrl = state.user.avatarUrl ?? avatarUrl;
          username = state.user.username ?? username;
        }
        return ListTile(
          leading: ChirpUserAvatar(avatarUrl: avatarUrl, numberOfScallops: 6),
          title: Text(username, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          dense: true,
        );
      },
    );
  }
}
