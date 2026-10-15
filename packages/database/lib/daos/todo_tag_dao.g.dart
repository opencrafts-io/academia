// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_tag_dao.dart';

// ignore_for_file: type=lint
mixin _$TodoTagDaoMixin on DatabaseAccessor<AppDatabaseV2> {
  $TodoTagItemsTable get todoTagItems => attachedDatabase.todoTagItems;
  TodoTagDaoManager get managers => TodoTagDaoManager(this);
}

class TodoTagDaoManager {
  final _$TodoTagDaoMixin _db;
  TodoTagDaoManager(this._db);
  $$TodoTagItemsTableTableManager get todoTagItems =>
      $$TodoTagItemsTableTableManager(_db.attachedDatabase, _db.todoTagItems);
}
