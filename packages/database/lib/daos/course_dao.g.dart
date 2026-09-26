// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_dao.dart';

// ignore_for_file: type=lint
mixin _$CourseDaoMixin on DatabaseAccessor<AppDatabaseV2> {
  $CoursesTable get courses => attachedDatabase.courses;
  $LecturersTable get lecturers => attachedDatabase.lecturers;
  CourseDaoManager get managers => CourseDaoManager(this);
}

class CourseDaoManager {
  final _$CourseDaoMixin _db;
  CourseDaoManager(this._db);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db.attachedDatabase, _db.courses);
  $$LecturersTableTableManager get lecturers =>
      $$LecturersTableTableManager(_db.attachedDatabase, _db.lecturers);
}
