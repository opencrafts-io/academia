import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/agenda_event.dart';

abstract interface class AgendaRepository {
  Future<Either<Failure, AgendaPage>> list({
    required int page,
    required int pageSize,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<Failure, AgendaEvent>> create(AgendaEventDraft draft);

  Future<Either<Failure, AgendaEvent>> update(
    String id,
    AgendaEventDraft draft,
  );

  Future<Either<Failure, Unit>> delete(String id);
}
