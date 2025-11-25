import 'package:academia/config/flavor.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class StreakActivityRemoteDatasource {
  Future<Either<Failure, PaginatedResponse<StreakActivityData>>> getActivities({
    required int page,
    int pageSize = 100,
  });
}

class StreakActivityRemoteDatasourceImpl extends StreakActivityRemoteDatasource
    with DioErrorHandler, ConnectivityChecker {
  final DioClient dioClient;
  late String servicePath;
  final FlavorConfig flavor;

  StreakActivityRemoteDatasourceImpl({
    required this.flavor,
    required this.dioClient,
  }) {
    if (flavor.isProduction) {
      servicePath = "verisafe";
    } else if (flavor.isStaging) {
      servicePath = 'qa-verisafe';
    } else {
      servicePath = "dev-verisafe";
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<StreakActivityData>>> getActivities({
    required int page,
    int pageSize = 100,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }
      final response = await dioClient.dio.get(
        '/$servicePath/activity/active',
        queryParameters: {'page': page, 'page_size': pageSize},
      );

      if (response.statusCode == 200) {
        return right(
          PaginatedResponse.fromJson(
            response.data,
            (json) => StreakActivityData.fromJson(json as Map<String, dynamic>),
          ),
        );
      }
      throw Exception(
        "Programming error expected server code 200 instead got [${response.statusCode}]",
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        NetworkFailure(
          message: "Error retrieving streak activities at the moment",
          error: e,
        ),
      );
    }
  }
}
