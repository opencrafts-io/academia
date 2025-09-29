import 'package:academia/features/sherehe/presentation/widgets/event_card_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/constants/constants.dart';
import '../../../../config/router/routes.dart';
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

  int _getCrossAxisCount(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) {
      return 1;
    } else if (ResponsiveBreakPoints.isTablet(context)) {
      return 2;
    } else {
      return 3;
    }
  }

  double _getMainAxisExtent(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) {
      return 440;
    } else {
      return 500; // large desktop
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<ShereheHomeBloc>().add(FetchAllEvents());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final state = context.read<ShereheHomeBloc>().state;
        if (state is EventLoaded && !state.hasReachedEnd) {
          context.read<ShereheHomeBloc>().add(FetchAllEvents(isLoadMore: true));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Prevent home page from rebuilding this page every time
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPinnedHeader(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Text(
                'Upcoming Events',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: BlocConsumer<ShereheHomeBloc, ShereheHomeState>(
              listener: (context, state) {
                if (state is EventError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 5),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is EventLoading && state is! EventLoaded) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                } else if (state is EventLoaded) {
                  final events = state.events;

                  if (events.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 64.0,
                          horizontal: 16.0,
                        ),
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
                                "You've worked so hard during the week, just close that laptop na let's create a sherehe 😂",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  // If events exist, show grid
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(context),
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: 0.7,
                      mainAxisExtent: _getMainAxisExtent(context),
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final event = events[index];
                      return EventCardWrapper(event: event);
                    }, childCount: events.length),
                  );
                } else if (state is EventError) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 48.0,
                        horizontal: 16.0,
                      ),
                      child: Center(
                        child: Card(
                          elevation: 2,
                          color: Theme.of(context).colorScheme.errorContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 48,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onErrorContainer,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  state.message,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onErrorContainer,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Something went wrong while fetching your events.\nPlease try again later.",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer
                                            .withValues(alpha: 0.9),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }
              },
            ),
          ),
          BlocBuilder<ShereheHomeBloc, ShereheHomeState>(
            builder: (context, state) {
              if (state is EventLoaded && !state.hasReachedEnd) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CreateEventRoute().push(context),
        tooltip: 'Create Event',
        child: const Icon(Icons.add),
      ),
    );
  }
}
