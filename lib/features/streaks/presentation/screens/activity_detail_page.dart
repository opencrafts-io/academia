import 'package:academia/features/streaks/streaks.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityDetailPage extends StatelessWidget {
  const ActivityDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ActivityDetailBloc>()..add(LoadActivityDetail(id)),
      child: const ActivityDetailView(),
    );
  }
}

class ActivityDetailView extends StatelessWidget {
  const ActivityDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ActivityDetailBloc, ActivityDetailState>(
        builder: (context, state) {
          if (state is ActivityDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ActivityDetailError) {
            return Center(child: Text(state.message));
          } else if (state is ActivityDetailLoaded) {
            final activity = state.activity;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      activity.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      activity.description ?? '',
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
                              '${activity.pointsAwarded}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              'Points Awarded',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${activity.maxDailyCompletions}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              'Max Daily Completions',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
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
