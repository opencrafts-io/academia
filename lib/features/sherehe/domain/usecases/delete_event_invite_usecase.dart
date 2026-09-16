import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class DeleteEventInviteUsecase {
  final ShereheRepository repository;

  DeleteEventInviteUsecase(this.repository);

  Future<Either<Failure, String>> call({required String inviteId}) async {
    return repository.deleteEventInvite(inviteId: inviteId);
  }
}
