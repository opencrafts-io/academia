import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/study_entities.dart';
import '../dtos/study_dtos.dart';
import 'study_tools_api_paths.dart';

abstract interface class StudyToolsRemoteDatasource {
  Future<Either<Failure, StudyMaterialsPageResult>> listMaterials(int page);
  Future<Either<Failure, StudyMaterial>> material(int id);
  Future<Either<Failure, StudyMaterial>> upload({
    required PlatformFile file,
    String? courseId,
    String? courseLabel,
  });
  Future<Either<Failure, int>> generate(int noteId, QuestionFormat format);
  Future<Either<Failure, GenerationJob>> job(int id);
  Future<Either<Failure, List<QuestionSet>>> questionSets(
    int noteId,
    QuestionFormat format,
  );
  Future<Either<Failure, Unit>> delete(int noteId);
}

class StudyMaterialsPageResult {
  const StudyMaterialsPageResult({
    required this.count,
    required this.materials,
    required this.next,
  });
  final int count;
  final List<StudyMaterial> materials;
  final String? next;
  bool get hasMore => next != null;
}

@LazySingleton(as: StudyToolsRemoteDatasource)
class StudyToolsRemoteDatasourceImpl implements StudyToolsRemoteDatasource {
  StudyToolsRemoteDatasourceImpl(this._api, this._paths);

  final ApiClient _api;
  final StudyToolsApiPaths _paths;

  @override
  Future<Either<Failure, StudyMaterialsPageResult>> listMaterials(int page) =>
      _api.get(
        _paths.collection,
        queryParameters: {'page': page, 'page_size': 30},
        decoder: (json) {
          final body = Map<String, dynamic>.from(json as Map);
          final rows = (body['results'] as List<dynamic>)
              .map(
                (item) => StudyMaterialDto.fromJson(
                  Map<String, dynamic>.from(item as Map),
                ).toEntity(),
              )
              .toList(growable: false);
          return StudyMaterialsPageResult(
            count: body['count'] as int,
            materials: rows,
            next: body['next'] as String?,
          );
        },
      );

  @override
  Future<Either<Failure, StudyMaterial>> material(int id) => _api.get(
    _paths.detail(id),
    decoder: (json) =>
        StudyMaterialDto.fromJson(Map<String, dynamic>.from(json as Map))
            .toEntity(),
  );

  @override
  Future<Either<Failure, StudyMaterial>> upload({
    required PlatformFile file,
    String? courseId,
    String? courseLabel,
  }) async {
    final filePart = file.path != null
        ? await MultipartFile.fromFile(file.path!, filename: file.name)
        : file.bytes != null
        ? MultipartFile.fromBytes(file.bytes!, filename: file.name)
        : null;
    if (filePart == null) {
      return left(
        Failure.validation(
          message: 'The selected file is unavailable. Please choose it again.',
        ),
      );
    }
    final fields = <String, dynamic>{'file': filePart};
    if (courseId != null) fields['course_id'] = courseId;
    if (courseLabel?.trim().isNotEmpty == true) {
      fields['course_label'] = courseLabel!.trim();
    }
    return _api.post(
      _paths.collection,
      data: FormData.fromMap(fields),
      decoder: (json) =>
          StudyMaterialDto.fromJson(Map<String, dynamic>.from(json as Map))
              .toEntity(),
    );
  }

  @override
  Future<Either<Failure, int>> generate(int noteId, QuestionFormat format) =>
      _api.post(
        _paths.generate(noteId),
        data: {
          'outputs': ['questions'],
          'question_format': format.apiValue,
        },
        decoder: (json) => (json as Map<String, dynamic>)['job_id'] as int,
      );

  @override
  Future<Either<Failure, GenerationJob>> job(int id) => _api.get(
    _paths.job(id),
    decoder: (json) =>
        GenerationJobDto.fromJson(Map<String, dynamic>.from(json as Map))
            .toEntity(),
  );

  @override
  Future<Either<Failure, List<QuestionSet>>> questionSets(
    int noteId,
    QuestionFormat format,
  ) => _api.get(
    _paths.questions(noteId),
    queryParameters: {'format': format.apiValue},
    decoder: (json) {
      final body = Map<String, dynamic>.from(json as Map);
      return (body['sets'] as List<dynamic>)
          .map(
            (item) =>
                QuestionSetDto.fromJson(Map<String, dynamic>.from(item as Map))
                    .toEntity(),
          )
          .toList(growable: false);
    },
  );

  @override
  Future<Either<Failure, Unit>> delete(int noteId) =>
      _api.delete(_paths.detail(noteId), decoder: (_) => unit);
}
