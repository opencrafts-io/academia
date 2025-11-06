import 'package:academia/config/flavor.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class LeaderboardRemoteDataSource with DioErrorHandler, ConnectivityChecker {
  final DioClient dioClient;
  late String servicePath;
  final FlavorConfig flavor;

  LeaderboardRemoteDataSource({required this.dioClient, required this.flavor}) {
    if (flavor.isProduction) {
      servicePath = "verisafe";
    } else if (flavor.isStaging) {
      servicePath = 'qa-verisafe';
    } else {
      servicePath = "dev-verisafe";
    }
  }

  Future<Either<Failure, PaginatedResponse<LeaderboardRankData>>>
  getGlobalLeaderboard({required int page, required int pageSize}) async {
    try {
      final response = await dioClient.dio.get(
        '$servicePath/leaderboard/global',
        queryParameters: {'page': page, 'page_size': pageSize},
      );

      if (response.statusCode == 200) {
        return right(
          PaginatedResponse.fromJson(
            response.data,
            (json) =>
                LeaderboardRankData.fromJson(json as Map<String, dynamic>),
          ),
        );
      }
      throw Exception("Programming error");
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        NetworkFailure(
          message: "Error retrieving leaderboard at the momemnt",
          error: e,
        ),
      );
    }
  }
}
