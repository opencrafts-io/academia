import 'package:academia/config/config.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ChirpCommunityMembershipRemoteDatasource with DioErrorHandler {
  final DioClient dioClient;
  final FlavorConfig flavor;
  late String servicePrefix;

  ChirpCommunityMembershipRemoteDatasource({
    required this.dioClient,
    required this.flavor,
  }) {
    if (flavor.isProduction) {
      servicePrefix = "chirp";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-chirp';
    } else {
      servicePrefix = "dev-chirp";
    }
  }

  Future<Either<Failure, List<ChirpCommunityMembershipData>>>
  getPersonalMemberships({int pageSize = 0, int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/community/memberships/mine",
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data["results"] as List;
        return right(
          rawData
              .map(
                (e) => ChirpCommunityMembershipData.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
      }
      throw (
        "Programming error expected response code 200 instead got ${response.statusCode}",
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "Something went wrong while trying to reach server",
          error: e,
        ),
      );
    }
  }

  /// Sends a request to the server to join a community.
  Future<Either<Failure, ChirpCommunityMembershipData>> joinCommunity({
    required String communityID,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePrefix/community/$communityID/join/",
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> rawData =
            response.data as Map<String, dynamic>;
        return right(ChirpCommunityMembershipData.fromJson(rawData));
      }
      throw (
        "Programming error expected response code 200 or 201 instead got ${response.statusCode}",
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message:
              "Failed to join community due to a server error (Join Community)",
          error: e,
        ),
      );
    }
  }

  /// Sends a request to the server to leave a community.
  Future<Either<Failure, void>> leaveCommunity({
    required String membershipID,
  }) async {
    try {
      // API endpoint to leave a community (DELETE request)
      final response = await dioClient.dio.delete(
        "/$servicePrefix/community/$membershipID/leave/",
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      }
      throw (
        "Programming error expected response code 200 or 204 instead got ${response.statusCode}",
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message:
              "Failed to leave community due to a server error (Leave Community)",
          error: e,
        ),
      );
    }
  }
}
