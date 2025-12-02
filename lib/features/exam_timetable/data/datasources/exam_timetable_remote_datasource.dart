import 'package:academia/config/config.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ExamTimetableRemoteDatasource with DioErrorHandler {
  final DioClient dioClient;
  late String servicePath;
  final FlavorConfig flavor;


  ExamTimetableRemoteDatasource({
    required this.dioClient,
    required this.flavor,
  }) {
    if (flavor.isProduction) {
      servicePath = "professor";
    } else if (flavor.isStaging) {
      servicePath = 'qa-professor';
    } else {
      servicePath = "dev-professor";
    }
  }


  Future<Either<Failure, List<ExamTimetableData>>> _fetchExamTimetable({
    required String institutionId,
    List<String>? courseCodes,
    required String operationName,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePath/api/exams/by-codes/",
        data: {
          "institution_id": institutionId,
          if (courseCodes != null && courseCodes.isNotEmpty)
            "course_codes": courseCodes,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final results = (response.data as List)
            .map((e) => ExamTimetableData.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(results);
      }

      return left(
        NetworkFailure(
          error: "HTTP ${response.statusCode}",
          message: "Failed to $operationName exam timetable",
        ),
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Could not $operationName your exam timetable. Please check your connection and try again.",
        ),
      );
    }
  }

  Future<Either<Failure, List<ExamTimetableData>>> getExamTimetable({
    required String institutionId,
    required List<String> courseCodes,
  }) async {
    return _fetchExamTimetable(
      institutionId: institutionId,
      courseCodes: courseCodes,
      operationName: "fetch",
    );
  }

  Future<Either<Failure, List<ExamTimetableData>>> refreshExamTimetable({
    required String institutionId,
    List<String>? courseCodes,
  }) async {
    return _fetchExamTimetable(
      institutionId: institutionId,
      courseCodes: courseCodes,
      operationName: "refresh",
    );
  }
}
