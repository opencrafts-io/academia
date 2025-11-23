import 'package:academia/config/config.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/connectivity_checker.dart';
import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

typedef PaginatedAchievements = ({List<StreakMilestoneData> entries, bool hasNext, int totalCount});
typedef PaginatedActivities = ({List<StreakActivityData> entries, bool hasNext, int totalCount});

class AchievementRemoteDatasource with DioErrorHandler, ConnectivityChecker {
  final DioClient dioClient;
  final FlavorConfig flavor;
  late String servicePrefix;

  AchievementRemoteDatasource({
    required this.dioClient,
    required this.flavor,
  }) {
    if (flavor.isProduction) {
      servicePrefix = "verisafe";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-verisafe';
    } else {
      servicePrefix = "dev-verisafe";
    }
  }

  Future<Either<Failure, PaginatedAchievements>> getAchievements(
      {int pageSize = 20, int page = 1}) async {
    if (!await isConnectedToInternet()) {
      return handleNoConnection();
    }
    try {
      final response = await dioClient.dio.get(
        '/$servicePrefix/streaks/milestone/active',
        queryParameters: {
          "page": page,
          "page_size": pageSize,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data["results"] as List;
        final entries = rawData
            .map(
              (e) => StreakMilestoneData.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
        final hasNext = response.data['next'] != null;
        final totalCount = response.data['count'] as int;

        return right((
          entries: entries,
          hasNext: hasNext,
          totalCount: totalCount,
        ));
      }
      throw ("Programming error expected response code 200 instead got ${response.statusCode}");
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

  Future<Either<Failure, PaginatedActivities>> getStreakActivities(
      {int pageSize = 200, int page = 1}) async {
    if (!await isConnectedToInternet()) {
      return handleNoConnection();
    }
    try {
      final response = await dioClient.dio.get(
        '/$servicePrefix/activity/all',
        queryParameters: {
          "page": page,
          "page_size": pageSize,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data["results"] as List;
        final entries = rawData
            .map(
              (e) => StreakActivityData.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
        final hasNext = response.data['next'] != null;
        final totalCount = response.data['count'] as int;

        return right((
          entries: entries,
          hasNext: hasNext,
          totalCount: totalCount,
        ));
      }
      throw ("Programming error expected response code 200 instead got ${response.statusCode}");
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "Something went wrong while trying to get activities",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, StreakMilestoneData>> getAchievementById(String id) async {
    if (!await isConnectedToInternet()) {
      return handleNoConnection();
    }
    try {
      final response = await dioClient.dio.get(
        '/$servicePrefix/streaks/milestone/$id',
      );

      if (response.statusCode == 200) {
        return right(StreakMilestoneData.fromJson(response.data));
      }
      throw ("Programming error expected response code 200 instead got ${response.statusCode}");
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
