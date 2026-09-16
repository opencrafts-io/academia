import 'package:database/app_database_v2.dart';
import 'package:database/daos/lock_in_dao.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lock_in/lock_in.dart';

void main() {
  test('registers the Lock In service through its package initializer', () {
    final database = AppDatabaseV2(NativeDatabase.memory());
    addTearDown(database.close);
    final getIt = GetIt.asNewInstance();
    getIt.registerSingleton<LockInDao>(LockInDao(database));

    configureLockInDependencies(getIt);

    expect(getIt<LockInService>(), isA<LockInService>());
  });
}
