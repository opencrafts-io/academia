import 'package:academia/features/streaks/streaks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AchievementsTabView extends StatefulWidget {
  const AchievementsTabView({super.key});

  @override
  State<AchievementsTabView> createState() => _AchievementsTabViewState();
}

class _AchievementsTabViewState extends State<AchievementsTabView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<AchievementsBloc, AchievementsState>(
      builder: (context, state) {
        if (state is AchievementsLoading && state is! AchievementsLoadingMore) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AchievementsError) {
          return Center(child: Text(state.message));
        } else if (state is AchievementsLoaded) {
          return CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Build your reputation. "
                    "Earn badges to be featured your profile on the leaderboard",
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: state.achievements.length,
                  itemBuilder: (context, index) {
                    final achievement = state.achievements[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/achievements/${achievement.id}');
                      },
                      child: Card.filled(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/locked-badge.png",
                                height: 120,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                achievement.title,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (state is AchievementsLoadingMore)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
