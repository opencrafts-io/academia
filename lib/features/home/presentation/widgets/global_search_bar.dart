import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';

class GlobalSearchBar extends StatefulWidget {
  const GlobalSearchBar({super.key});

  @override
  State<GlobalSearchBar> createState() => _GlobalSearchBarState();
}

class _GlobalSearchBarState extends State<GlobalSearchBar> {
  int _currentTabIndex = 0;
  void _performSearch(BuildContext context, String query) {
    switch (_currentTabIndex) {
      case 0:
        debugPrint("Searching Posts for: $query");
        break;
      case 1:
        context.read<CommunityBloc>().add(
          SearchCommunityEvent(
            paginationParam: CommunityPaginatedEventParameter(
              pageSize: 100,
              page: 1,
            ),
            searchTerm: query,
          ),
        );
        break;
      case 2:
        debugPrint("Searching Users for: $query");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      suggestionsBuilder: (context, searchController) {
        return [
          DefaultTabController(
            length: 3,
            child: Builder(
              builder: (tabContext) {
                final tabController = DefaultTabController.of(tabContext);
                tabController.addListener(() {
                  if (!tabController.indexIsChanging) {
                    setState(() {
                      _currentTabIndex = tabController.index;
                    });
                  }
                });
                return Column(
                  children: [
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorAnimation: TabIndicatorAnimation.elastic,
                      tabs: [
                        Tab(text: "Posts", icon: Icon(Icons.newspaper)),
                        Tab(text: "Communities", icon: Icon(Icons.group)),
                        Tab(text: "Users", icon: Icon(Icons.account_box)),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(tabContext).size.height * 0.8,
                      child: TabBarView(
                        children: [
                          // if (_currentTabIndex == 0)
                          _buildSearchPostSection(),
                          // else if (_currentTabIndex == 1)
                          _buildSearchCommunitiesSection(),
                          // else if (_currentTabIndex == 2)
                          _buildSearchFriendsSection(),
                          // else
                          // const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ];
      },
      barElevation: WidgetStatePropertyAll(0),
      barBackgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.primaryContainer,
      ),
      barHintText: "Search for posts, events, friends",
      barLeading: Icon(Icons.search),
      viewElevation: 0,
      isFullScreen: true,
      onChanged: (query) => _performSearch(context, query),
      shrinkWrap: true,
    );
  }

  Widget _buildSearchPostSection() {
    return Padding(
      padding: EdgeInsetsGeometry.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedEmoji(AnimatedEmojis.thinkingFace, size: 80),
          Text(
            "There's just that post ",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFriendsSection() {
    return Padding(
      padding: EdgeInsetsGeometry.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedEmoji(AnimatedEmojis.pleading, size: 80),
          Text(
            "Find your friends via academia",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCommunitiesSection() {
    return Padding(
      padding: EdgeInsetsGeometry.all(12),
      child: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (context, state) {
          if (state is CommunitiesRetrievedState) {
            if (state.retrieved.communities.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedEmoji(AnimatedEmojis.seeNoEvilMonkey, size: 80),
                  Text("Searched community does not exist!"),
                ],
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  ...state.retrieved.communities.map(
                    (community) => CommunitySearchCard(community: community),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            );
          } else if (state is CommunityLoadingState) {
            return Center(child: SpinningScallopIndicator());
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedEmoji(AnimatedEmojis.hugFace, size: 120),
              Text(
                "Find groups of people that share your interests.",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}

class CommunitySearchCard extends StatelessWidget {
  const CommunitySearchCard({super.key, required this.community});
  final Community community;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () async {
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate(
              pattern: [0, 50, 100, 128],
              intensities: [0, 100, 0, 128],
            );
          }

          if (!context.mounted) return;
          if (community.nsfw) {
            showAdaptiveDialog(
              context: context,
              builder: (context) => AlertDialog.adaptive(
                title: Text("Proceed"),
                content: Text(
                  "${community.name} is marked as Not Safe For Work, are you sure you want to continue.. ",
                ),
                actions: [
                  FilledButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text("Back to safety"),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pop();
                      CommunitiesRoute(
                        communityId: community.id.toString(),
                      ).push(context);
                    },
                    child: Text("Continue"),
                  ),
                ],
              ),
            );
          }
        },
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: community.banner ?? '',
                errorWidget: (context, error, child) => Image.asset(
                  "assets/illustrations/community.jpg",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                height: 200,
                fit: BoxFit.fill,
              ),
            ),

            ListTile(
              leading: CircleAvatar(
                backgroundImage: community.profilePictureUrl == null
                    ? null
                    : CachedNetworkImageProvider(
                        community.profilePictureUrl!,
                        errorListener: (error) {},
                      ),
                child: community.profilePictureUrl == null
                    ? Text(community.name[0])
                    : null,
              ),
              title: Row(
                children: [
                  Text(community.name),
                  Card.filled(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        "😈",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                community.description ?? 'No description available yet',
              ),
              subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
              trailing: Icon(Icons.open_in_new),
            ),
          ],
        ),
      ),
    );
  }
}
