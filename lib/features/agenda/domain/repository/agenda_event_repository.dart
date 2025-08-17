import "package:academia/core/error/failures.dart";
import "package:academia/features/agenda/domain/domain.dart";
import "package:dartz/dartz.dart";

abstract class AgendaEventRepository {
  Future<Either<Failure, AgendaEvent>> createAgendaEvent(AgendaEvent event);
  Future<Either<Failure, Stream<List<AgendaEvent>>>> refreshAgendaEvents({
    int page = 1,
    int pageSize = 100,
  });
  Stream<List<AgendaEvent>> getCachedAgendaEvents();
  Future<Either<Failure, AgendaEvent>> updateAgendaEvent(AgendaEvent event);
  Future<Either<Failure, AgendaEvent>> deleteAgendaEvent(AgendaEvent event);
}
