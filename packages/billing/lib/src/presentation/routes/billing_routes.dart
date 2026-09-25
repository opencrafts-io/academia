import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

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
          onWebHandoffRequested: (session) {
            final sessionUri = Uri.tryParse(session.checkoutUrl);
            final allowedSchemes = kDebugMode
                ? const {'http', 'https'}
                : const {'https'};
            if (sessionUri == null ||
                sessionUri.host.isEmpty ||
                sessionUri.userInfo.isNotEmpty ||
                sessionUri.path != '/checkout/start' ||
                !allowedSchemes.contains(sessionUri.scheme)) {
              _showCheckoutError(context);
              return;
            }

            late final Uri checkoutUri;
            if (kDebugMode) {
              final code = sessionUri.queryParameters['code'];
              if (code == null || code.isEmpty) {
                _showCheckoutError(context);
                return;
              }
              checkoutUri = Uri.parse('http://192.168.100.21:3000').replace(
                path: '/checkout/start',
                queryParameters: {'code': code},
              );
            } else {
              checkoutUri = sessionUri;
            }
            unawaited(_launchCheckout(context, checkoutUri));
          },
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

  Future<void> _launchCheckout(BuildContext context, Uri checkoutUri) async {
    try {
      if (!await launchUrl(checkoutUri, mode: LaunchMode.externalApplication) &&
          context.mounted) {
        _showCheckoutError(context);
      }
    } catch (_) {
      _showCheckoutError(context);
    }
  }

  void _showCheckoutError(BuildContext context) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not open web checkout. Please try again.'),
        behavior: .floating,
      ),
    );
  }
}
