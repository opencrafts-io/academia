// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pomodoro/src/domain/gateway/pomodoro_todo_gateway.dart'
    as _i1040;
import 'package:pomodoro/src/domain/gateway/pomodoro_session_store.dart'
    as _i889;
import 'package:pomodoro/src/domain/gateway/pomodoro_status_surface.dart'
    as _i506;
import 'package:pomodoro/src/presentation/cubit/pomodoro_cubit.dart' as _i589;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initPomodoro(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i589.PomodoroCubit>(
    () => _i589.PomodoroCubit(
      todoGateway: gh<_i1040.PomodoroTodoGateway>(),
      sessionStore: gh<_i889.PomodoroSessionStore>(),
      statusSurface: gh<_i506.PomodoroStatusSurface>(),
    ),
  );
  return getIt;
}
