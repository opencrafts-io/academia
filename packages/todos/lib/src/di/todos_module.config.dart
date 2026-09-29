// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core/config/flavor.dart' as _i666;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:notifications/notifications.dart' as _i327;
import 'package:todos/src/data/data.dart' as _i599;
import 'package:todos/src/data/datasource/todo_item_remote_datasource.dart'
    as _i415;
import 'package:todos/src/data/datasource/todo_list_remote_datasource.dart'
    as _i460;
import 'package:todos/src/data/datasource/todo_tag_remote_datasource.dart'
    as _i568;
import 'package:todos/src/data/repository/todo_item_repository_impl.dart'
    as _i683;
import 'package:todos/src/data/repository/todo_list_repository_impl.dart'
    as _i622;
import 'package:todos/src/data/repository/todo_tag_repository_impl.dart'
    as _i981;
import 'package:todos/src/data/services/todo_notification_service_impl.dart'
    as _i819;
import 'package:todos/src/domain/domain.dart' as _i851;
import 'package:todos/src/domain/usecases/add_focused_time_to_todo_item.dart'
    as _i792;
import 'package:todos/src/domain/usecases/complete_todo_item.dart' as _i344;
import 'package:todos/src/domain/usecases/create_todo_item.dart' as _i561;
import 'package:todos/src/domain/usecases/create_todo_list.dart' as _i1070;
import 'package:todos/src/domain/usecases/create_todo_tag.dart' as _i59;
import 'package:todos/src/domain/usecases/delete_todo_item.dart' as _i485;
import 'package:todos/src/domain/usecases/delete_todo_list.dart' as _i587;
import 'package:todos/src/domain/usecases/delete_todo_tag.dart' as _i604;
import 'package:todos/src/domain/usecases/get_default_todo_list_usecase.dart'
    as _i834;
import 'package:todos/src/domain/usecases/get_todo_item_by_id.dart' as _i573;
import 'package:todos/src/domain/usecases/get_todo_items.dart' as _i777;
import 'package:todos/src/domain/usecases/get_todo_lists.dart' as _i578;
import 'package:todos/src/domain/usecases/get_todo_tags.dart' as _i778;
import 'package:todos/src/domain/usecases/mark_todo_list_modified.dart'
    as _i542;
import 'package:todos/src/domain/usecases/move_todo_item.dart' as _i988;
import 'package:todos/src/domain/usecases/reopen_todo_item.dart' as _i418;
import 'package:todos/src/domain/usecases/sync_todo_items.dart' as _i733;
import 'package:todos/src/domain/usecases/sync_todo_lists.dart' as _i713;
import 'package:todos/src/domain/usecases/sync_todo_tags.dart' as _i132;
import 'package:todos/src/domain/usecases/update_todo_item.dart' as _i559;
import 'package:todos/src/domain/usecases/update_todo_list.dart' as _i630;
import 'package:todos/src/domain/usecases/update_todo_tag.dart' as _i839;
import 'package:todos/src/presentation/cubit/todo_list_cubit.dart' as _i481;
import 'package:todos/src/presentation/cubit/todo_tag_cubit.dart' as _i904;
import 'package:todos/todos.dart' as _i496;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initTodos(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i415.TodoItemRemoteDatasource>(
    () => _i415.TodoItemRemoteDatasource(
      dio: gh<_i361.Dio>(),
      flavor: gh<_i666.FlavorConfig>(),
    ),
  );
  gh.factory<_i460.TodoListRemoteDatasource>(
    () => _i460.TodoListRemoteDatasource(
      dio: gh<_i361.Dio>(),
      flavor: gh<_i666.FlavorConfig>(),
    ),
  );
  gh.factory<_i568.TodoTagRemoteDatasource>(
    () => _i568.TodoTagRemoteDatasource(
      dio: gh<_i361.Dio>(),
      flavor: gh<_i666.FlavorConfig>(),
    ),
  );
  gh.lazySingleton<_i496.TodoNotificationService>(
    () => _i819.TodoNotificationServiceImpl(
      gh<_i327.LocalNotificationScheduler>(),
    ),
  );
  gh.factory<_i851.TodoItemRepository>(
    () => _i683.TodoItemRepositoryImpl(
      localDataSource: gh<_i599.TodoLocalStore>(),
      remoteDataSource: gh<_i599.TodoItemRemoteDatasource>(),
      todoNotificationService: gh<_i851.TodoNotificationService>(),
    ),
  );
  gh.factory<_i792.AddFocusedTimeToTodoItem>(
    () => _i792.AddFocusedTimeToTodoItem(gh<_i851.TodoItemRepository>()),
  );
  gh.factory<_i344.CompleteTodoItem>(
    () => _i344.CompleteTodoItem(gh<_i851.TodoItemRepository>()),
  );
  gh.factory<_i561.CreateTodoItem>(
    () => _i561.CreateTodoItem(gh<_i851.TodoItemRepository>()),
  );
  gh.factory<_i485.DeleteTodoItem>(
    () => _i485.DeleteTodoItem(gh<_i851.TodoItemRepository>()),
  );
  gh.factory<_i573.GetTodoItemById>(
    () => _i573.GetTodoItemById(gh<_i851.TodoItemRepository>()),
  );
  gh.factory<_i777.GetTodoItems>(
    () => _i777.GetTodoItems(gh<_i851.TodoItemRepository>()),
  );
  gh.factory<_i988.MoveTodoItem>(
    () => _i988.MoveTodoItem(gh<_i851.TodoItemRepository>()),
  );
  gh.factory<_i418.ReopenTodoItem>(
    () => _i418.ReopenTodoItem(gh<_i851.TodoItemRepository>()),
  );
  gh.factory<_i733.SyncTodoItems>(
    () => _i733.SyncTodoItems(gh<_i851.TodoItemRepository>()),
  );
  gh.factory<_i559.UpdateTodoItem>(
    () => _i559.UpdateTodoItem(gh<_i851.TodoItemRepository>()),
  );
  gh.factory<_i851.TodoListRepository>(
    () => _i622.TodoListRepositoryImpl(
      localDataSource: gh<_i599.TodoLocalStore>(),
      remoteDataSource: gh<_i599.TodoListRemoteDatasource>(),
    ),
  );
  gh.factory<_i851.TodoTagRepository>(
    () => _i981.TodoTagRepositoryImpl(
      localDataSource: gh<_i599.TodoLocalStore>(),
      remoteDataSource: gh<_i599.TodoTagRemoteDatasource>(),
    ),
  );
  gh.factory<_i59.CreateTodoTag>(
    () => _i59.CreateTodoTag(gh<_i851.TodoTagRepository>()),
  );
  gh.factory<_i604.DeleteTodoTag>(
    () => _i604.DeleteTodoTag(gh<_i851.TodoTagRepository>()),
  );
  gh.factory<_i778.GetTodoTags>(
    () => _i778.GetTodoTags(gh<_i851.TodoTagRepository>()),
  );
  gh.factory<_i132.SyncTodoTags>(
    () => _i132.SyncTodoTags(gh<_i851.TodoTagRepository>()),
  );
  gh.factory<_i839.UpdateTodoTag>(
    () => _i839.UpdateTodoTag(gh<_i851.TodoTagRepository>()),
  );
  gh.lazySingleton<_i904.TodoTagCubit>(
    () => _i904.TodoTagCubit(
      getTagsUseCase: gh<_i496.GetTodoTags>(),
      createTagUseCase: gh<_i496.CreateTodoTag>(),
      updateTagUseCase: gh<_i496.UpdateTodoTag>(),
      deleteTagUseCase: gh<_i496.DeleteTodoTag>(),
      syncTagsUseCase: gh<_i496.SyncTodoTags>(),
    ),
  );
  gh.factory<_i1070.CreateTodoList>(
    () => _i1070.CreateTodoList(gh<_i851.TodoListRepository>()),
  );
  gh.factory<_i587.DeleteTodoList>(
    () => _i587.DeleteTodoList(gh<_i851.TodoListRepository>()),
  );
  gh.factory<_i834.GetDefaultTodoListUsecase>(
    () => _i834.GetDefaultTodoListUsecase(gh<_i496.TodoListRepository>()),
  );
  gh.factory<_i578.GetTodoLists>(
    () => _i578.GetTodoLists(gh<_i851.TodoListRepository>()),
  );
  gh.factory<_i542.MarkTodoListModified>(
    () => _i542.MarkTodoListModified(gh<_i851.TodoListRepository>()),
  );
  gh.factory<_i713.SyncTodoLists>(
    () => _i713.SyncTodoLists(gh<_i851.TodoListRepository>()),
  );
  gh.factory<_i630.UpdateTodoList>(
    () => _i630.UpdateTodoList(gh<_i851.TodoListRepository>()),
  );
  gh.lazySingleton<_i481.TodoListCubit>(
    () => _i481.TodoListCubit(
      getTodoListsUseCase: gh<_i496.GetTodoLists>(),
      createTodoListUseCase: gh<_i496.CreateTodoList>(),
      updateTodoListUseCase: gh<_i496.UpdateTodoList>(),
      deleteTodoListUseCase: gh<_i496.DeleteTodoList>(),
      syncTodoListsUseCase: gh<_i496.SyncTodoLists>(),
      getDefaultTodoListUsecase: gh<_i496.GetDefaultTodoListUsecase>(),
      markTodoListModifiedUseCase: gh<_i496.MarkTodoListModified>(),
    ),
  );
  return getIt;
}
