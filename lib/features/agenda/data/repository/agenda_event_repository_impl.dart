import 'package:academia/core/data/paginated_result.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/agenda/agenda.dart';
import 'package:dartz/dartz.dart';

/// Implementation of the AgendaEventRepository interface
/// Handles the coordination between remote and local data sources
/// Following the repository pattern from the todos feature
class AgendaEventRepositoryImpl implements AgendaEventRepository {
  final AgendaEventLocalDataSource agendaEventLocalDataSource;
  final AgendaEventRemoteDatasource agendaEventRemoteDatasource;

  AgendaEventRepositoryImpl({
    required this.agendaEventRemoteDatasource,
    required this.agendaEventLocalDataSource,
  });

  @override
  Stream<List<AgendaEvent>> getCachedAgendaEvents() {
    // Return cached agenda events as a stream, converting from data model to entity
    return agendaEventLocalDataSource.getAgendaEventStream().map(
      (rawAgendaEvents) => rawAgendaEvents.map((rawEvent) => rawEvent.toEntity()).toList(),
    );
  }

  @override
  Future<Either<Failure, AgendaEvent>> deleteAgendaEvent(AgendaEvent event) async {
    // First attempt to delete from remote source
    final remoteRes = await agendaEventRemoteDatasource.deleteAgendaEventData(event.toModel());

    // If remote deletion fails, return the failure
    if (remoteRes.isLeft()) {
      return Left((remoteRes as Left).value);
    }

    // If remote deletion succeeds, delete from local cache
    final localRes = await agendaEventLocalDataSource.deleteAgendaEvent(event.toModel());
    
    // Return the original event if local deletion succeeds, or the failure if it fails
    return localRes.fold((failure) => left(failure), (t) => right(event));
  }

  @override
  Future<Either<Failure, AgendaEvent>> updateAgendaEvent(AgendaEvent event) async {
    // First attempt to update on remote source
    final remoteRes = await agendaEventRemoteDatasource.updateAgendaEvent(event.toModel());

    // If remote update fails, return the failure
    if (remoteRes.isLeft()) {
      return Left((remoteRes as Left).value);
    }

    // If remote update succeeds, update local cache with the updated data
    final localRes = await agendaEventLocalDataSource.createOrUpdateAgendaEvent(
      (remoteRes as Right).value,
    );
    
    // Return the updated entity or the failure
    return localRes.fold(
      (failure) => left(failure),
      (updated) => right(updated.toEntity()),
    );
  }

  @override
  Future<Either<Failure, AgendaEvent>> createAgendaEvent(AgendaEvent event) async {
    // First attempt to create on remote source
    final remoteRes = await agendaEventRemoteDatasource.createAgendaEvent(event.toModel());

    // If remote creation fails, return the failure
    if (remoteRes.isLeft()) {
      return Left((remoteRes as Left).value);
    }

    // If remote creation succeeds, save to local cache
    final localRes = await agendaEventLocalDataSource.createOrUpdateAgendaEvent(
      (remoteRes as Right).value,
    );
    
    // Return the created entity or the failure
    return localRes.fold(
      (failure) => left(failure),
      (created) => right(created.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Stream<List<AgendaEvent>>>> refreshAgendaEvents({
    int page = 1,
    int pageSize = 100,
  }) async {
    // Fetch fresh data from remote source
    final remoteRes = await agendaEventRemoteDatasource.refreshAgendaEvents(
      page: page,
      pageSize: pageSize,
    );

    // If remote fetch fails, return the failure
    if (remoteRes.isLeft()) {
      return Left((remoteRes as Left).value);
    }

    // Get the paginated result from remote
    final data = (remoteRes as Right).value as PaginatedResult<AgendaEventData>;

    // Update local cache with all fetched events
    for (final agendaEvent in data.results) {
      final localRes = await agendaEventLocalDataSource.createOrUpdateAgendaEvent(agendaEvent);
      if (localRes.isLeft()) {
        return left((localRes as Left).value);
      }
    }
    
    // Return the stream of cached events converted to entities
    return Right(
      agendaEventLocalDataSource.getAgendaEventStream().map(
        (elem) => elem.map((event) => event.toEntity()).toList(),
      ),
    );
  }
}
