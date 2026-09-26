import 'package:core/core.dart';
import 'package:core/config/flavor.dart';
import 'package:courses/src/data/datasources/course_api_paths.dart';
import 'package:courses/src/data/datasources/course_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('creates a course with only supplied optional fields', () async {
    final apiClient = _RecordingApiClient(
      response: {
        'id': 'b1219a0d-f2ff-4e4b-a983-6833e05f074d',
        'institution': 4,
        'title': 'Algorithms',
        'code': 'CSC201',
        'term_label': null,
        'academic_year': null,
        'term_start_date': null,
        'term_end_date': null,
        'previous_course': null,
        'archived_at': null,
        'created_at': '2026-09-23T10:00:00Z',
        'updated_at': '2026-09-23T10:00:00Z',
        'lecturers': [],
      },
    );
    final datasource = CourseRemoteDatasourceImpl(
      apiClient,
      CourseApiPaths(
        FlavorConfig(
          flavor: Flavor.production,
          appName: 'Academia',
          apiBaseUrl: 'https://example.test',
        ),
      ),
    );

    final result = await datasource.createCourse(
      institutionId: 4,
      title: 'Algorithms',
      code: 'CSC201',
    );

    expect(result.isRight(), isTrue);
    expect(apiClient.path, '/professor/api/courses/create/');
    expect(apiClient.data, {
      'institution': 4,
      'title': 'Algorithms',
      'code': 'CSC201',
    });
  });
}

class _RecordingApiClient implements ApiClient {
  _RecordingApiClient({required this.response});

  final Map<String, dynamic> response;
  String? path;
  Object? data;

  @override
  Future<Either<Failure, T>> delete<T>(
    String path, {
    Object? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    JsonDecoder<T>? decoder,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    JsonDecoder<T>? decoder,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, T>> patch<T>(
    String path, {
    Object? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    JsonDecoder<T>? decoder,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, T>> post<T>(
    String path, {
    Object? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    JsonDecoder<T>? decoder,
  }) async {
    this.path = path;
    this.data = data;
    return Right(decoder!(response));
  }

  @override
  Future<Either<Failure, T>> put<T>(
    String path, {
    Object? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    JsonDecoder<T>? decoder,
  }) => throw UnimplementedError();
}
