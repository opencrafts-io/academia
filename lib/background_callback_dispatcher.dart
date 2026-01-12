import 'package:academia/background_task/daily_login_background_task.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void backgroundCallbackDispatcher() {
  final DailyLoginBackgroundTask dailyLoginBackgroundTask =
      DailyLoginBackgroundTask();

  Workmanager().executeTask((task, input) async {
    if (task == dailyLoginBackgroundTask.taskName) {
      await dailyLoginBackgroundTask.execute(input);
      return true;
    }
    return Future.value(false);
  });
}
