import 'package:database/app_database_v2.dart';
import 'package:database/tables/profiles.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'profile_dao.g.dart';

@DriftAccessor(tables: [Profiles])
@injectable
class ProfileDao extends DatabaseAccessor<AppDatabaseV2>
    with _$ProfileDaoMixin {
  ProfileDao(super.db);

  Future<Profile?> getProfile() => select(profiles).getSingleOrNull();

  Future<void> saveProfile(ProfilesCompanion profile) async {
    await transaction(() async {
      await delete(profiles).go();
      await into(profiles).insert(profile);
    });
  }

  Future<int> deleteProfile(String id) =>
      (delete(profiles)..where((profile) => profile.id.equals(id))).go();

  Future<int> clearProfile() => delete(profiles).go();
}
