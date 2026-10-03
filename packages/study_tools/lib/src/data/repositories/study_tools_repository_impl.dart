import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/study_entities.dart';
import '../../domain/repositories/study_tools_repository.dart';
import '../datasources/study_tools_local_datasource.dart';
import '../datasources/study_tools_remote_datasource.dart';

@LazySingleton(as: StudyToolsRepository)
class StudyToolsRepositoryImpl implements StudyToolsRepository {
  StudyToolsRepositoryImpl(this.remote, this.local);

  final StudyToolsRemoteDatasource remote;
  final StudyToolsLocalDatasource local;

  @override
  Future<Either<Failure, List<StudyMaterial>>> allMaterials() async {
    final materials = <StudyMaterial>[];
    var page = 1;
    int? expectedCount;
    while (expectedCount == null || materials.length < expectedCount) {
      final result = await remote.listMaterials(page);
      final failed = result.fold<Failure?>((failure) => failure, (_) => null);
      if (failed != null) {
        if (failed is! NetworkFailure) return left(failed);
        final cached = await local.materials();
        if (cached.isNotEmpty) return right(cached);
        return left(failed);
      }
      final data = result.getOrElse(() => throw StateError('Unreachable'));
      expectedCount = data.count;
      materials.addAll(data.materials);
      if (!data.hasMore || data.materials.isEmpty) break;
      page++;
    }
    for (final material in materials) {
      await local.saveMaterial(material);
    }
    return right(materials);
  }

  @override
  Future<Either<Failure, StudyMaterial>> material(int noteId) async {
    final result = await remote.material(noteId);
    return result.fold(
      (failure) async {
        if (failure is! NetworkFailure) return left(failure);
        final cached = (await local.materials()).where((m) => m.id == noteId);
        if (cached.isEmpty) return left(failure);
        return right(cached.first);
      },
      (value) async {
        await local.saveMaterial(value);
        return right(value);
      },
    );
  }

  @override
  Future<Either<Failure, StudyMaterial>> upload({
    required PlatformFile file,
    String? courseId,
    String? courseLabel,
  }) async {
    final result = await remote.upload(
      file: file,
      courseId: courseId,
      courseLabel: courseLabel,
    );
    await result.fold((_) async {}, (material) => local.saveMaterial(material));
    return result;
  }

  @override
  Future<Either<Failure, int>> generate(int noteId, QuestionFormat format) =>
      remote.generate(noteId, format);

  @override
  Future<Either<Failure, GenerationJob>> job(int jobId) => remote.job(jobId);

  @override
  Future<Either<Failure, List<QuestionSet>>> questionSets(
    int noteId,
    QuestionFormat format,
  ) async {
    final result = await remote.questionSets(noteId, format);
    return result.fold(
      (failure) async {
        if (failure is! NetworkFailure) return left(failure);
        return right(await local.questionSets(noteId, format));
      },
      (sets) async {
        await local.saveQuestionSets(noteId, format, sets);
        return right(sets);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> delete(int noteId) async {
    final result = await remote.delete(noteId);
    await result.fold((_) async {}, (_) => local.removeMaterial(noteId));
    return result;
  }

  @override
  Future<Map<int, int>> savedJobs() => local.jobs();

  @override
  Future<void> saveJob(int noteId, int jobId) => local.saveJob(noteId, jobId);

  @override
  Future<void> removeJob(int noteId) => local.removeJob(noteId);
}
