import 'package:academia/config/config.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/features/chirp/memberships/data/dtos/chirp_community_membership_api_dto.dart';
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

  Future<Either<Failure, List<ChirpCommunityMembershipApiDto>>>
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
                (e) => ChirpCommunityMembershipApiDto.fromJson(
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

  Future<Either<Failure, ChirpCommunityMembershipApiDto>>
  getPersonalMembershipByCommunityID({required int communityID}) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/community/memberships/mine/for/$communityID",
      );

      if (response.statusCode == 200) {
        return right(ChirpCommunityMembershipApiDto.fromJson(response.data));
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
  Future<Either<Failure, ChirpCommunityMembershipApiDto>> joinCommunity({
    required int communityID,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePrefix/community/$communityID/join/",
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> rawData =
            response.data as Map<String, dynamic>;
        return right(ChirpCommunityMembershipApiDto.fromJson(rawData));
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
    required int communityID,
  }) async {
    try {
      final response = await dioClient.dio.delete(
        "/$servicePrefix/community/$communityID/leave/",
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

  Future<Either<Failure, List<ChirpCommunityMembershipApiDto>>>
  getCommunityMemberships(
    int communityID, {
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/community/$communityID/memberships",
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data["results"] as List;
        return right(
          rawData
              .map(
                (e) => ChirpCommunityMembershipApiDto.fromJson(
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
}
