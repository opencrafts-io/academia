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
import '../data/datasources/plan_local_datasource.dart' as _i774;
import '../data/datasources/plan_remote_datasource.dart' as _i745;
import '../data/repository/plan_repository_impl.dart' as _i68;
import '../domain/domain.dart' as _i515;
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
  gh.factory<_i774.PlanLocalDatasource>(
    () => _i774.PlanLocalDatasource(planDao: gh<_i252.PlanDao>()),
  );
  gh.lazySingleton<_i745.PlanRemoteDataSource>(
    () => _i745.PlanRemoteDatasourceImpl(apiClient: gh<_i494.ApiClient>()),
  );
  gh.lazySingleton<_i515.PlanRepository>(
    () => _i68.PlanRepositoryImpl(
      planLocalDatasource: gh<_i433.PlanLocalDatasource>(),
      planRemoteDataSource: gh<_i433.PlanRemoteDataSource>(),
    ),
  );
  gh.factory<_i361.GetPlanByCode>(
    () => _i361.GetPlanByCode(gh<_i515.PlanRepository>()),
  );
  gh.factory<_i113.GetPlans>(() => _i113.GetPlans(gh<_i515.PlanRepository>()));
  gh.lazySingleton<_i906.PlanCubit>(
    () => _i906.PlanCubit(gh<_i515.GetPlans>(), gh<_i515.GetPlanByCode>()),
  );
  return getIt;
}
