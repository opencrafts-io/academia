// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:database/app_database_v2.dart' as _i547;
import 'package:database/daos/course_dao.dart' as _i665;
import 'package:database/daos/entitlement_dao.dart' as _i979;
import 'package:database/daos/lock_in_dao.dart' as _i951;
import 'package:database/daos/order_dao.dart' as _i272;
import 'package:database/daos/plan_dao.dart' as _i143;
import 'package:database/daos/study_tools_dao.dart' as _i629;
import 'package:database/daos/subscription_dao.dart' as _i200;
import 'package:database/daos/todo_item_dao.dart' as _i650;
import 'package:database/daos/todo_list_dao.dart' as _i606;
import 'package:database/daos/todo_tag_dao.dart' as _i346;
import 'package:database/di/database_module.dart' as _i975;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initAppDatabaseV2(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final databaseModule = _$DatabaseModule();
  gh.lazySingleton<_i547.AppDatabaseV2>(() => databaseModule.appDatabaseV2());
  gh.factory<_i665.CourseDao>(() => _i665.CourseDao(gh<_i547.AppDatabaseV2>()));
  gh.factory<_i979.EntitlementDao>(
    () => _i979.EntitlementDao(gh<_i547.AppDatabaseV2>()),
  );
  gh.factory<_i951.LockInDao>(() => _i951.LockInDao(gh<_i547.AppDatabaseV2>()));
  gh.factory<_i272.OrderDao>(() => _i272.OrderDao(gh<_i547.AppDatabaseV2>()));
  gh.factory<_i143.PlanDao>(() => _i143.PlanDao(gh<_i547.AppDatabaseV2>()));
  gh.factory<_i629.StudyToolsDao>(
    () => _i629.StudyToolsDao(gh<_i547.AppDatabaseV2>()),
  );
  gh.factory<_i200.SubscriptionDao>(
    () => _i200.SubscriptionDao(gh<_i547.AppDatabaseV2>()),
  );
  gh.factory<_i650.TodoItemDao>(
    () => _i650.TodoItemDao(gh<_i547.AppDatabaseV2>()),
  );
  gh.factory<_i606.TodoListDao>(
    () => _i606.TodoListDao(gh<_i547.AppDatabaseV2>()),
  );
  gh.factory<_i346.TodoTagDao>(
    () => _i346.TodoTagDao(gh<_i547.AppDatabaseV2>()),
  );
  return getIt;
}

class _$DatabaseModule extends _i975.DatabaseModule {}
