import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class GetEventByInviteUsecase {
  final ShereheRepository repository;

  GetEventByInviteUsecase(this.repository);

  Future<Either<Failure, Event>> call({required String invite}) async {
    return repository.getEventByInvite(invite: invite);
  }
}
