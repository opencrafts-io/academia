import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/agenda_repository.dart';

class DeleteAgendaEvent {
  const DeleteAgendaEvent(this._repository);

  final AgendaRepository _repository;

  Future<Either<Failure, Unit>> call(String id) => _repository.delete(id);
}
