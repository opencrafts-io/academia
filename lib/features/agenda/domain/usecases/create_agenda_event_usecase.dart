import 'package:academia/core/core.dart';
import 'package:academia/features/agenda/agenda.dart';
import 'package:dartz/dartz.dart';

/// Use case for creating a new agenda event
/// Creates the event on remote source and caches it locally
class CreateAgendaEventUsecase implements UseCase<AgendaEvent, AgendaEvent> {
  final AgendaEventRepository agendaEventRepository;
  
  CreateAgendaEventUsecase({required this.agendaEventRepository});

  @override
  Future<Either<Failure, AgendaEvent>> call(AgendaEvent agendaEvent) {
    return agendaEventRepository.createAgendaEvent(agendaEvent);
  }
}
