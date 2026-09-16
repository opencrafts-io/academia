import 'package:academia/background_task/background_task.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:workmanager/workmanager.dart' show NetworkType, BackoffPolicy;

class TodoListSyncBackgroundTask extends BackgroundTask {
  final TodoListRepository todoListRepository;

  TodoListSyncBackgroundTask({required this.todoListRepository});

  @override
  String get taskName => 'io.opencrafts.academia.todolist.sync';

  @override
  String? get taskTag => 'todos';

  @override
  Duration? get frequency => const Duration(hours: 2);

  @override
  Duration? get initialDelay => const Duration(minutes: 10);

  @override
  BackgroundTaskConstraints get constraints => const BackgroundTaskConstraints(
    networkType: NetworkType.connected,
    requiresBatteryNotLow: true,
  );

  @override
  BackoffPolicyConfig get backoffPolicy => const BackoffPolicyConfig(
    policy: BackoffPolicy.exponential,
    delay: Duration(minutes: 15),
  );

  @override
  Future<bool> execute(Map<String, dynamic>? inputData) async {
    try {
      final result = await todoListRepository.syncTodoLists();

      final success = result.fold(
        (failure) {
          return false;
        },
        (unit) {
          return true;
        },
      );

      return success;
    } catch (e) {
      return false;
    }
  }
}
