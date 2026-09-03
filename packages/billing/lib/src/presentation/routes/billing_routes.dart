import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation.dart';

part 'billing_routes.g.dart';

@TypedGoRoute<PaywallRoute>(path: '/billing')
class PaywallRoute extends GoRouteData with $PaywallRoute {
  const PaywallRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PaywallPage();
  }
}
