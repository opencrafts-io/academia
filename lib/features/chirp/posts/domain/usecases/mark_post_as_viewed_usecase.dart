import 'package:academia/features/chirp/chirp.dart';

class MarkPostAsViewedUsecase {
  final ChirpRepository repository;

  MarkPostAsViewedUsecase({required this.repository});

  Future<void> call({required int postId, required String viewerId}) async {
    await repository.markPostAsViewed(postId: postId, viewerId: viewerId);
  }
}
