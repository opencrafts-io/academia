import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/agenda_event.dart';
import '../dtos/agenda_event_dto.dart';
import 'agenda_api_paths.dart';

class AgendaRemoteDatasource {
  const AgendaRemoteDatasource(this._apiClient, this._paths);

  final ApiClient _apiClient;
  final AgendaApiPaths _paths;

  Future<Either<Failure, AgendaPage>> list({
    required int page,
    required int pageSize,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _apiClient.get(
      _paths.collection,
      queryParameters: {
        'page': page,
        'page_size': pageSize.clamp(1, 100),
        'sync': true,
        if (startDate != null) 'start_date': _dateOnly(startDate),
        if (endDate != null) 'end_date': _dateOnly(endDate),
      },
      decoder: (json) =>
          AgendaEventDto.pageFromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Future<Either<Failure, AgendaEvent>> create(AgendaEventDraft draft) {
    return _apiClient.post(
      _paths.create,
      data: AgendaEventDto.requestJson(draft),
      headers: const {'Content-Type': 'application/json'},
      decoder: _decodeEvent,
    );
  }

  Future<Either<Failure, AgendaEvent>> update(
    String id,
    AgendaEventDraft draft,
  ) {
    return _apiClient.patch(
      _paths.update(id),
      data: AgendaEventDto.requestJson(draft),
      headers: const {'Content-Type': 'application/json'},
      decoder: _decodeEvent,
    );
  }

  Future<Either<Failure, Unit>> delete(String id) {
    return _apiClient.delete(
      _paths.delete(id),
      headers: const {'Content-Type': 'application/json'},
      decoder: (_) => unit,
    );
  }

  AgendaEvent _decodeEvent(dynamic json) {
    return AgendaEventDto.fromJson(Map<String, dynamic>.from(json as Map))
        .event;
  }
}

String _dateOnly(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}
