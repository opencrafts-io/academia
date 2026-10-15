import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/agenda_event.dart';
import '../repositories/agenda_repository.dart';

class ListAgendaEventsParams {
  const ListAgendaEventsParams({
    this.page = 1,
    this.pageSize = 20,
    this.startDate,
    this.endDate,
  });

  final int page;
  final int pageSize;
  final DateTime? startDate;
  final DateTime? endDate;
}

class ListAgendaEvents {
  const ListAgendaEvents(this._repository);

  final AgendaRepository _repository;

  Future<Either<Failure, AgendaPage>> call(ListAgendaEventsParams params) {
    return _repository.list(
      page: params.page,
      pageSize: params.pageSize,
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}
