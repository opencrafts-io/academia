part of '../routes.dart';

@TypedGoRoute<AuthRoute>(path: "/auth")
class AuthRoute extends GoRouteData with $AuthRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AuthScreen();
  }
}

@TypedGoRoute<ProfileRoute>(
  path: "/profile",
  routes: [
    TypedGoRoute<LinkInstitutionProfileRoute>(path: "link-institution"),
    TypedGoRoute<PasswordSettingsRoute>(path: "password-settings"),
  ],
)
class ProfileRoute extends GoRouteData with $ProfileRoute {
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: const ProfileView(),
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            var tween = Tween(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}

class LinkInstitutionProfileRoute extends GoRouteData
    with $LinkInstitutionProfileRoute {
  LinkInstitutionProfileRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      swipeDismissible: true,
      viewportBuilder: (context, child) => SheetViewport(
        padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
        child: child,
      ),

      child: Sheet(child: InstitutionLinkingPage()),
    );
  }
}

class PasswordSettingsRoute extends GoRouteData with $PasswordSettingsRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      fullscreenDialog: true,
      barrierDismissible: false,
      swipeDismissible: true,
      viewportBuilder: (context, child) =>
          SheetViewport(padding: EdgeInsets.zero, child: child),
      child: SheetKeyboardDismissible(
        dismissBehavior: SheetKeyboardDismissBehavior.onDragDown(
          isContentScrollAware: true,
        ),
        child: Sheet(
          scrollConfiguration: const SheetScrollConfiguration(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          decoration: MaterialSheetDecoration(
            size: SheetSize.fit,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          physics: BouncingSheetPhysics(),
          child: PasswordSettingsSheet(setPassword: sl<SetPasswordUsecase>()),
        ),
      ),
    );
  }
}

@TypedGoRoute<CompleteProfileRoute>(path: "/complete-profile")
class CompleteProfileRoute extends GoRouteData with $CompleteProfileRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CompleteProfileScreen();
  }
}

@TypedGoRoute<LinkInstitutionRequiredPageRoute>(
  path: "/link-institution-required",
)
class LinkInstitutionRequiredPageRoute extends GoRouteData
    with $LinkInstitutionRequiredPageRoute {
  const LinkInstitutionRequiredPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LinkInstitutionRequiredPage();
  }
}
