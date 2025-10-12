import 'package:academia/config/flavor.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProfileRemoteDatasource with DioErrorHandler {
  final DioClient dioClient;
  final FlavorConfig flavor;
  late String servicePrefix;

  ProfileRemoteDatasource({required this.dioClient, required this.flavor}) {
    if (flavor.isProduction) {
      servicePrefix = "verisafe";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-verisafe';
    } else {
      servicePrefix = "dev-verisafe";
    }
  }

  Future<Either<Failure, UserProfileData>> refreshCurrentUserProfile() async {
    try {
      final response = await dioClient.dio.get("/$servicePrefix/accounts/me");
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

  Future<Either<Failure, UserProfileData>> updateUserProfile(
    UserProfileData updatedProfile,
  ) async {
    try {
      final response = await dioClient.dio.patch(
        "/$servicePrefix/accounts/me",
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
          message: "We couldn't update your phone number at the moment",
        ),
      );
    }
  }

  Future<Either<Failure, UserProfileData>> updateUserPhone(
    UserProfileData updatedProfile,
  ) async {
    try {
      final response = await dioClient.dio.patch(
        "/$servicePrefix/accounts/me/phone",
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
          message: "We couldn't update your phone number at the moment",
        ),
      );
    }
  }
}
