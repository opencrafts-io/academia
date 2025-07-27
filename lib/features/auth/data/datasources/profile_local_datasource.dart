import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class ProfileLocalDatasource {
  final AppDataBase localDB;

  ProfileLocalDatasource({required this.localDB});

  Future<Either<Failure, UserProfileData>> createOrUpdateUserProfile(
    UserProfileData userProfile,
  ) async {
    try {
      final created = await localDB
          .into(localDB.userProfile)
          .insertReturning(
            userProfile,
            onConflict: DoUpdate((profile) => userProfile),
          );
      return right(created);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Looks like we tripped! We couldn't save your profile locally"
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteProfile(
    UserProfileData userProfile,
  ) async {
    try {
      await (localDB.delete(
        localDB.userProfile,
      )..where((profile) => profile.id.equals(userProfile.id))).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "A tiny glitch in the matrix stopped us from deleting your profile locally."
              "Perhaps try casting that spell again, or check your device's arcane storage.",
        ),
      );
    }
  }

  Future<Either<Failure, UserProfileData>> getCachedUserProfile() async {
    try {
      final retrievedProfile = await localDB
          .select(localDB.userProfile)
          .getSingleOrNull();

      if (retrievedProfile == null) {
        return left(
          NoDataFoundFailure(
            message:
                "Perhaps you're new here, or it's time to craft your digital persona!",
            error: Exception("No data found"),
          ),
        );
      }
      return right(retrievedProfile);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "A problem occurred while retrieving your local profile. We recommend trying again in a moment.",
        ),
      );
    }
  }
}
