import 'package:academia/config/config.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class InstitutionCommandRemoteDatasource
    with DioErrorHandler, ConnectivityChecker {
  final DioClient dioClient;
  late String servicePrefix;
  final FlavorConfig flavor;

  InstitutionCommandRemoteDatasource({
    required this.dioClient,
    required this.flavor,
  }) {
    if (flavor.isProduction) {
      servicePrefix = "professor";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-professor';
    } else {
      servicePrefix = "dev-professor";
    }
  }

  Future<Either<Failure, InstitutionScrappingCommandData>>
  fetchInstitutionScrappingCommandByInstitution({
    required int institutionID,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/api/magnet/command/for/$institutionID",
      );

      if (response.statusCode == 200) {
        return right(InstitutionScrappingCommandData.fromJson(response.data));
      }

      throw ("Wrong status code returned from server expected 200 got ${response.statusCode}");
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "Failed to fetch remote configs for institution ",
          error: e,
        ),
      );
    }
  }
}
