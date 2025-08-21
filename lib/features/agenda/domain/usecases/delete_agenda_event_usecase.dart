import 'package:academia/core/core.dart';
import 'package:academia/features/agenda/agenda.dart';
import 'package:dartz/dartz.dart';

/// Use case for deleting an agenda event
/// Deletes the event from remote source and removes it from local cache
class DeleteAgendaEventUsecase implements UseCase<AgendaEvent, AgendaEvent> {
  final AgendaEventRepository agendaEventRepository;
  
  DeleteAgendaEventUsecase({required this.agendaEventRepository});

  @override
  Future<Either<Failure, AgendaEvent>> call(AgendaEvent agendaEvent) {
    return agendaEventRepository.deleteAgendaEvent(agendaEvent);
  }
}
