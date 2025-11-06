import 'package:academia/features/features.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:intl/intl.dart';

class LeaderboardHomepage extends StatefulWidget {
  const LeaderboardHomepage({super.key});

  @override
  State<LeaderboardHomepage> createState() => _LeaderboardHomepageState();
}

class _LeaderboardHomepageState extends State<LeaderboardHomepage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<LeaderboardBloc>().add(const LoadLeaderboard());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<LeaderboardBloc>().add(const LoadMoreLeaderboard());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverPinnedHeader(
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Global Vibe Rank",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: BlocBuilder<LeaderboardBloc, LeaderboardState>(
            builder: (context, state) {
              if (state is LeaderboardLoading) {
                return SliverFillRemaining(
                  child: Column(children: [Text("Loading")]),
                );
              } else if (state is LeaderboardError) {
                return SliverFillRemaining(
                  child: Column(
                    children: [
                      Text(state.message),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<LeaderboardBloc>().add(
                          const LoadLeaderboard(),
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state is LeaderboardLoaded) {
                return SliverList.builder(
                  itemCount: state.entries.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.entries.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final entry = state.entries[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                      title: Text(
                        "${entry.vibeRank}. ${entry.username ?? 'Anon'}",
                        style: Theme.of(context).listTileTheme.titleTextStyle
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      leading: ClipPath(
                        clipper: ScallopClipper(
                          scallopDepth: 2,
                          numberOfScallops: 12,
                        ),
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            entry.avatarUrl ??
                                'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg',
                          ),
                        ),
                      ),

                      trailing: Text(
                        NumberFormat.compact().format(entry.vibePoints),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    );
                  },
                );
              }
              return SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ),
      ],
    );
  }
}
