import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef ProfileRoutePageBuilder = Page<void> Function(
  BuildContext context,
  GoRouterState state,
);

/// App-specific integrations are provided by the application composition root.
class ProfileRoutePages {
  static ProfileRoutePageBuilder? profile;
  static ProfileRoutePageBuilder? onboarding;
  static ProfileRoutePageBuilder? institutionLinking;
  static ProfileRoutePageBuilder? passwordSettings;
}

class ProfileRoute {
  const ProfileRoute();

  String get location => '/profile';

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);
}

class CompleteProfileRoute {
  const CompleteProfileRoute();

  String get location => '/complete-profile';

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);
}

class LinkInstitutionProfileRoute {
  const LinkInstitutionProfileRoute();

  String get location => '/profile/link-institution';

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);
}

class PasswordSettingsRoute {
  const PasswordSettingsRoute();

  String get location => '/profile/password-settings';

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);
}

List<RouteBase> get routes => [
  GoRoute(
    path: '/profile',
    pageBuilder: (context, state) =>
        _build(ProfileRoutePages.profile, context, state),
    routes: [
      GoRoute(
        path: 'link-institution',
        pageBuilder: (context, state) =>
            _build(ProfileRoutePages.institutionLinking, context, state),
      ),
      GoRoute(
        path: 'password-settings',
        pageBuilder: (context, state) =>
            _build(ProfileRoutePages.passwordSettings, context, state),
      ),
    ],
  ),
  GoRoute(
    path: '/complete-profile',
    pageBuilder: (context, state) =>
        _build(ProfileRoutePages.onboarding, context, state),
  ),
];

Page<void> _build(
  ProfileRoutePageBuilder? builder,
  BuildContext context,
  GoRouterState state,
) =>
    builder?.call(context, state) ??
    MaterialPage<void>(key: state.pageKey, child: const SizedBox.shrink());
