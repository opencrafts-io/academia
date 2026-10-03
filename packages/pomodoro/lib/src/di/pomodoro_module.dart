import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pomodoro/src/di/pomodoro_module.config.dart';
import 'package:pomodoro/src/domain/domain.dart';

@InjectableInit(
  initializerName: 'initPomodoro',
  preferRelativeImports: false,
  asExtension: false,
)
void configurePomodoroDependencies(
  GetIt getIt, {
  required PomodoroTodoGateway todoGateway,
  required PomodoroSessionStore sessionStore,
  required PomodoroStatusSurface statusSurface,
}) {
  getIt.registerSingleton<PomodoroTodoGateway>(todoGateway);
  getIt.registerSingleton<PomodoroSessionStore>(sessionStore);
  getIt.registerSingleton<PomodoroStatusSurface>(statusSurface);
  initPomodoro(getIt);
}
