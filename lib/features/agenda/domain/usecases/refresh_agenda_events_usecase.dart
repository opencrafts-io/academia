import 'package:academia/core/core.dart';
import 'package:academia/features/agenda/agenda.dart';
import 'package:dartz/dartz.dart';

/// Use case for refreshing agenda events from remote source
/// Fetches fresh data from the server and updates local cache
class RefreshAgendaEventsUsecase implements UseCase<RefreshAgendaEventsParams, Stream<List<AgendaEvent>>> {
  final AgendaEventRepository agendaEventRepository;
  
  RefreshAgendaEventsUsecase({required this.agendaEventRepository});

  @override
  Future<Either<Failure, Stream<List<AgendaEvent>>>> call(RefreshAgendaEventsParams params) {
    return agendaEventRepository.refreshAgendaEvents(
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

/// Parameters for refreshing agenda events
class RefreshAgendaEventsParams {
  final int page;
  final int pageSize;

  RefreshAgendaEventsParams({
    this.page = 1,
    this.pageSize = 100,
  });
}
