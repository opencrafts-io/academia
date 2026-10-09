import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'rewards_cubit.dart';

class RewardDetailsPage extends StatelessWidget {
  const RewardDetailsPage({
    super.key,
    required this.id,
    this.isActivity = false,
  });

  final String id;
  final bool isActivity;

  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData.from(
      colorScheme: Theme.of(context).colorScheme,
      textTheme: Theme.of(context).textTheme,
      useMaterial3: true,
    ),
    child: BlocProvider(
      create: (_) => GetIt.instance<RewardsCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(isActivity ? 'Activity' : 'Milestone')),
        body: BlocBuilder<RewardsCubit, RewardsState>(
          builder: (context, state) => state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton.tonalIcon(
                      onPressed: context.read<RewardsCubit>().load,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            ),
            loaded: (overview) {
              final title = isActivity
                  ? overview.activities
                        .where((activity) => activity.id == id)
                        .map((activity) => activity.name)
                        .firstOrNull
                  : overview.milestones
                        .where((milestone) => milestone.id == id)
                        .map((milestone) => milestone.title)
                        .firstOrNull;
              final description = isActivity
                  ? overview.activities
                        .where((activity) => activity.id == id)
                        .map((activity) => activity.description)
                        .firstOrNull
                  : overview.milestones
                        .where((milestone) => milestone.id == id)
                        .map((milestone) => milestone.description)
                        .firstOrNull;
              final points = isActivity
                  ? overview.activities
                        .where((activity) => activity.id == id)
                        .map((activity) => activity.pointsAwarded)
                        .firstOrNull
                  : overview.milestones
                        .where((milestone) => milestone.id == id)
                        .map((milestone) => milestone.bonusPoints)
                        .firstOrNull;

              if (title == null) {
                return const Center(
                  child: Text('This reward is no longer active.'),
                );
              }

              final theme = Theme.of(context);
              final colors = theme.colorScheme;
              final foreground = isActivity
                  ? colors.onPrimaryContainer
                  : colors.onTertiaryContainer;

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Card.filled(
                      color: isActivity
                          ? colors.primaryContainer
                          : colors.tertiaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                color: colors.surface.withValues(alpha: .72),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Icon(
                                isActivity
                                    ? Icons.bolt_rounded
                                    : Icons.workspace_premium_rounded,
                                size: 46,
                                color: isActivity
                                    ? colors.onPrimaryContainer
                                    : colors.onTertiaryContainer,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: foreground,
                              ),
                            ),
                            if (description?.isNotEmpty ?? false) ...[
                              const SizedBox(height: 10),
                              Text(
                                description!,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: foreground,
                                ),
                              ),
                            ],
                            if (points != null) ...[
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.surface.withValues(alpha: .72),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  '+$points points',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}
