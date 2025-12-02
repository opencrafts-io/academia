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

  // Flag to enable/disable dummy data
  static const bool _useDummyData = true;

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

  // Dummy data for testing
  List<Map<String, dynamic>> _getDummyExamData() {
    return [
      {
        "course_code": "LLB 100A",
        "institution_id": "5426",
        "day": "MONDAY 06/12/25",
        "time": "9:00AM-11:00AM",
        "venue": "MM1",
        "hrs": "2",
        "campus": "Main Campus",
        "coordinator": "Dr. John Smith",
        "invigilator": "Prof. Jane Doe",
        "datetime_str": "2025-12-06T09:00:00Z",
      },
      {
        "course_code": "MUS314A",
        "institution_id": "5426",
        "day": "MONDAY 05/12/25",
        "time": "9:00AM-11:00AM",
        "venue": "MUS2",
        "hrs": "2",
        "campus": "",
        "coordinator": "",
        "invigilator": "",
        "datetime_str": "2025-12-05T09:00:00Z",
      },
      {
        "course_code": "EDU363B",
        "institution_id": "5426",
        "day": "TUESDAY 04/12/25",
        "time": "10:00AM-12:00PM",
        "venue": "SB-301",
        "hrs": "2",
        "campus": "South Campus",
        "coordinator": "Dr. Alice Brown",
        "invigilator": "",
        "datetime_str": "2025-12-04T10:00:00Z",
      },
      {
        "course_code": "TPC426A",
        "institution_id": "5426",
        "day": "TUESDAY 03/12/25",
        "time": "10:00AM-12:00PM",
        "venue": "SB-302",
        "hrs": "2",
        "campus": "",
        "coordinator": "",
        "invigilator": "Dr. Michael Johnson",
        "datetime_str": "2025-12-03T10:00:00Z",
      },
      {
        "course_code": "BIL111K",
        "institution_id": "5426",
        "day": "WEDNESDAY 02/12/25",
        "time": "2:00PM-4:00PM",
        "venue": "LAB-A",
        "hrs": "2",
        "campus": "Tech Campus",
        "coordinator": "Prof. Sarah Wilson",
        "invigilator": "Dr. Robert Lee",
        "datetime_str": "2025-12-02T14:00:00Z",
      },
      {
        "course_code": "BIL111A",
        "institution_id": "5426",
        "day": "WEDNESDAY 02/12/25",
        "time": "2:00PM-4:00PM",
        "venue": "LAB-B",
        "hrs": "2",
        "campus": "",
        "coordinator": "",
        "invigilator": "",
        "datetime_str": "2025-12-02T14:00:00Z",
      },
      {
        "course_code": "BIL111D",
        "institution_id": "5426",
        "day": "WEDNESDAY 02/12/25",
        "time": "2:00PM-4:00PM",
        "venue": "LAB-C",
        "hrs": "2",
        "campus": "Tech Campus",
        "coordinator": "",
        "invigilator": "",
        "datetime_str": "2025-12-02T14:00:00Z",
      },
      {
        "course_code": "ENG111R",
        "institution_id": "5426",
        "day": "THURSDAY 02/12/25",
        "time": "11:00AM-2:00PM",
        "venue": "HALL-201",
        "hrs": "3",
        "campus": "Main Campus",
        "coordinator": "Dr. Emily Davis",
        "invigilator": "Prof. Mark Taylor",
        "datetime_str": "2025-12-02T11:00:00Z",
      },
      {
        "course_code": "MAT121K",
        "institution_id": "5426",
        "day": "FRIDAY 02/12/25",
        "time": "8:00AM-10:00AM",
        "venue": "ROOM-101",
        "hrs": "2",
        "campus": "",
        "coordinator": "Prof. David Chen",
        "invigilator": "",
        "datetime_str": "2025-12-02T08:00:00Z",
      },
      // Past exam for testing
      {
        "course_code": "CS100A",
        "institution_id": "5426",
        "day": "MONDAY 01/12/25",
        "time": "9:00AM-11:00AM",
        "venue": "LAB-1",
        "hrs": "2",
        "campus": "Tech Campus",
        "coordinator": "Dr. James Wilson",
        "invigilator": "Prof. Lisa Martin",
        "datetime_str": "2025-12-01T09:00:00Z",
      },
    ];
  }

  // Filter dummy data based on course codes
  List<Map<String, dynamic>> _filterDummyData(List<String> courseCodes) {
    final allData = _getDummyExamData();
    if (courseCodes.isEmpty) return allData;

    return allData.where((exam) {
      final code = (exam['course_code'] as String).toLowerCase();
      return courseCodes.any((search) => code.contains(search.toLowerCase()));
    }).toList();
  }

  Future<Either<Failure, List<ExamTimetableData>>> getExamTimetable({
    required String institutionId,
    required List<String> courseCodes,
  }) async {
    // Use dummy data if flag is enabled
    if (_useDummyData) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      try {
        final filteredData = _filterDummyData(courseCodes);
        final results = filteredData
            .map((e) => ExamTimetableData.fromJson(e))
            .toList();

        return Right(results);
      } catch (e) {
        return left(
          CacheFailure(
            error: e,
            message:
                // "Another Brick in the Wall" - Pink Floyd
                "We don't need no education... but we do need a working connection! Couldn't fetch your exam timetable. The system is in detention!",
          ),
        );
      }
    }

    // Real API call (when backend is ready)
    try {
      final response = await dioClient.dio.post(
        "/$servicePath/exams/",
        data: {"institution_id": institutionId, "course_codes": courseCodes},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final results = (response.data as List)
            .map((e) => ExamTimetableData.fromJson(e as Map<String, dynamic>))
            .toList();

        return Right(results);
      }

      return left(
        NetworkFailure(error: "", message: "Failed to fetch exam timetable"),
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Another Brick in the Wall" - Pink Floyd
              "We don't need no education... but we do need a working connection! Couldn't fetch your exam timetable. The system is in detention!",
        ),
      );
    }
  }

  Future<Either<Failure, List<ExamTimetableData>>> refreshExamTimetable({
    required String institutionId,
    List<String>? courseCodes,
  }) async {
    // Use dummy data if flag is enabled
    if (_useDummyData) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1000));

      try {
        final filteredData = courseCodes != null && courseCodes.isNotEmpty
            ? _filterDummyData(courseCodes)
            : _getDummyExamData();

        final results = filteredData
            .map((e) => ExamTimetableData.fromJson(e))
            .toList();

        return Right(results);
      } catch (e) {
        return left(
          CacheFailure(
            error: e,
            message:
                // "The Final Countdown" - Europe
                "It's the final countdown... but the exam schedule won't load! We're having technical difficulties before the big day!",
          ),
        );
      }
    }

    // Real API call (when backend is ready)
    try {
      final response = await dioClient.dio.post(
        "/$servicePath/exams/",
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
        NetworkFailure(error: "", message: "Failed to refresh exam timetable"),
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "The Final Countdown" - Europe
              "It's the final countdown... but the exam schedule won't load! We're having technical difficulties before the big day!",
        ),
      );
    }
  }
}
