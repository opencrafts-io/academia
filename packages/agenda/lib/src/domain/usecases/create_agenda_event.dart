import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/agenda_event.dart';
import '../repositories/agenda_repository.dart';

class CreateAgendaEvent {
  const CreateAgendaEvent(this._repository);

  final AgendaRepository _repository;

  Future<Either<Failure, AgendaEvent>> call(AgendaEventDraft draft) {
    return _repository.create(draft);
  }
}
