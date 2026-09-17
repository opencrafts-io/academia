import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class CreateEventInviteUsecase {
  final ShereheRepository repository;

  CreateEventInviteUsecase(this.repository);

  Future<Either<Failure, String>> call({
    required String eventId,
    required int maxUses,
    required String expiresAt,
  }) async {
    return repository.createEventInvite(
      eventId: eventId,
      maxUses: maxUses,
      expiresAt: expiresAt,
    );
  }
}
