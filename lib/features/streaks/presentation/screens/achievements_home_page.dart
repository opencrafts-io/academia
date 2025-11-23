import 'package:academia/features/streaks/streaks.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AchievementsHomePage extends StatelessWidget {
  const AchievementsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AchievementsBloc>()..add(LoadAchievements()),
        ),
        BlocProvider(
          create: (context) => sl<ActivitiesBloc>()..add(LoadActivities()),
        ),
      ],
      child: const AchievementsView(),
    );
  }
}

class AchievementsView extends StatefulWidget {
  const AchievementsView({super.key});

  @override
  State<AchievementsView> createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          if (_tabController.index == 0) {
            context.read<AchievementsBloc>().add(RefreshAchievements());
          } else {
            context.read<ActivitiesBloc>().add(RefreshActivities());
          }
        },
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text("Achievements"),
                pinned: true,
                floating: true,
                bottom: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: "Achievements"),
                    Tab(text: "Activities"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [
              AchievementsTabView(),
              ActivitiesTabView(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && _tabController.index == 0) {
      context.read<AchievementsBloc>().add(LoadMoreAchievements());
    } else if (_isBottom && _tabController.index == 1) {
      context.read<ActivitiesBloc>().add(LoadMoreActivities());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
