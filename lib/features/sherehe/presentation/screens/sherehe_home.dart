import 'package:academia/features/sherehe/presentation/widgets/event_card_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/constants/constants.dart';
import '../../../../config/router/routes.dart';
import '../bloc/event_bloc.dart';

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
    context.read<EventBloc>().add(FetchAllEvents(limit: 2));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final state = context.read<EventBloc>().state;
        if (state is EventLoaded && !state.hasReachedEnd) {
          context.read<EventBloc>().add(
            FetchAllEvents(isLoadMore: true, limit: 2),
          );
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search events, places...',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      // Clear search logic to be implemented later
                    },
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Text(
                'Upcoming Events',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: BlocBuilder<EventBloc, EventState>(
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
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Text("Failed to load events."),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }
              },
            ),
          ),
          BlocBuilder<EventBloc, EventState>(
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
