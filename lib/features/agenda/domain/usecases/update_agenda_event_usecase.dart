import 'package:academia/core/core.dart';
import 'package:academia/features/agenda/agenda.dart';
import 'package:dartz/dartz.dart';

/// Use case for updating an existing agenda event
/// Updates the event on remote source and caches the updated version locally
class UpdateAgendaEventUsecase implements UseCase<AgendaEvent, AgendaEvent> {
  final AgendaEventRepository agendaEventRepository;
  
  UpdateAgendaEventUsecase({required this.agendaEventRepository});

  @override
  Future<Either<Failure, AgendaEvent>> call(AgendaEvent agendaEvent) {
    return agendaEventRepository.updateAgendaEvent(agendaEvent);
  }
}
