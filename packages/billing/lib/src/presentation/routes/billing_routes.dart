import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import '../presentation.dart';

part 'billing_routes.g.dart';

@TypedGoRoute<PaywallRoute>(path: '/billing')
class PaywallRoute extends GoRouteData with $PaywallRoute {
  const PaywallRoute({this.featureName = 'this feature', this.accessMessage});

  final String featureName;
  final String? accessMessage;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage(
      child: BlocProvider(
        create: (_) =>
            GetIt.instance<SubscriptionManagementBloc>()
              ..add(const LoadSubscriptionManagement()),
        child: PaywallPage(
          featureName: featureName,
          accessMessage: accessMessage,
        ),
      ),
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            var tween = Tween(
              begin: Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOutQuad));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}
