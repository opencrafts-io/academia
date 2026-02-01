import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllScannersScreen extends StatefulWidget {
  final String eventId;

  const AllScannersScreen({super.key, required this.eventId});

  @override
  State<AllScannersScreen> createState() => _AllScannersScreenState();
}

class _AllScannersScreenState extends State<AllScannersScreen> {
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // context.read<AllScannersBloc>().add(
    //   FetchAllScanners(eventId: widget.eventId, page: _currentPage, limit: 20),
    // );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final state = context.read<AllScannersBloc>().state;
      if (state is AllScannersStateLoaded && state.hasMore) {
        _currentPage++;
        context.read<AllScannersBloc>().add(
          FetchAllScanners(
            eventId: widget.eventId,
            page: _currentPage,
            limit: 20,
          ),
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
    return Scaffold(
      body: BlocBuilder<AllScannersBloc, AllScannersState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar.large(
                title: const Text("All Scanners"),
                pinned: true,
              ),

              // INITIAL LOADING
              if (state is AllScannersStateLoading) ...[
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: SpinningScallopIndicator()),
                ),
              ]
              // INITIAL ERROR
              else if (state is AllScannersStateError) ...[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error,
                          size: 48,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 12),
                        Text(state.message),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () {
                            _currentPage = 1;
                            context.read<AllScannersBloc>().add(
                              FetchAllScanners(
                                eventId: widget.eventId,
                                page: _currentPage,
                                limit: 20,
                              ),
                            );
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
              // LOADED
              else if (state is AllScannersStateLoaded) ...[
                if (state.scanners.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.qr_code_scanner, size: 60),
                          SizedBox(height: 16),
                          Text("No scanners yet", textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  )
                else
                  SliverList.separated(
                    itemCount: state.scanners.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final scanner = state.scanners[index];

                      return UserTile(
                        name: scanner.user?.username ?? "Guest",
                        subtitle: scanner.role,
                        icon: Icons.qr_code_scanner,
                      );
                    },
                  ),
              ]
              // PAGINATION LOADING
              else if (state is AllScannersStatePaginationLoading) ...[
                SliverList.separated(
                  itemCount: state.existingScanners.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final scanner = state.existingScanners[index];

                    return UserTile(
                      name: scanner.user?.username ?? "Guest",
                      subtitle: scanner.role,
                      icon: Icons.qr_code_scanner,
                    );
                  },
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: SpinningScallopIndicator()),
                  ),
                ),
              ]
              // PAGINATION ERROR
              else if (state is AllScannersStatePaginationError) ...[
                SliverList.separated(
                  itemCount: state.existingScanners.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final scanner = state.existingScanners[index];

                    return UserTile(
                      name: scanner.user?.username ?? "Guest",
                      subtitle: scanner.role,
                      icon: Icons.qr_code_scanner,
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          state.message,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 10),
                        FilledButton(
                          onPressed: () => context.read<AllScannersBloc>().add(
                            FetchAllScanners(
                              eventId: widget.eventId,
                              page: _currentPage,
                              limit: 20,
                            ),
                          ),
                          child: const Text("Try Again"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
