// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core/core.dart' as _i494;
import 'package:database/database.dart' as _i252;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/data.dart' as _i433;
import '../data/datasources/entitlement_local_datasource.dart' as _i763;
import '../data/datasources/entitlement_remote_datasource.dart' as _i368;
import '../data/datasources/order_local_datasource.dart' as _i942;
import '../data/datasources/order_remote_datasource.dart' as _i908;
import '../data/datasources/plan_local_datasource.dart' as _i774;
import '../data/datasources/plan_remote_datasource.dart' as _i745;
import '../data/datasources/subscription_local_datasource.dart' as _i376;
import '../data/datasources/subscription_remote_datasource.dart' as _i215;
import '../data/repository/entitlement_repository_impl.dart' as _i973;
import '../data/repository/order_repository_impl.dart' as _i642;
import '../data/repository/plan_repository_impl.dart' as _i68;
import '../data/repository/subscription_repository_impl.dart' as _i949;
import '../domain/domain.dart' as _i515;
import '../domain/usecases/get_current_subscription_status.dart' as _i1067;
import '../domain/usecases/get_entitlements_by_plan_code.dart' as _i26;
import '../domain/usecases/get_order_by_id.dart' as _i44;
import '../domain/usecases/get_orders.dart' as _i15;
import '../domain/usecases/get_plan_by_code.dart' as _i361;
import '../domain/usecases/get_plans.dart' as _i113;
import '../presentation/cubits/plan_cubit.dart' as _i906;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initBilling(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i942.OrderLocalDatasource>(
    () => _i942.OrderLocalDatasource(orderDao: gh<_i252.OrderDao>()),
  );
  gh.lazySingleton<_i908.OrderRemoteDataSource>(
    () => _i908.OrderRemoteDatasourceImpl(apiClient: gh<_i494.ApiClient>()),
  );
  gh.factory<_i763.EntitlementLocalDatasource>(
    () => _i763.EntitlementLocalDatasource(
      entitlementDao: gh<_i252.EntitlementDao>(),
    ),
  );
  gh.lazySingleton<_i215.SubscriptionRemoteDataSource>(
    () => _i215.SubscriptionRemoteDatasourceImpl(
      apiClient: gh<_i494.ApiClient>(),
    ),
  );
  gh.factory<_i376.SubscriptionLocalDatasource>(
    () => _i376.SubscriptionLocalDatasource(
      subscriptionDao: gh<_i252.SubscriptionDao>(),
    ),
  );
  gh.factory<_i774.PlanLocalDatasource>(
    () => _i774.PlanLocalDatasource(planDao: gh<_i252.PlanDao>()),
  );
  gh.lazySingleton<_i368.EntitlementRemoteDataSource>(
    () =>
        _i368.EntitlementRemoteDatasourceImpl(apiClient: gh<_i494.ApiClient>()),
  );
  gh.lazySingleton<_i745.PlanRemoteDataSource>(
    () => _i745.PlanRemoteDatasourceImpl(apiClient: gh<_i494.ApiClient>()),
  );
  gh.lazySingleton<_i515.EntitlementRepository>(
    () => _i973.EntitlementRepositoryImpl(
      localDataSource: gh<_i433.EntitlementLocalDatasource>(),
      remoteDataSource: gh<_i433.EntitlementRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i515.PlanRepository>(
    () => _i68.PlanRepositoryImpl(
      planLocalDatasource: gh<_i433.PlanLocalDatasource>(),
      planRemoteDataSource: gh<_i433.PlanRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i515.SubscriptionRepository>(
    () => _i949.SubscriptionRepositoryImpl(
      localDataSource: gh<_i433.SubscriptionLocalDatasource>(),
      remoteDataSource: gh<_i433.SubscriptionRemoteDataSource>(),
    ),
  );
  gh.factory<_i1067.GetCurrentSubscriptionStatus>(
    () =>
        _i1067.GetCurrentSubscriptionStatus(gh<_i515.SubscriptionRepository>()),
  );
  gh.factory<_i26.GetEntitlementsByPlanCode>(
    () => _i26.GetEntitlementsByPlanCode(gh<_i515.EntitlementRepository>()),
  );
  gh.factory<_i361.GetPlanByCode>(
    () => _i361.GetPlanByCode(gh<_i515.PlanRepository>()),
  );
  gh.factory<_i113.GetPlans>(() => _i113.GetPlans(gh<_i515.PlanRepository>()));
  gh.lazySingleton<_i515.OrderRepository>(
    () => _i642.OrderRepositoryImpl(
      localDataSource: gh<_i433.OrderLocalDatasource>(),
      remoteDataSource: gh<_i433.OrderRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i906.PlanCubit>(
    () => _i906.PlanCubit(gh<_i515.GetPlans>(), gh<_i515.GetPlanByCode>()),
  );
  gh.factory<_i44.GetOrderById>(
    () => _i44.GetOrderById(gh<_i515.OrderRepository>()),
  );
  gh.factory<_i15.GetOrders>(() => _i15.GetOrders(gh<_i515.OrderRepository>()));
  return getIt;
}
