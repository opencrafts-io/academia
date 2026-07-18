import 'dart:convert';

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

  /// Parses a single API response entry into an [ExamTimetable].
  ///
  /// New API shape:
  /// ```json
  /// {
  ///   "course_code": "NUR 225\nSPECIALTY 1",
  ///   "start_time": "2026-04-24T05:30:00Z",
  ///   "end_time":   "2026-04-24T08:30:00Z",
  ///   "venue":      "DMMLC",
  ///   "coordinator": "HENRY KILEMI",   // optional
  ///   "hrs":        "3",               // optional
  ///   "raw_data": {                    // optional
  ///     "original_day": "FRI\n24/4/26",
  ///     "campus":       "ATHI RIVER",
  ///     "invigilator":  "JOYSTACY/ JOY"
  ///   }
  /// }
  /// ```
  ///
  /// The response entries don't echo back an institution id, so it's
  /// stamped on from the request scope instead.
  ExamTimetable _parseEntry(Map<String, dynamic> json, int institutionId) {
    final startTimeStr = json['start_time'] as String;
    final endTimeStr = json['end_time'] as String;

    // Parse ISO 8601 datetimes; the API returns UTC strings.
    final datetimeStr = DateTime.parse(startTimeStr).toLocal();

    final rawDataJson = json['raw_data'];
    String? rawDataEncoded;
    if (rawDataJson is Map<String, dynamic>) {
      rawDataEncoded = jsonEncode(rawDataJson);
    }

    return ExamTimetable(
      institutionId: institutionId,
      courseCode: (json['course_code'] as String? ?? '').trim(),
      startTime: startTimeStr,
      endTime: endTimeStr,
      venue: (json['venue'] as String? ?? '').trim(),
      coordinator: (json['coordinator'] as String? ?? '').trim(),
      hrs: (json['hrs'] as String? ?? '').trim(),
      rawData: rawDataEncoded,
      datetimeStr: datetimeStr,
    );
  }

  Future<Either<Failure, List<ExamTimetable>>> _fetchExamTimetable({
    required int institutionId,
    List<String>? courseCodes,
    required String operationName,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePath/api/exams/by-codes/",
        data: {
          "institution_id": institutionId,
          if (courseCodes != null && courseCodes.isNotEmpty)
            "course_codes": courseCodes
                .map((c) => c.replaceAll('-', ''))
                .toList(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null || response.data is! List) {
          return left(
            NetworkFailure(
              error: "Invalid response format",
              message: "Failed to $operationName exam timetable",
            ),
          );
        }
        final results = (response.data as List)
            .map((e) => _parseEntry(e as Map<String, dynamic>, institutionId))
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

  Future<Either<Failure, List<ExamTimetable>>> getExamTimetable({
    required int institutionId,
    required List<String> courseCodes,
  }) async {
    return _fetchExamTimetable(
      institutionId: institutionId,
      courseCodes: courseCodes,
      operationName: "fetch",
    );
  }

  Future<Either<Failure, List<ExamTimetable>>> refreshExamTimetable({
    required int institutionId,
    List<String>? courseCodes,
  }) async {
    return _fetchExamTimetable(
      institutionId: institutionId,
      courseCodes: courseCodes,
      operationName: "refresh",
    );
  }
}
