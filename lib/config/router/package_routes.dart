import 'package:billing/billing.dart' as billing;
import 'package:courses/courses.dart' as courses;
import 'package:go_router/go_router.dart';
import 'package:in_app_update/in_app_update.dart' as in_app_update;
import 'package:permissions/permissions.dart' as permissions;
import 'package:pomodoro/pomodoro.dart' as pomodoro;
import 'package:rewards/rewards.dart' as rewards;
import 'package:settings/settings.dart' as settings;
import 'package:study_tools/study_tools.dart' as study_tools;
import 'package:todos/todos.dart' as todos;
import 'package:auth/auth.dart' as auth;
import 'package:profile/profile.dart' as profile;

import 'package:academia/core/integration/profile/screens/complete_profile_screen.dart';
import 'package:academia/core/integration/profile/screens/institution_linking_page.dart';
import 'package:academia/core/integration/profile/screens/profile_view.dart';
import 'package:academia/injection_container.dart';
import 'package:profile/profile.dart' show ProfileBloc, ProfileLoadedState;
import 'package:auth/auth.dart' show PasswordSettingsSheet, SetPasswordUsecase;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

List<RouteBase> get packageRoutes {
  profile.ProfileRoutePages.profile = (context, state) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: const ProfileView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offset = animation.drive(
            Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          );
          return SlideTransition(position: offset, child: child);
        },
      );
  profile.ProfileRoutePages.onboarding = (context, state) => MaterialPage<void>(
    key: state.pageKey,
    child: const CompleteProfileScreen(),
  );
  profile.ProfileRoutePages.institutionLinking = (context, state) =>
      ModalSheetPage(
        key: state.pageKey,
        swipeDismissible: true,
        viewportBuilder: (context, child) => SheetViewport(
          padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
          child: child,
        ),
        child: const Sheet(child: InstitutionLinkingPage()),
      );
  profile.ProfileRoutePages.passwordSettings = (context, state) {
    final profileState = context.read<ProfileBloc>().state;
    final email = profileState is ProfileLoadedState
        ? profileState.profile.email.trim()
        : '';
    return ModalSheetPage(
      key: state.pageKey,
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
          child: PasswordSettingsSheet(
            setPassword: sl<SetPasswordUsecase>(),
            accountEmail: email,
          ),
        ),
      ),
    );
  };

  return [
    ...auth.routes,
    ...profile.routes,
    ...billing.routes,
    ...in_app_update.routes,
    ...settings.routes,
    ...permissions.routes,
    ...courses.routes,
    ...todos.routes,
    ...pomodoro.routes,
    ...study_tools.routes,
    ...rewards.routes,
  ];
}
