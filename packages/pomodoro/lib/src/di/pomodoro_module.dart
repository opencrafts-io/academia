import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pomodoro/src/di/pomodoro_module.config.dart';
import 'package:pomodoro/src/domain/gateway/pomodoro_todo_gateway.dart';

@InjectableInit(
  initializerName: 'initPomodoro',
  preferRelativeImports: false,
  asExtension: false,
)
void configurePomodoroDependencies(
  GetIt getIt, {
  required PomodoroTodoGateway todoGateway,
}) {
  getIt.registerSingleton<PomodoroTodoGateway>(todoGateway);
  initPomodoro(getIt);
}
