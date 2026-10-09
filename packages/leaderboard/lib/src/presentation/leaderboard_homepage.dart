import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../domain/domain.dart';
import 'leaderboard_bloc.dart';

class LeaderboardHomepage extends StatefulWidget {
  const LeaderboardHomepage({super.key, this.accountId});

  final String? accountId;

  @override
  State<LeaderboardHomepage> createState() => _LeaderboardHomepageState();
}

class _LeaderboardHomepageState extends State<LeaderboardHomepage> {
  final ScrollController _fallbackScrollController = ScrollController();
  ScrollController? _scrollController;
  bool _aroundUser = false;

  @override
  void initState() {
    super.initState();
    context.read<LeaderboardBloc>().add(const LoadGlobalLeaderboard());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scrollController =
        PrimaryScrollController.maybeOf(context) ?? _fallbackScrollController;
    if (identical(_scrollController, scrollController)) return;
    _scrollController?.removeListener(_loadNextPageIfNeeded);
    _scrollController = scrollController..addListener(_loadNextPageIfNeeded);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_loadNextPageIfNeeded);
    _fallbackScrollController.dispose();
    super.dispose();
  }

  void _loadNextPageIfNeeded() {
    final scrollController = _scrollController;
    if (_aroundUser ||
        scrollController == null ||
        !scrollController.hasClients) {
      return;
    }
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent * .9) {
      final page = context.read<LeaderboardBloc>().state.maybeWhen(
        loaded: (page) => page,
        orElse: () => null,
      );
      if (page != null && page.hasNext) {
        context.read<LeaderboardBloc>().add(
          LoadGlobalLeaderboard(page: page.currentPage + 1, append: true),
        );
      }
    }
  }

  void _changeMode(bool aroundUser) {
    if (_aroundUser == aroundUser) return;
    setState(() => _aroundUser = aroundUser);
    if (aroundUser && widget.accountId != null) {
      context.read<LeaderboardBloc>().add(
        LoadLeaderboardAroundUser(widget.accountId!),
      );
    } else {
      context.read<LeaderboardBloc>().add(const LoadGlobalLeaderboard());
    }
  }

  void _reloadCurrentMode() {
    if (_aroundUser && widget.accountId != null) {
      context.read<LeaderboardBloc>().add(
        LoadLeaderboardAroundUser(widget.accountId!),
      );
    } else {
      context.read<LeaderboardBloc>().add(const LoadGlobalLeaderboard());
    }
  }

  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData.from(
      colorScheme: Theme.of(context).colorScheme,
      textTheme: Theme.of(context).textTheme,
      useMaterial3: true,
    ),
    child: RefreshIndicator.adaptive(
      onRefresh: () async {
        if (_aroundUser && widget.accountId != null) {
          context.read<LeaderboardBloc>().add(
            LoadLeaderboardAroundUser(widget.accountId!),
          );
        } else {
          context.read<LeaderboardBloc>().add(const LoadGlobalLeaderboard());
        }
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Leaderboard',
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  if (widget.accountId != null)
                    SegmentedButton<bool>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(value: false, label: Text('Global')),
                        ButtonSegment(value: true, label: Text('Around me')),
                      ],
                      selected: {_aroundUser},
                      onSelectionChanged: (selection) =>
                          _changeMode(selection.first),
                    ),
                ],
              ),
            ),
          ),
          BlocBuilder<LeaderboardBloc, LeaderboardState>(
            builder: (context, state) => state.when(
              initial: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              failure: (message) => SliverFillRemaining(
                child: _LeaderboardMessage(
                  icon: Icons.cloud_off_rounded,
                  title: 'The rankings took a detour',
                  message: message,
                  action: FilledButton.tonalIcon(
                    onPressed: _reloadCurrentMode,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Try again'),
                  ),
                ),
              ),
              loaded: (page) => _buildEntries(context, page),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildEntries(BuildContext context, LeaderboardPage page) {
    final entries = page.entries;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final podium = !_aroundUser && entries.length >= 3
        ? entries.take(3).toList()
        : const <LeaderboardEntry>[];
    final visibleEntries = podium.isEmpty ? entries : entries.skip(3).toList();

    return SliverList.list(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: _LeaderboardHero(
            aroundUser: _aroundUser,
            userPosition: page.userPosition,
            totalUsers: page.totalUsers,
          ),
        ),
        if (podium.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: _Podium(entries: podium),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _aroundUser ? 'Your neighborhood' : 'Climbing the ranks',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (page.totalUsers > 0)
                Text(
                  '${NumberFormat.compact().format(page.totalUsers)} players',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
        if (visibleEntries.isEmpty && podium.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              'No rankings to show yet. Check back soon!',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
          )
        else
          ...visibleEntries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: _LeaderboardTile(
                entry: entry,
                isCurrentUser: entry.id == widget.accountId,
              ),
            ),
          ),
        if (!_aroundUser && page.hasNext)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          ),
        const SizedBox(height: 28),
      ],
    );
  }
}

class _LeaderboardHero extends StatelessWidget {
  const _LeaderboardHero({
    required this.aroundUser,
    required this.userPosition,
    required this.totalUsers,
  });

  final bool aroundUser;
  final int? userPosition;
  final int totalUsers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Material(
      color: colors.primaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          PositionedDirectional(
            end: -30,
            top: -44,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 180,
              color: colors.onPrimaryContainer.withValues(alpha: .07),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.celebration_rounded, color: colors.primary),
                    const SizedBox(width: 8),
                    Text(
                      aroundUser
                          ? 'YOUR PLACE IN THE MIX'
                          : 'GOOD VIBES, BIG MOVES',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colors.onPrimaryContainer,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  aroundUser && userPosition != null
                      ? '#${NumberFormat.decimalPattern().format(userPosition)}'
                      : 'Every point\nputs you in play.',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: colors.onPrimaryContainer,
                    fontWeight: FontWeight.w800,
                    height: 1.04,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  aroundUser
                      ? 'You’re sharing the leaderboard with $totalUsers players.'
                      : '${NumberFormat.decimalPattern().format(totalUsers)} students are making their mark. Keep showing up!',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Podium extends StatelessWidget {
  const _Podium({required this.entries});

  final List<LeaderboardEntry> entries;

  @override
  Widget build(BuildContext context) {
    final ordered = [...entries]
      ..sort((a, b) => a.position.compareTo(b.position));
    final spotlightOrder = [ordered[1], ordered[0], ordered[2]];
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var index = 0; index < spotlightOrder.length; index++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: index == 1 ? 0 : 20),
              child: _PodiumSpotlight(
                entry: spotlightOrder[index],
                accent: switch (index) {
                  0 => colors.tertiaryContainer,
                  1 => colors.secondaryContainer,
                  _ => colors.primaryContainer,
                },
                label: switch (spotlightOrder[index].position) {
                  1 => '1ST',
                  2 => '2ND',
                  _ => '3RD',
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _PodiumSpotlight extends StatelessWidget {
  const _PodiumSpotlight({
    required this.entry,
    required this.accent,
    required this.label,
  });

  final LeaderboardEntry entry;
  final Color accent;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          child: _avatar(entry, 30),
        ),
        const SizedBox(height: 8),
        Text(
          entry.username ?? 'Student',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 3),
        Text(
          '${NumberFormat.compact().format(entry.vibePoints)} pts',
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(color: colors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  const _LeaderboardTile({required this.entry, required this.isCurrentUser});

  final LeaderboardEntry entry;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final foreground = isCurrentUser
        ? colors.onTertiaryContainer
        : colors.onSurface;
    final secondaryForeground = isCurrentUser
        ? colors.onTertiaryContainer.withValues(alpha: .82)
        : colors.onSurfaceVariant;

    return Card.filled(
      color: isCurrentUser
          ? colors.tertiaryContainer
          : colors.surfaceContainerLow,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 38,
              child: Text(
                '${entry.position}',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: secondaryForeground,
                ),
              ),
            ),
            const SizedBox(width: 12),
            _avatar(entry, 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.username ?? 'Student',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: foreground,
                    ),
                  ),
                  Text(
                    'Vibe rank ${entry.vibeRank}${isCurrentUser ? ' · You' : ''}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: secondaryForeground,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? colors.tertiary
                    : colors.secondaryContainer,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                '${NumberFormat.compact().format(entry.vibePoints)} pts',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isCurrentUser
                      ? colors.onTertiary
                      : colors.onSecondaryContainer,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _avatar(LeaderboardEntry entry, double radius) => ScallopedAvatar(
  label: entry.username ?? 'Student profile',
  image: entry.avatarUrl == null
      ? null
      : CachedNetworkImageProvider(entry.avatarUrl!),
  radius: radius,
);

class _LeaderboardMessage extends StatelessWidget {
  const _LeaderboardMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 52, color: colors.tertiary),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            if (action != null) ...[const SizedBox(height: 20), action!],
          ],
        ),
      ),
    );
  }
}
