import 'package:academia/features/streaks/streaks.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AchievementsHomePage extends StatelessWidget {
  const AchievementsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AchievementsBloc>()..add(LoadAchievements()),
      child: const AchievementsView(),
    );
  }
}

class AchievementsView extends StatefulWidget {
  const AchievementsView({super.key});

  @override
  State<AchievementsView> createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AchievementsBloc>().add(RefreshAchievements());
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar.medium(title: const Text("Achievements")),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Build your reputation. "
                  "Earn badges to be featured your profile on the leaderboard",
                ),
              ),
            ),
            BlocBuilder<AchievementsBloc, AchievementsState>(
              builder: (context, state) {
                if (state is AchievementsLoading) {
                  return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
                } else if (state is AchievementsError) {
                  return SliverToBoxAdapter(child: Center(child: Text(state.message)));
                } else if (state is AchievementsLoaded) {
                  return SliverPadding(
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
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<AchievementsBloc>().add(LoadMoreAchievements());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
