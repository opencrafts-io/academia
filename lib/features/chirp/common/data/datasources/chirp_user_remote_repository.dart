import 'package:academia/config/flavor.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ChirpUserRemoteRepository with DioErrorHandler, ConnectivityChecker {
  final DioClient dioClient;
  late String servicePrefix;
  final FlavorConfig flavor;

  ChirpUserRemoteRepository({required this.dioClient, required this.flavor}) {
    if (flavor.isProduction) {
      servicePrefix = "chirp";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-chirp';
    } else {
      servicePrefix = "dev-chirp";
    }
  }

  /// getChirpUserByID
  /// Attempts to fetch a user by their user_id from remote chirp repository
  /// specified by [userID]
  /// If it was a success it returns [ChirpUserData] otherwise it returns a [Failure]
  /// with a message of exactly what went wrong
  Future<Either<Failure, ChirpUserData>> getChirpUserByID(String userID) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }
      final result = await dioClient.dio.get(
        "/$servicePrefix/users/find/${userID.trim()}",
      );

      if (result.statusCode == 200) {
        return right(ChirpUserData.fromJson(result.data));
      }
      throw ("Programming error");
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred while retrieving for user id [$id]."
              "Please try again later.",
          error: e,
        ),
      );
    }
  }

  /// getChirpUserByUsername
  /// Attempts to fetch a user by their userne from remote chirp repository
  /// specified by [username]
  /// Note that the function does not perform any case changes although trims  trailing
  /// and  leading whitespace characters and successively passing the data directly to chirp remote
  /// If it was a success it returns [ChirpUserData] otherwise it returns a [Failure]
  /// with a message of exactly what went wrong
  ///
  Future<Either<Failure, ChirpUserData>> getChirpUserByUsername(
    String username,
  ) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }
      final result = await dioClient.dio.get(
        "/$servicePrefix/users/who-is/${username.trim()}",
      );

      if (result.statusCode == 200) {
        return right(ChirpUserData.fromJson(result.data));
      }
      throw ("Programming error");
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred while retrieving user [$username]."
              "Please try again later.",
          error: e,
        ),
      );
    }
  }
}
