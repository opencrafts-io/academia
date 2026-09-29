// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item_dao.dart';

// ignore_for_file: type=lint
mixin _$TodoItemDaoMixin on DatabaseAccessor<AppDatabaseV2> {
  $TodoListsTable get todoLists => attachedDatabase.todoLists;
  $TodoItemsTable get todoItems => attachedDatabase.todoItems;
  $TodoTagItemsTable get todoTagItems => attachedDatabase.todoTagItems;
  $TodoItemTagsTable get todoItemTags => attachedDatabase.todoItemTags;
  TodoItemDaoManager get managers => TodoItemDaoManager(this);
}

class TodoItemDaoManager {
  final _$TodoItemDaoMixin _db;
  TodoItemDaoManager(this._db);
  $$TodoListsTableTableManager get todoLists =>
      $$TodoListsTableTableManager(_db.attachedDatabase, _db.todoLists);
  $$TodoItemsTableTableManager get todoItems =>
      $$TodoItemsTableTableManager(_db.attachedDatabase, _db.todoItems);
  $$TodoTagItemsTableTableManager get todoTagItems =>
      $$TodoTagItemsTableTableManager(_db.attachedDatabase, _db.todoTagItems);
  $$TodoItemTagsTableTableManager get todoItemTags =>
      $$TodoItemTagsTableTableManager(_db.attachedDatabase, _db.todoItemTags);
}
