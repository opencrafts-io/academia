// import 'package:academia/config/config.dart';
// import 'package:academia/constants/constants.dart';
// import 'package:academia/features/features.dart';
// import 'package:academia/features/permissions/permissions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sliver_tools/sliver_tools.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int selectedDrawerItem = 0;
//   String? userId;
//
//   @override
//   void initState() {
//     super.initState();
//     // Check both standard notification and precise alarm permissions
//     context.read<PermissionCubit>().checkMultiplePermissions([
//       AppPermission.notification,
//       AppPermission.preciseAlarm,
//     ]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: NavigationDrawer(
//         onDestinationSelected: (value) {
//           switch (value) {
//             case 1:
//               context.pop();
//               CreateCommunitiesRoute().push(context);
//               break;
//             case 2:
//               context.pop();
//               CommunityMembershipsRoute().push(context);
//               break;
//             case 3:
//               context.pop();
//               BlockedItemsRoute().push(context);
//             case 4:
//               context.pop();
//               PurchasedTicketsRoute().push(context);
//               break;
//             case 5:
//               context.pop();
//               OrganizedEventsRoute().push(context);
//               break;
//             default:
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text("Feature coming soon."),
//                   behavior: SnackBarBehavior.floating,
//                 ),
//               );
//           }
//         },
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Text(
//               "Chirp",
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ),
//           const NavigationDrawerDestination(
//             icon: Icon(Icons.newspaper_outlined),
//             selectedIcon: Icon(Icons.newspaper),
//             label: Text("View your posts"),
//           ),
//           const NavigationDrawerDestination(
//             selectedIcon: Icon(Icons.group_add),
//             icon: Icon(Icons.group_add_outlined),
//             label: Text("Create community"),
//           ),
//
//           const NavigationDrawerDestination(
//             icon: Icon(Icons.view_comfy_outlined),
//             selectedIcon: Icon(Icons.view_comfy),
//             label: Text("View your communities"),
//           ),
//
//           const NavigationDrawerDestination(
//             icon: Icon(Icons.block_outlined),
//             selectedIcon: Icon(Icons.block),
//             label: Text("View your block list"),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Text(
//               "Sherehe",
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ),
//           const NavigationDrawerDestination(
//             icon: Icon(Icons.confirmation_number_outlined),
//             selectedIcon: Icon(Icons.confirmation_number),
//             label: Text("All Tickets"),
//           ),
//           const NavigationDrawerDestination(
//             icon: Icon(Icons.event_note_outlined),
//             selectedIcon: Icon(Icons.event_note),
//             label: Text("My Organized Events"),
//           ),
//         ],
//       ),
//       body: DefaultTabController(
//         initialIndex: 1,
//         length: 3,
//         child: RefreshIndicator.adaptive(
//           onRefresh: () async {},
//           child: CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 pinned: true,
//                 floating: true,
//                 snap: true,
//                 stretch: false,
//                 centerTitle: true,
//                 title: const GlobalSearchBar(),
//                 actions: [
//                   IconButton(
//                     onPressed: () {
//                       ProfileRoute().push(context);
//                     },
//                     icon: const UserAvatar(scallopDepth: 4, numberOfScallops: 12),
//                   ),
//                 ],
//                 bottom: const TabBar(
//                   isScrollable: true,
//                   tabAlignment: TabAlignment.center,
//                   tabs: [
//                     Tab(child: Text("Leaderboard")),
//                     Tab(child: Text("For you")),
//                     Tab(child: Text("Sherehe")),
//                   ],
//                 ),
//               ),
//
//               SliverPinnedHeader(
//                 child: BlocConsumer<PermissionCubit, PermissionState>(
//                   listener: (context, state) {
//                     if (state is PermissionPermanentlyDenied) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text(
//                             "You've previously permanently disabled notifications."
//                             " Please re-enable them on the phone settings page.",
//                           ),
//                           behavior: SnackBarBehavior.floating,
//                         ),
//                       );
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is PermissionDenied ||
//                         state is PermissionPermanentlyDenied) {
//                       return const PermissionNotificationAlertCard();
//                     }
//                     return const SizedBox.shrink();
//                   },
//                 ),
//               ),
//               SliverFillRemaining(
//                 hasScrollBody: true,
//                 fillOverscroll: true,
//                 child: Align(
//                   alignment: Alignment.topCenter,
//                   child: ConstrainedBox(
//                     constraints: const BoxConstraints(
//                       maxWidth: ResponsiveBreakPoints.tablet,
//                     ),
//                     child: const TabBarView(
//                       children: [
//                         LeaderboardHomepage(),
//                         FeedPage(),
//                         ShereheHome(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

class _HomeActionsSheet extends StatelessWidget {
  const _HomeActionsSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SheetSectionLabel(label: 'Chirp'),
              _SheetTile(
                icon: Symbols.newspaper,
                label: 'Your posts',
                onTap: () => Navigator.pop(context), // TODO: wire route
              ),
              _SheetTile(
                icon: Symbols.group_add,
                label: 'Create community',
                onTap: () {
                  Navigator.pop(context);
                  CreateCommunitiesRoute().push(context);
                },
              ),
              _SheetTile(
                icon: Symbols.view_comfy,
                label: 'Your communities',
                onTap: () {
                  Navigator.pop(context);
                  CommunityMembershipsRoute().push(context);
                },
              ),
              _SheetTile(
                icon: Symbols.block,
                label: 'Block list',
                onTap: () {
                  Navigator.pop(context);
                  BlockedItemsRoute().push(context);
                },
              ),

              const Divider(indent: 16, endIndent: 16),

              // Sherehe section
              _SheetSectionLabel(label: 'Sherehe'),
              _SheetTile(
                icon: Symbols.confirmation_number,
                label: 'All tickets',
                onTap: () {
                  Navigator.pop(context);
                  PurchasedTicketsRoute().push(context);
                },
              ),
              _SheetTile(
                icon: Symbols.event_note,
                label: 'My organized events',
                onTap: () {
                  Navigator.pop(context);
                  OrganizedEventsRoute().push(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetSectionLabel extends StatelessWidget {
  const _SheetSectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 4),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _SheetTile extends StatelessWidget {
  const _SheetTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final permissions = [AppPermission.notification];
    if (Platform.isAndroid) {
      permissions.add(AppPermission.preciseAlarm);
    }
    context.read<PermissionCubit>().checkMultiplePermissions(permissions);
  }

  void _showActionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => const _HomeActionsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PermissionCubit, PermissionState>(
      listener: (context, state) {
        if (state is PermissionPermanentlyDenied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Notifications are permanently disabled. '
                'Re-enable them in your phone settings.',
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, permissionState) {
        final showBanner =
            permissionState is PermissionDenied ||
            permissionState is PermissionPermanentlyDenied;

        return DefaultTabController(
          initialIndex: 1,
          length: 3,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                  sliver: SliverAppBar(
                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    leading: Assets.icons.academia.image(),
                    title: InkWell(
                      onTap: () => _showActionsSheet(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4,
                        children: [
                          Text(
                            'Academia',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    centerTitle: false,
                    actions: [
                      IconButton(
                        onPressed: () => showSearch(
                          context: context,
                          delegate: GlobalSearchDelegate(),
                        ),
                        icon: const Icon(Icons.search),
                        tooltip: 'Search',
                      ),
                      IconButton(
                        onPressed: () => ProfileRoute().push(context),
                        icon: const UserAvatar(
                          scallopDepth: 4,
                          numberOfScallops: 8,
                        ),
                        tooltip: 'Profile',
                      ),
                    ],
                    bottom: _HomeTabBar(showBanner: showBanner),
                  ),
                ),
              ],
              body: const TabBarView(
                children: [LeaderboardHomepage(), FeedPage(), ShereheHome()],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HomeTabBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeTabBar({required this.showBanner});

  final bool showBanner;

  static const double _tabBarHeight = 48;
  static const double _bannerHeight = 80;

  @override
  Size get preferredSize => Size.fromHeight(
    showBanner ? _tabBarHeight + _bannerHeight : _tabBarHeight,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showBanner) const PermissionNotificationAlertCard(),
        const TabBar.secondary(
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          tabs: [
            Tab(text: 'Leaderboard'),
            Tab(text: 'For you'),
            Tab(text: 'Sherehe'),
          ],
        ),
      ],
    );
  }
}
