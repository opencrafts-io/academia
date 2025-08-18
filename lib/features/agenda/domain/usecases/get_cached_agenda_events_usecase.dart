import 'package:academia/core/core.dart';
import 'package:academia/features/agenda/agenda.dart';

/// Use case for getting cached agenda events from local storage
/// Returns a stream of agenda events that are stored locally
class GetCachedAgendaEventsUsecase implements StreamUseCase<List<AgendaEvent>, NoParams> {
  final AgendaEventRepository agendaEventRepository;
  
  GetCachedAgendaEventsUsecase({required this.agendaEventRepository});

  @override
  Stream<List<AgendaEvent>> call(NoParams params) {
    return agendaEventRepository.getCachedAgendaEvents();
  }
}
