import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_update/src/application/app_update_store_launcher.dart';
import 'package:in_app_update/src/domain/update_campaign.dart';
import 'package:in_app_update/src/presentation/app_update_prompts.dart';

part 'app_update_routes.g.dart';

@TypedGoRoute<AppUpdateRequiredRoute>(path: '/app-update/required')
class AppUpdateRequiredRoute extends GoRouteData with $AppUpdateRequiredRoute {
  const AppUpdateRequiredRoute({required this.$extra});

  final UpdateCampaign $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppUpdateRequiredPage(
      campaign: $extra,
      onUpdate: () {
        unawaited(GetIt.instance<AppUpdateStoreLauncher>().open($extra));
      },
    );
  }
}

@TypedGoRoute<AppUpdateOptionalRoute>(path: '/app-update/optional')
class AppUpdateOptionalRoute extends GoRouteData with $AppUpdateOptionalRoute {
  const AppUpdateOptionalRoute({required this.$extra});

  final UpdateCampaign $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      opaque: false,
      barrierDismissible: true,
      barrierLabel: 'Dismiss update reminder',
      barrierColor: Colors.black54,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            clipBehavior: Clip.antiAlias,
            child: AppUpdateOptionalSheet(
              campaign: $extra,
              onUpdate: () {
                unawaited(
                  GetIt.instance<AppUpdateStoreLauncher>().open($extra),
                );
              },
            ),
          ),
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = animation.drive(
          Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic)),
        );
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: offsetAnimation, child: child),
        );
      },
    );
  }
}
