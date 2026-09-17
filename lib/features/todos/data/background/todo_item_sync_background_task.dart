import 'package:academia/background_task/background_task.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:workmanager/workmanager.dart' show NetworkType, BackoffPolicy;

class TodoItemSyncBackgroundTask extends BackgroundTask {
  final TodoItemRepository todoItemRepository;

  TodoItemSyncBackgroundTask({required this.todoItemRepository});

  @override
  String get taskName => 'io.opencrafts.academia.todoitem.sync';

  @override
  String? get taskTag => 'todos';

  @override
  Duration? get frequency => const Duration(hours: 1);

  @override
  Duration? get initialDelay => const Duration(minutes: 5);

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
      final result = await todoItemRepository.syncTodoItems();

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
