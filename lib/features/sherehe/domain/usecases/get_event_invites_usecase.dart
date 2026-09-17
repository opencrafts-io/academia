import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class GetEventInvitesUsecase {
  final ShereheRepository repository;

  GetEventInvitesUsecase(this.repository);

  Future<Either<Failure, List<Invite>>> call(String eventId) async {
    return repository.getEventInvites(eventId);
  }
}
