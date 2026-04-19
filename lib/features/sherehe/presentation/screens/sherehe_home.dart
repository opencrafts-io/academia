import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  static const int adInterval = 3;
  String? _userEmail;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      _userEmail = profileState.profile.email;
    }
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

  void _resetAndReload() {
    _currentPage = 1;
    context.read<ShereheHomeBloc>().add(FetchAllEvents(page: _currentPage));
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
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
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

                  final List<Widget> slivers = [];

                  for (int i = 0; i < events.length; i += adInterval) {
                    final chunk = events.skip(i).take(adInterval).toList();

                    // Event Grid Chunk
                    slivers.add(
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: ShereheUtils.getCrossAxisCount(
                            context,
                          ),
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.7,
                          mainAxisExtent: ShereheUtils.getMainAxisExtent(
                            context,
                          ),
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return EventCardWrapper(event: chunk[index]);
                        }, childCount: chunk.length),
                      ),
                    );

                    // Banner Ad (skip after last chunk)
                    if (i + adInterval < events.length) {
                      slivers.add(
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: BannerAdWidget(size: AdSize.banner),
                            ),
                          ),
                        ),
                      );
                    }
                  }

                  if (state is EventsPaginationLoading) {
                    slivers.add(
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: SpinningScallopIndicator()),
                        ),
                      ),
                    );
                  }

                  if (state is EventsPaginationError) {
                    slivers.add(
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
                    );
                  }

                  return MultiSliver(children: slivers);
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await CreateEventRoute().push(context);

          if (!context.mounted) return;

          if (result is! Event) return;

          _resetAndReload();
          final maskedEmail = ShereheUtils.maskEmail(_userEmail ?? '');
          final scope = ScopeTypesX.fromBackend(result.scope);
          final isPrivateEvent = scope == ScopeTypes.private;

          if (isPrivateEvent) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;

              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_outline,
                            size: 32,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "Private Event Created",
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Your private event has been created successfully.\n\n"
                          "A secure link has been sent to:\n$maskedEmail\n\n"
                          "Please check your inbox to access it.",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text("Got it"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Event created successfully!"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        tooltip: "Create Event",
        child: const Icon(Icons.add),
      ),
    );
  }
}
