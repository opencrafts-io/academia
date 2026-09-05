import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import '../presentation.dart';

part 'billing_routes.g.dart';

@TypedGoRoute<PaywallRoute>(path: '/billing')
class PaywallRoute extends GoRouteData with $PaywallRoute {
  const PaywallRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => GetIt.instance<PlanCubit>(),
      child: PaywallPage(),
    );
  }
}
