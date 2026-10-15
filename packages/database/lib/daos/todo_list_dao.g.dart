// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_dao.dart';

// ignore_for_file: type=lint
mixin _$TodoListDaoMixin on DatabaseAccessor<AppDatabaseV2> {
  $TodoListsTable get todoLists => attachedDatabase.todoLists;
  TodoListDaoManager get managers => TodoListDaoManager(this);
}

class TodoListDaoManager {
  final _$TodoListDaoMixin _db;
  TodoListDaoManager(this._db);
  $$TodoListsTableTableManager get todoLists =>
      $$TodoListsTableTableManager(_db.attachedDatabase, _db.todoLists);
}
