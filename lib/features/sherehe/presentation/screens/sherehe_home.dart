import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/widgets/event_card_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/constants/constants.dart';
import '../bloc/sherehe_home_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ShereheHome extends StatefulWidget {
  const ShereheHome({super.key});

  @override
  State<ShereheHome> createState() => _ShereheHomeState();
}

class _ShereheHomeState extends State<ShereheHome>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  bool get wantKeepAlive => true;

  int _getCrossAxisCount(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) return 1;
    if (ResponsiveBreakPoints.isTablet(context)) return 2;
    return 3;
  }

  double _getMainAxisExtent(BuildContext context) {
    return ResponsiveBreakPoints.isMobile(context) ? 440 : 500;
  }

  @override
  void initState() {
    super.initState();
    context.read<ShereheHomeBloc>().add(FetchAllEvents(page: _currentPage));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final state = context.read<ShereheHomeBloc>().state;
      if (state is EventLoaded && state.hasMore) {
        _currentPage++;
        context.read<ShereheHomeBloc>().add(
          FetchAllEvents(page: _currentPage, isLoadMore: true),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _currentPage = 1;
          context.read<ShereheHomeBloc>().add(
            FetchAllEvents(page: _currentPage),
          );
          await Future.delayed(const Duration(seconds: 2));
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPinnedHeader(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Text(
                  "Upcoming Events",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: BlocBuilder<ShereheHomeBloc, ShereheHomeState>(
                builder: (context, state) {
                  List<Event> events = [];
                  if (state is EventLoaded) {
                    events = state.events;
                  } else if (state is EventsPaginationLoading) {
                    events = state.existingEvents;
                  } else if (state is EventsPaginationError) {
                    events = state.existingEvents;
                  }
                  if (state is EventLoading) {
                    return const SliverFillRemaining(
                      child: Center(child: SpinningScallopIndicator()),
                    );
                  }

                  if (state is EventsError && _currentPage == 1) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline, size: 48),
                            const SizedBox(height: 12),
                            Text(
                              state.message,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ShereheHomeBloc>().add(
                                  FetchAllEvents(page: 1),
                                );
                              },
                              child: const Text("Retry"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Empty events on first load
                  if (events.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.celebration,
                              size: 80,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              "It’s a little quiet here 🎶",
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "You've worked hard — now create your first Sherehe!",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return MultiSliver(
                    children: [
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _getCrossAxisCount(context),
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.7,
                          mainAxisExtent: _getMainAxisExtent(context),
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return EventCardWrapper(event: events[index]);
                        }, childCount: events.length),
                      ),
                      if (state is EventsPaginationLoading)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(child: SpinningScallopIndicator()),
                          ),
                        ),
                      if (state is EventsPaginationError)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 24),
                            child: Center(
                              child: TextButton.icon(
                                onPressed: () {
                                  context.read<ShereheHomeBloc>().add(
                                    FetchAllEvents(
                                      page: _currentPage,
                                      isLoadMore: true,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text("Retry loading more events"),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => CreateEventRoute().push(context),
        tooltip: "Create Event",
        child: const Icon(Icons.add),
      ),
    );
  }
}
