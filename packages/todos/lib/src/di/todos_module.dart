import 'package:database/daos/daos.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todos/src/data/datasource/drift_todo_local_store.dart';
import 'package:todos/src/data/datasource/todo_local_store.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:todos/src/presentation/cubit/todo_item_cubit.dart';
import 'package:todos/src/presentation/cubit/pomodoro_cubit.dart';

import 'package:todos/src/di/todos_module.config.dart';

@InjectableInit(
  initializerName: 'initTodos',
  preferRelativeImports: false,
  asExtension: false,
)
void configureTodosDependencies(GetIt getIt) {
  getIt.registerLazySingleton<TodoLocalStore>(
    () => DriftTodoLocalStore(
      lists: getIt<TodoListDao>(),
      items: getIt<TodoItemDao>(),
      tags: getIt<TodoTagDao>(),
    ),
  );
  initTodos(getIt);
  getIt.registerLazySingleton<TodoItemCubit>(
    () => TodoItemCubit(
      getItemsUseCase: getIt<GetTodoItems>(),
      getItemByIdUseCase: getIt<GetTodoItemById>(),
      createItemUseCase: getIt<CreateTodoItem>(),
      updateItemUseCase: getIt<UpdateTodoItem>(),
      deleteItemUseCase: getIt<DeleteTodoItem>(),
      completeItemUseCase: getIt<CompleteTodoItem>(),
      reopenItemUseCase: getIt<ReopenTodoItem>(),
      moveItemUseCase: getIt<MoveTodoItem>(),
      syncItemsUseCase: getIt<SyncTodoItems>(),
      addFocusedTimeUseCase: getIt<AddFocusedTimeToTodoItem>(),
    ),
  );
  getIt.registerLazySingleton<PomodoroCubit>(
    () => PomodoroCubit(todoItemCubit: getIt<TodoItemCubit>()),
  );
}
