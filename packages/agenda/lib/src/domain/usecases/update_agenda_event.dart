import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/agenda_event.dart';
import '../repositories/agenda_repository.dart';

class UpdateAgendaEventParams {
  const UpdateAgendaEventParams({required this.id, required this.draft});

  final String id;
  final AgendaEventDraft draft;
}

class UpdateAgendaEvent {
  const UpdateAgendaEvent(this._repository);

  final AgendaRepository _repository;

  Future<Either<Failure, AgendaEvent>> call(UpdateAgendaEventParams params) {
    return _repository.update(params.id, params.draft);
  }
}
