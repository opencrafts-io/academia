import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../domain/domain.dart';
import 'rewards_cubit.dart';

class RewardsHomePage extends StatelessWidget {
  const RewardsHomePage({super.key});

  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData.from(
      colorScheme: Theme.of(context).colorScheme,
      textTheme: Theme.of(context).textTheme,
      useMaterial3: true,
    ),
    child: BlocProvider(
      create: (_) => GetIt.instance<RewardsCubit>()..load(),
      child: const _RewardsView(),
    ),
  );
}

class _RewardsView extends StatelessWidget {
  const _RewardsView();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Points and rewards')),
    body: BlocBuilder<RewardsCubit, RewardsState>(
      builder: (context, state) => state.when(
        initial: () => const _RewardsLoading(),
        loading: () => const _RewardsLoading(),
        failure: (message) => _RewardsError(
          message: message,
          onRetry: context.read<RewardsCubit>().load,
        ),
        loaded: (overview) => RefreshIndicator.adaptive(
          onRefresh: context.read<RewardsCubit>().load,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                children: [
                  _PointsHero(points: overview.account.vibePoints),
                  const SizedBox(height: 28),
                  _SectionHeading(
                    icon: Icons.local_fire_department_rounded,
                    title: 'Your streaks',
                    subtitle: 'Little steps add up to big momentum.',
                  ),
                  const SizedBox(height: 12),
                  _StreaksSection(streaks: overview.streaks),
                  const SizedBox(height: 28),
                  _SectionHeading(
                    icon: Icons.bolt_rounded,
                    title: 'Ways to earn',
                    subtitle: 'Pick a good thing and keep your rhythm.',
                  ),
                  const SizedBox(height: 12),
                  if (overview.activities.isEmpty)
                    const _EmptyCard(
                      icon: Icons.spa_outlined,
                      message:
                          'No activities right now. New ones will bloom here.',
                    )
                  else
                    ...overview.activities.map(
                      (activity) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _ActivityCard(activity: activity),
                      ),
                    ),
                  const SizedBox(height: 18),
                  _SectionHeading(
                    icon: Icons.workspace_premium_rounded,
                    title: 'Milestones',
                    subtitle: 'Celebrate the progress you make along the way.',
                  ),
                  const SizedBox(height: 12),
                  if (overview.milestones.isEmpty)
                    const _EmptyCard(
                      icon: Icons.auto_awesome_outlined,
                      message:
                          'Your next milestone is waiting to be discovered.',
                    )
                  else
                    ...overview.milestones.map(
                      (milestone) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _MilestoneCard(milestone: milestone),
                      ),
                    ),
                  const SizedBox(height: 18),
                  _SectionHeading(
                    icon: Icons.history_rounded,
                    title: 'Recent wins',
                    subtitle: 'A little recap of what you’ve been up to.',
                  ),
                  const SizedBox(height: 12),
                  if (overview.history.isEmpty)
                    const _EmptyCard(
                      icon: Icons.auto_awesome,
                      message: 'Your completed activities will show up here.',
                    )
                  else
                    ...overview.history.map(
                      (completion) => _HistoryTile(completion: completion),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _PointsHero extends StatelessWidget {
  const _PointsHero({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Material(
      color: colors.tertiaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(36)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          PositionedDirectional(
            end: -26,
            top: -50,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 184,
              color: colors.onTertiaryContainer.withValues(alpha: .08),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.stars_rounded, color: colors.tertiary),
                    const SizedBox(width: 8),
                    Text(
                      'YOUR GOOD STUFF',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colors.onTertiaryContainer,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  NumberFormat.compact().format(points),
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: colors.onTertiaryContainer,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'points collected',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colors.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(alpha: .7),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite_rounded,
                        size: 18,
                        color: colors.tertiary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Every little effort counts',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colors.secondaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: colors.onSecondaryContainer),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StreaksSection extends StatelessWidget {
  const _StreaksSection({required this.streaks});

  final List<UserStreak> streaks;

  @override
  Widget build(BuildContext context) {
    if (streaks.isEmpty) {
      return const _EmptyCard(
        icon: Icons.local_fire_department_outlined,
        message: 'Start a streak with one small step today.',
      );
    }

    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return SizedBox(
      height: 152,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: streaks.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final streak = streaks[index];
          return SizedBox(
            width: 208,
            child: Card.filled(
              color: index.isEven
                  ? colors.secondaryContainer
                  : colors.primaryContainer,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      color: index.isEven
                          ? colors.onSecondaryContainer
                          : colors.onPrimaryContainer,
                    ),
                    const Spacer(),
                    Text(
                      streak.activityName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: index.isEven
                            ? colors.onSecondaryContainer
                            : colors.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${streak.currentStreak} day${streak.currentStreak == 1 ? '' : 's'}',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: index.isEven
                            ? colors.onSecondaryContainer
                            : colors.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      'Best: ${streak.longestStreak} days',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: index.isEven
                            ? colors.onSecondaryContainer
                            : colors.onPrimaryContainer,
                      ),
                    ),
                    if (streak.daysUntilNextMilestone > 0)
                      Text(
                        '${streak.daysUntilNextMilestone} days to next milestone',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: index.isEven
                              ? colors.onSecondaryContainer
                              : colors.onPrimaryContainer,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.activity});

  final EarnableActivity activity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card.filled(
      color: colors.surfaceContainerLow,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/activities/${activity.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  Icons.bolt_rounded,
                  color: colors.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (activity.description?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 3),
                      Text(
                        activity.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    '+${activity.pointsAwarded}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text('points', style: theme.textTheme.labelSmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  const _MilestoneCard({required this.milestone});

  final RewardMilestone milestone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card.filled(
      color: colors.surfaceContainerLow,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/achievements/${milestone.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.tertiaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: colors.onTertiaryContainer,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      milestone.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${milestone.daysRequired} day${milestone.daysRequired == 1 ? '' : 's'} · ${milestone.description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: colors.tertiaryContainer,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  '+${milestone.bonusPoints}',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colors.onTertiaryContainer,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.completion});

  final ActivityHistory completion;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final date = completion.createdAt?.toLocal();
    final dateLabel = date == null
        ? 'Completed'
        : MaterialLocalizations.of(context).formatMediumDate(date);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: CircleAvatar(
        backgroundColor: colors.secondaryContainer,
        foregroundColor: colors.onSecondaryContainer,
        child: const Icon(Icons.check_rounded),
      ),
      title: Text(completion.activityName ?? 'Activity'),
      subtitle: Text(dateLabel),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colors.tertiaryContainer,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          '+${completion.pointsEarned}',
          style: theme.textTheme.labelLarge?.copyWith(
            color: colors.onTertiaryContainer,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color: colors.tertiary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardsLoading extends StatelessWidget {
  const _RewardsLoading();

  @override
  Widget build(BuildContext context) => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Gathering your good stuff…'),
      ],
    ),
  );
}

class _RewardsError extends StatelessWidget {
  const _RewardsError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, size: 52, color: colors.tertiary),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
