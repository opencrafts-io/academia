import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/agenda_event.dart';
import '../../domain/repositories/agenda_repository.dart';
import '../datasources/agenda_remote_datasource.dart';

class AgendaRepositoryImpl implements AgendaRepository {
  const AgendaRepositoryImpl(this._remoteDatasource);

  final AgendaRemoteDatasource _remoteDatasource;

  @override
  Future<Either<Failure, AgendaPage>> list({
    required int page,
    required int pageSize,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _remoteDatasource.list(
      page: page,
      pageSize: pageSize,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<Either<Failure, AgendaEvent>> create(AgendaEventDraft draft) {
    return _remoteDatasource.create(draft);
  }

  @override
  Future<Either<Failure, AgendaEvent>> update(
    String id,
    AgendaEventDraft draft,
  ) {
    return _remoteDatasource.update(id, draft);
  }

  @override
  Future<Either<Failure, Unit>> delete(String id) {
    return _remoteDatasource.delete(id);
  }
}
