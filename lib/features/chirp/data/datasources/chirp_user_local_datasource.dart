import 'package:academia/database/database.dart';
import 'package:drift/drift.dart';

abstract class ChirpUserLocalDataSource {
  Future<void> cacheChirpUsers(List<ChirpUserData> users);
  Future<List<ChirpUserData>> getCachedChirpUsers();
  Future<void> cacheChirpUser(ChirpUserData user);
  Future<ChirpUserData?> getCachedChirpUserById(String userId);
  Future<void> deleteCachedChirpUser(String userId);
  Future<void> clearCachedChirpUsers();
}

class ChirpUserLocalDataSourceImpl implements ChirpUserLocalDataSource {
  final AppDataBase localDB;

  ChirpUserLocalDataSourceImpl({required this.localDB});

  @override
  Future<void> cacheChirpUsers(List<ChirpUserData> users) async {
    await localDB.batch((batch) {
      batch.deleteWhere(
        localDB.chirpUserTable,
        (_) => const Constant<bool>(true),
      );
      batch.insertAll(localDB.chirpUserTable, users);
    });
  }

  @override
  Future<List<ChirpUserData>> getCachedChirpUsers() async {
    return await localDB.select(localDB.chirpUserTable).get();
  }

  @override
  Future<void> cacheChirpUser(ChirpUserData user) async {
    await localDB.into(localDB.chirpUserTable).insertOnConflictUpdate(user);
  }

  @override
  Future<ChirpUserData?> getCachedChirpUserById(String userId) async {
    return await (localDB.select(
      localDB.chirpUserTable,
    )..where((tbl) => tbl.id.equals(userId))).getSingleOrNull();
  }

  @override
  Future<void> deleteCachedChirpUser(String userId) async {
    await (localDB.delete(
      localDB.chirpUserTable,
    )..where((tbl) => tbl.id.equals(userId))).go();
  }

  @override
  Future<void> clearCachedChirpUsers() async {
    await localDB.delete(localDB.chirpUserTable).go();
  }
}
