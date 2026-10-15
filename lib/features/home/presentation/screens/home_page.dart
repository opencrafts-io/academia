import 'dart:async';
import 'dart:ui' show ImageFilter;

import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:academia/injection_container.dart';
import 'package:ads/ads.dart';
import 'package:analytics/analytics.dart';
import 'package:billing/billing.dart' as billing;
import 'package:core/core.dart' as core;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:permissions/permissions.dart';
import 'package:leaderboard/leaderboard.dart' as leaderboard;
import 'package:rewards/rewards.dart' as rewards;

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

              const Divider(indent: 16, endIndent: 16),
              _SheetSectionLabel(label: 'Rewards'),
              _SheetTile(
                icon: Symbols.workspace_premium,
                label: 'Points and rewards',
                onTap: () {
                  Navigator.pop(context);
                  context.push('/rewards');
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
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
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
  static const _premiumUpgradeFlagKey = 'allow_premium_upgrade';

  late Future<bool> _premiumUpgradeEnabledFuture;
  late Future<billing.SubscriptionStatus?> _subscriptionStatusFuture;
  String? _accountId;

  @override
  void initState() {
    super.initState();
    _premiumUpgradeEnabledFuture = _isPremiumUpgradeEnabled();
    _subscriptionStatusFuture = _loadSubscriptionStatus();
    unawaited(_loadVerisafeAccountId());
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => unawaited(_promptForNotificationsIfNeeded()),
    );
  }

  Future<void> _loadVerisafeAccountId() async {
    final result = await sl<rewards.GetRewardAccount>()();
    if (!mounted) return;
    result.fold((_) {}, (account) => setState(() => _accountId = account.id));
  }

  bool get _supportsNotificationPrompt =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  Future<void> _promptForNotificationsIfNeeded() async {
    if (!_supportsNotificationPrompt) return;

    final status = await sl<PermissionGateway>().check(
      PermissionCapability.notifications,
    );
    if (!mounted || !shouldPromptForNotificationOnLaunch(status)) return;

    await const NotificationPermissionRoute().push(context);
  }

  Future<billing.SubscriptionStatus?> _loadSubscriptionStatus() async {
    final result = await sl<billing.GetCurrentSubscriptionStatus>()(
      const core.NoUseCaseParams(),
    );
    return result.fold((_) => null, (status) => status);
  }

  Future<bool> _isPremiumUpgradeEnabled() {
    if (kDebugMode) return Future.value(true);

    return sl<FeatureFlagReader>().isEnabled(_premiumUpgradeFlagKey);
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
    unawaited(sl<AnalyticsTracker>().track(AnalyticsEvent.paywallViewed()));
    await const billing.PaywallRoute(
      featureName: 'Academia Premium',
      accessMessage: 'Upgrade to unlock premium tools across Academia.',
    ).push(context);
    await sl<AdService>().refreshEligibility();
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
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                forceMaterialTransparency: true,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                systemOverlayStyle:
                    ThemeData.estimateBrightnessForColor(
                          Theme.of(context).colorScheme.surface,
                        ) ==
                        Brightness.dark
                    ? SystemUiOverlayStyle.light
                    : SystemUiOverlayStyle.dark,
                flexibleSpace: SizedBox.expand(
                  child: ClipRect(
                    child: innerBoxIsScrolled
                        ? BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
                            blendMode: BlendMode.src,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Theme.of(context).colorScheme.surface
                                        .withValues(alpha: 0.72),
                                    Theme.of(context).colorScheme.surface
                                        .withValues(alpha: 0.84),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : ColoredBox(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                  ),
                ),
                leadingWidth: 160,
                leading: Tooltip(
                  message: 'Open app sections',
                  child: InkWell(
                    onTap: () => _showActionsSheet(context),
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 48,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Academia',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 22,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                title: null,
                centerTitle: false,
                actions: [
                  FutureBuilder(
                    future: _premiumUpgradeEnabledFuture,
                    builder: (context, flagSnapshot) {
                      if (flagSnapshot.data != true) {
                        return const SizedBox.shrink();
                      }

                      return FutureBuilder(
                        future: _subscriptionStatusFuture,
                        builder: (context, subscriptionSnapshot) {
                          if (!_shouldShowPremiumUpgrade(
                            subscriptionSnapshot.data,
                          )) {
                            return const SizedBox.shrink();
                          }

                          return IconButton(
                            onPressed: _openBilling,
                            icon: const Icon(Symbols.workspace_premium_rounded),
                            tooltip: 'Upgrade',
                          );
                        },
                      );
                    },
                  ),
                  SearchAnchor(
                    isFullScreen: true,
                    viewHintText: 'Search communities...',
                    viewOnChanged: (query) => searchGlobalCommunities(
                      context,
                      query,
                    ),
                    viewBuilder: (suggestions) => suggestions.isEmpty
                        ? const SizedBox.shrink()
                        : suggestions.first,
                    suggestionsBuilder: (context, controller) => [
                      GlobalSearchResults(query: controller.text),
                    ],
                    builder: (context, controller) => IconButton(
                      onPressed: controller.openView,
                      constraints: const BoxConstraints(
                        minWidth: 48,
                        minHeight: 48,
                      ),
                      icon: const Icon(Icons.search),
                      tooltip: 'Search communities',
                    ),
                  ),
                  IconButton(
                    onPressed: () => ProfileRoute().push(context),
                    icon: const UserAvatar(shape: core.M3EShape.bun),
                    tooltip: 'Profile',
                  ),
                ],
                bottom: _HomeTabBar(),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              leaderboard.LeaderboardHomepage(accountId: _accountId),
              FeedPage(),
              ShereheHome(),
            ],
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
