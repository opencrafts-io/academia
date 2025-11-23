import 'package:academia/features/streaks/streaks.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AchievementDetailPage extends StatelessWidget {
  const AchievementDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AchievementDetailBloc>()..add(LoadAchievementDetail(id)),
      child: const AchievementDetailView(),
    );
  }
}

class AchievementDetailView extends StatelessWidget {
  const AchievementDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AchievementDetailBloc, AchievementDetailState>(
        builder: (context, state) {
          if (state is AchievementDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AchievementDetailError) {
            return Center(child: Text(state.message));
          } else if (state is AchievementDetailLoaded) {
            final achievement = state.achievement;
            final activity = state.activity;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/locked-badge.png",
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      achievement.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      achievement.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${achievement.bonusPoints}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              'Bonus Points',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${achievement.daysRequired}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              'Days Required',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (activity != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Card(
                          elevation: 0,
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: ListTile(
                            title: Text(activity.name),
                            subtitle: Text(activity.description ?? ''),
                            onTap: () {
                              context.push('/activities/${activity.id}');
                            },
                          ),
                        ),
                      )
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
