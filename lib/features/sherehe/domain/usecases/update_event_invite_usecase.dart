import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class UpdateEventInviteUsecase {
  final ShereheRepository repository;

  UpdateEventInviteUsecase(this.repository);

  Future<Either<Failure, Invite>> call({
    required String inviteId,
    int? maxUses,
    String? expiresAt,
  }) async {
    return repository.updateEventInvite(
      inviteId: inviteId,
      maxUses: maxUses,
      expiresAt: expiresAt,
    );
  }
}
