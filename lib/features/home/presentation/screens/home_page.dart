import 'dart:io';
import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:academia/injection_container.dart';
import 'package:billing/billing.dart' as billing;
import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
  late Future<billing.SubscriptionStatus?> _subscriptionStatusFuture;

  @override
  void initState() {
    super.initState();
    _subscriptionStatusFuture = _loadSubscriptionStatus();
    final permissions = [
      AppPermission.notification,
      if (Platform.isAndroid) AppPermission.preciseAlarm,
    ];
    context.read<PermissionCubit>().checkMultiplePermissions(permissions);
  }

  Future<billing.SubscriptionStatus?> _loadSubscriptionStatus() async {
    final result = await sl<billing.GetCurrentSubscriptionStatus>()(
      const core.NoUseCaseParams(),
    );
    return result.fold((_) => null, (status) => status);
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

  Future<void> _openBilling() async {
    await const billing.PaywallRoute(
      featureName: 'Academia Premium',
      accessMessage: 'Upgrade to unlock premium tools across Academia.',
    ).push(context);
    if (!mounted) return;
    setState(() {
      _subscriptionStatusFuture = _loadSubscriptionStatus();
    });
  }

  bool _shouldShowPremiumUpgrade(billing.SubscriptionStatus? status) {
    return status == null || !status.active || status.subscription == null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionCubit, PermissionState>(
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
          return;
        } else if (state is PermissionDenied) {
          NotificationPermissionRoute().push(context);
        }
      },
      listenWhen: (previous, current) =>
          previous != current && current is PermissionDenied ||
          current is PermissionPermanentlyDenied,
      child: DefaultTabController(
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
                    child:
                        Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 4,
                              children: [
                                Text(
                                  'Academia',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  size: 20,
                                ),
                              ],
                            )
                            .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true),
                            )
                            .scaleXY(
                              begin: 1.0,
                              end: 1.1,
                              duration: 1000.ms,
                              curve: Curves.elasticOut,
                            ),
                  ),
                  centerTitle: false,
                  actions: [
                    FutureBuilder(
                      future: _subscriptionStatusFuture,
                      builder: (context, snapshot) {
                        if (!_shouldShowPremiumUpgrade(snapshot.data)) {
                          return const SizedBox.shrink();
                        }

                        return IconButton(
                          onPressed: _openBilling,
                          icon: const Icon(Symbols.workspace_premium_rounded),
                          tooltip: 'Upgrade',
                        );
                      },
                    ),
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
                  bottom: _HomeTabBar(),
                ),
              ),
            ],
            body: const TabBarView(
              children: [LeaderboardHomepage(), FeedPage(), ShereheHome()],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeTabBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeTabBar();

  static const double _tabBarHeight = 48;

  @override
  Size get preferredSize => Size.fromHeight(_tabBarHeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
