import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProfileRemoteDatasource with DioErrorHandler {
  final DioClient dioClient;

  ProfileRemoteDatasource({required this.dioClient});

  Future<Either<Failure, UserProfileData>> refreshCurrentUserProfile() async {
    try {
      final response = await dioClient.dio.get("/accounts/me");
      if (response.statusCode == 200) {
        return right(UserProfileData.fromJson(response.data));
      }
      return left(NetworkFailure(error: "", message: ""));
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      rethrow;
      return left(
        CacheFailure(
          error: e,
          message: "We couldn't fetch your profile please try again later",
        ),
      );
    }
  }

  Future<Either<Failure, UserProfileData>> updateUserProfile(
    UserProfileData updatedProfile,
  ) async {
    try {
      final response = await dioClient.dio.patch(
        "/accounts/me",
        data: updatedProfile.toJson(),
      );
      if (response.statusCode == 200) {
        return right(UserProfileData.fromJson(response.data));
      }
      return left(NetworkFailure(error: "", message: ""));
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "We couldn't fetch your profile please try again later",
        ),
      );
    }
  }
}
