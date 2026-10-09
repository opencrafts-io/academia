part of '../routes.dart';

@TypedGoRoute<CommunitiesRoute>(
  path: "/communities/:communityId",
  routes: [
    TypedGoRoute<CommunityInfoRoute>(path: 'info'),
    TypedGoRoute<CommunityMembersRoute>(path: "members/:role"),
    TypedGoRoute<EditCommunityInfoRoute>(path: "edit"),
  ],
)
class CommunitiesRoute extends GoRouteData with $CommunitiesRoute {
  final int communityId;

  CommunitiesRoute({required this.communityId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityHome(communityId: communityId);
  }
}

class CommunityInfoRoute extends GoRouteData with $CommunityInfoRoute {
  final int communityId;
  CommunityInfoRoute({required this.communityId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityInfoPage(communityId: communityId);
  }
}

class CommunityMembersRoute extends GoRouteData with $CommunityMembersRoute {
  final int communityId;
  final String role;

  CommunityMembersRoute({required this.communityId, required this.role});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityMembersPage(communityID: communityId, role: role);
  }
}

class EditCommunityInfoRoute extends GoRouteData with $EditCommunityInfoRoute {
  final int communityId;
  EditCommunityInfoRoute({required this.communityId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditCommunityInformation(communityID: communityId);
  }
}

@TypedGoRoute<CreateCommunitiesRoute>(path: "/create-community")
class CreateCommunitiesRoute extends GoRouteData with $CreateCommunitiesRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreateCommunityScreen();
  }
}

@TypedGoRoute<TrimVideoRoute>(path: "/video-trimmer")
class TrimVideoRoute extends GoRouteData with $TrimVideoRoute {
  /// [$extra] is the source video's file path, passed via `extra` (not a
  /// URL path segment - a filesystem path has no business being
  /// percent-encoded into a navigable route) and fully typed by
  /// go_router_builder's `$extra` convention, so both this constructor and
  /// `state.extra` on the receiving side are `String`, not `Object?`.
  const TrimVideoRoute(this.$extra);

  final String $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VideoTrimmerPage(videoPath: $extra);
  }
}

@TypedGoRoute<CommunityMembershipsRoute>(path: "/community/memberships/mine")
class CommunityMembershipsRoute extends GoRouteData
    with $CommunityMembershipsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityMembershipPage();
  }
}
