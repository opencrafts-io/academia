import 'dart:typed_data';

import 'package:core/config/flavor.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_tools/src/data/datasources/study_tools_api_paths.dart';
import 'package:study_tools/src/data/datasources/study_tools_remote_datasource.dart';
import 'package:study_tools/src/domain/entities/study_entities.dart';

void main() {
  const courseId = 'b1219a0d-f2ff-4e4b-a983-6833e05f074d';

  test(
    'uploads multipart data with the course UUID and optional label',
    () async {
      final api = _RecordingApiClient(_materialResponse);
      final datasource = StudyToolsRemoteDatasourceImpl(api, _paths);

      final result = await datasource.upload(
        file: PlatformFile(
          name: 'lecture.pdf',
          size: 4,
          bytes: Uint8List.fromList([1, 2, 3, 4]),
        ),
        courseId: courseId,
        courseLabel: 'Algorithms',
      );

      final body = api.data! as FormData;
      expect(result.isRight(), isTrue);
      expect(api.path, '/qa-professor/api/notes/');
      expect(
        body.fields.any(
          (field) => field.key == 'course_id' && field.value == courseId,
        ),
        isTrue,
      );
      expect(
        body.fields.any(
          (field) => field.key == 'course_label' && field.value == 'Algorithms',
        ),
        isTrue,
      );
      expect(body.files.single.key, 'file');
    },
  );

  test('requests pages by number through the known notes path', () async {
    final api = _RecordingApiClient({
      'count': 31,
      'next': 'https://other-host.invalid/notes/?page=2',
      'previous': null,
      'results': [_materialResponse],
    });
    final datasource = StudyToolsRemoteDatasourceImpl(api, _paths);

    final result = await datasource.listMaterials(2);

    expect(api.path, '/qa-professor/api/notes/');
    expect(api.queryParameters, {'page': 2, 'page_size': 30});
    expect(
      result.getOrElse(() => throw StateError('Expected a page')).hasMore,
      isTrue,
    );
  });

  test(
    'sends one explicit question format and accepts a bodyless delete',
    () async {
      final api = _RecordingApiClient({'job_id': 62});
      final datasource = StudyToolsRemoteDatasourceImpl(api, _paths);

      final generated = await datasource.generate(14, QuestionFormat.openEnded);
      expect(generated.getOrElse(() => -1), 62);
      expect(api.path, '/qa-professor/api/notes/14/generate/');
      expect(api.data, {
        'outputs': ['questions'],
        'question_format': 'open_ended',
      });

      api.response = null;
      final deleted = await datasource.delete(14);
      expect(deleted.isRight(), isTrue);
      expect(api.path, '/qa-professor/api/notes/14/');
    },
  );

  test('generates and fetches a podcast from an existing material', () async {
    final api = _RecordingApiClient({'job_id': 73});
    final datasource = StudyToolsRemoteDatasourceImpl(api, _paths);

    final jobId = await datasource.generatePodcast(14);
    expect(jobId.getOrElse(() => -1), 73);
    expect(api.path, '/qa-professor/api/notes/14/generate/');
    expect(api.data, {
      'outputs': ['podcast'],
    });

    api.response = {
      'id': 17,
      'note_id': 14,
      'title': 'Algorithms, in conversation',
      'generated_at': '2026-10-03T12:00:00Z',
      'duration_seconds': 420,
      'audio_url': 'https://cdn.example.test/episode.mp3',
      'script': 'Host: Start here.',
    };
    final podcast = await datasource.podcast(14);
    expect(api.path, '/qa-professor/api/notes/14/podcast/');
    expect(
      podcast.getOrElse(() => throw StateError('Expected podcast')).id,
      17,
    );
  });
}

final _paths = StudyToolsApiPaths(
  FlavorConfig(
    flavor: Flavor.staging,
    appName: 'Academia QA',
    apiBaseUrl: 'https://example.test',
  ),
);

final _materialResponse = {
  'id': 14,
  'course_id': 'b1219a0d-f2ff-4e4b-a983-6833e05f074d',
  'course_label': 'Algorithms',
  'original_filename': 'lecture.pdf',
  'size_bytes': 4,
  'uploaded_at': '2026-10-01T12:00:00Z',
};

class _RecordingApiClient implements ApiClient {
  _RecordingApiClient(this.response);
  Object? response;
  String? path;
  Object? data;
  Map<String, dynamic>? queryParameters;

  @override
  Future<Either<Failure, T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) async {
    this.path = path;
    this.data = data;
    this.queryParameters = queryParameters;
    return right(decoder == null ? response as T : decoder(response));
  }

  @override
  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) async {
    this.path = path;
    this.queryParameters = queryParameters;
    return right(decoder == null ? response as T : decoder(response));
  }

  @override
  Future<Either<Failure, T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) async {
    this.path = path;
    return right(decoder == null ? response as T : decoder(response));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
