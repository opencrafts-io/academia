part of '../routes.dart';

@TypedGoRoute<FeedRoute>(path: "/feed")
class FeedRoute extends GoRouteData with $FeedRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FeedPage();
  }
}

@TypedGoRoute<PostDetailRoute>(path: '/post/:postId')
class PostDetailRoute extends GoRouteData with $PostDetailRoute {
  final int postId;

  const PostDetailRoute({required this.postId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final post = state.extra is Post ? state.extra as Post : null;

    return PostDetailPage(postId: postId, initialPost: post);
  }
}

@TypedGoRoute<AddPostRoute>(path: "/add-post")
class AddPostRoute extends GoRouteData with $AddPostRoute {
  /// Open the poll sheet instead, to post a poll on its own.
  final bool poll;

  const AddPostRoute({this.poll = false});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final community = state.extra as Community?;
    if (poll) {
      // Swiping would throw away a half-built poll; it closes from its
      // close button (or back) instead.
      return _composerSheetPage(
        state,
        CreatePollSheet.standalone(community: community),
        swipeDismissible: false,
      );
    }
    return _composerSheetPage(
      state,
      AddPostSheet(preselectedCommunity: community),
      heightFactor: 0.85,
    );
  }
}

/// A modal sheet that rides above the keyboard. It hugs its content (up to
/// most of the screen) unless [heightFactor] fixes its share of the screen.
/// The content handles the bottom safe area itself.
Page<void> _composerSheetPage(
  GoRouterState state,
  Widget child, {
  bool swipeDismissible = true,
  double? heightFactor,
}) {
  return ModalSheetPage(
    key: state.pageKey,
    swipeDismissible: swipeDismissible,
    transitionCurve: Curves.easeOutCubic,
    viewportBuilder: (context, child) => SheetViewport(
      padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
      child: child,
    ),
    child: Builder(
      builder: (context) => SheetKeyboardDismissible(
        dismissBehavior: SheetKeyboardDismissBehavior.onDragDown(
          isContentScrollAware: true,
        ),
        child: Sheet(
          scrollConfiguration: const SheetScrollConfiguration(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          decoration: const MaterialSheetDecoration(
            size: SheetSize.fit,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
          ),
          physics: swipeDismissible
              ? BouncingSheetPhysics()
              : const ClampingSheetPhysics(),
          child: LayoutBuilder(
            builder: (context, constraints) => ConstrainedBox(
              constraints: heightFactor == null
                  ? BoxConstraints(maxHeight: constraints.maxHeight * 0.94)
                  : BoxConstraints.tightFor(
                      height: constraints.maxHeight * heightFactor,
                    ),
              child: child,
            ),
          ),
        ),
      ),
    ),
  );
}

@TypedGoRoute<BlockedItemsRoute>(path: "/blocked-items")
class BlockedItemsRoute extends GoRouteData with $BlockedItemsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BlockedItemsPage();
  }
}
