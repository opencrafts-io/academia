import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../data/services/podcast_local_store.dart';
import '../../domain/repositories/study_tools_repository.dart';
import '../audio/podcast_audio_handler.dart';

class StudyMaterialDeletionService {
  StudyMaterialDeletionService({
    required this.repository,
    this.podcastStore,
    this.audioHandler,
  });

  final StudyToolsRepository repository;
  final PodcastLocalStore? podcastStore;
  final PodcastAudioHandler? audioHandler;

  /// The boolean indicates whether local audio cleanup failed.
  Future<Either<Failure, bool>> delete(int id) async {
    final result = await repository.delete(id);
    return result.fold((failure) => Left(failure), (_) async {
      try {
        await audioHandler?.discardIfNote(id);
        await podcastStore?.removeMaterialFiles(id);
        return const Right(false);
      } on Object {
        return const Right(true);
      }
    });
  }
}
