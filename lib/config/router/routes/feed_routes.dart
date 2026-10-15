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
  const AddPostRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final community = state.extra as Community?;
    return AddPostPage(preselectedCommunity: community);
  }
}

@TypedGoRoute<BlockedItemsRoute>(path: "/blocked-items")
class BlockedItemsRoute extends GoRouteData with $BlockedItemsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BlockedItemsPage();
  }
}
