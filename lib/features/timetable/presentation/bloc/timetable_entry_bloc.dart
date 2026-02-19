import 'package:academia/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/timetable/domain/domain.dart';

part 'timetable_entry_event.dart';
part 'timetable_entry_state.dart';

class TimetableEntryBloc
    extends Bloc<TimetableEntryEvent, TimetableEntryState> {
  final WatchAllTimetableEntries watchAllTimetableEntries;
  final WatchTimetableEntriesByTimetableId watchTimetableEntriesByTimetableId;
  final WatchTimetableEntriesByCourseId watchTimetableEntriesByCourseId;
  final WatchTimetableEntriesByUserId watchTimetableEntriesByUserId;
  final WatchTimetableEntriesByInstitutionId
  watchTimetableEntriesByInstitutionId;
  final CreateOrUpdateTimetableEntry createOrUpdateTimetableEntry;
  final CreateOrUpdateTimetableEntries createOrUpdateTimetableEntries;
  final GetTimetableEntryById getTimetableEntryById;
  final DeleteTimetableEntry deleteTimetableEntry;
  final DeleteTimetableEntries deleteTimetableEntries;
  final SyncTimetableEntries syncTimetableEntries;
  final FetchTimetableEntriesFromRemote fetchTimetableEntriesFromRemote;

  TimetableEntryBloc({
    required this.watchAllTimetableEntries,
    required this.watchTimetableEntriesByTimetableId,
    required this.watchTimetableEntriesByCourseId,
    required this.watchTimetableEntriesByUserId,
    required this.watchTimetableEntriesByInstitutionId,
    required this.createOrUpdateTimetableEntry,
    required this.createOrUpdateTimetableEntries,
    required this.getTimetableEntryById,
    required this.deleteTimetableEntry,
    required this.deleteTimetableEntries,
    required this.syncTimetableEntries,
    required this.fetchTimetableEntriesFromRemote,
  }) : super(const TimetableEntryInitial()) {
    on<WatchAllTimetableEntriesEvent>(_onWatchAllTimetableEntries);
    on<WatchTimetableEntriesByTimetableIdEvent>(
      _onWatchTimetableEntriesByTimetableId,
    );
    on<WatchTimetableEntriesByCourseIdEvent>(
      _onWatchTimetableEntriesByCourseId,
    );
    on<WatchTimetableEntriesByUserIdEvent>(_onWatchTimetableEntriesByUserId);
    on<WatchTimetableEntriesByInstitutionIdEvent>(
      _onWatchTimetableEntriesByInstitutionId,
    );
    on<CreateOrUpdateTimetableEntryEvent>(_onCreateOrUpdateTimetableEntry);
    on<CreateOrUpdateTimetableEntriesEvent>(_onCreateOrUpdateTimetableEntries);
    on<GetTimetableEntryByIdEvent>(_onGetTimetableEntryById);
    on<DeleteTimetableEntryEvent>(_onDeleteTimetableEntry);
    on<DeleteTimetableEntriesEvent>(_onDeleteTimetableEntries);
    on<SyncTimetableEntriesEvent>(_onSyncTimetableEntries);
    on<FetchTimetableEntriesFromRemoteEvent>(
      _onFetchTimetableEntriesFromRemote,
    );
  }

  Future<void> _onWatchAllTimetableEntries(
    WatchAllTimetableEntriesEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    await emit.forEach(
      watchAllTimetableEntries(NoParams()),
      onData: (result) {
        return result.fold(
          (failure) =>
              TimetableEntryError(message: _mapFailureToMessage(failure)),
          (entries) => TimetableEntriesLoaded(entries: entries),
        );
      },
      onError: (error, stackTrace) {
        return TimetableEntryError(message: error.toString());
      },
    );
  }

  Future<void> _onWatchTimetableEntriesByTimetableId(
    WatchTimetableEntriesByTimetableIdEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    await emit.forEach(
      watchTimetableEntriesByTimetableId(
        WatchTimetableEntriesByTimetableIdParams(
          timetableId: event.timetableId,
        ),
      ),
      onData: (result) {
        return result.fold(
          (failure) =>
              TimetableEntryError(message: _mapFailureToMessage(failure)),
          (entries) => TimetableEntriesLoaded(entries: entries),
        );
      },
      onError: (error, stackTrace) {
        return TimetableEntryError(message: error.toString());
      },
    );
  }

  Future<void> _onWatchTimetableEntriesByCourseId(
    WatchTimetableEntriesByCourseIdEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    await emit.forEach(
      watchTimetableEntriesByCourseId(
        WatchTimetableEntriesByCourseIdParams(courseId: event.courseId),
      ),
      onData: (result) {
        return result.fold(
          (failure) =>
              TimetableEntryError(message: _mapFailureToMessage(failure)),
          (entries) => TimetableEntriesLoaded(entries: entries),
        );
      },
      onError: (error, stackTrace) {
        return TimetableEntryError(message: error.toString());
      },
    );
  }

  Future<void> _onWatchTimetableEntriesByUserId(
    WatchTimetableEntriesByUserIdEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    await emit.forEach(
      watchTimetableEntriesByUserId(
        WatchTimetableEntriesByUserIdParams(userId: event.userId),
      ),
      onData: (result) {
        return result.fold(
          (failure) =>
              TimetableEntryError(message: _mapFailureToMessage(failure)),
          (entries) => TimetableEntriesLoaded(entries: entries),
        );
      },
      onError: (error, stackTrace) {
        return TimetableEntryError(message: error.toString());
      },
    );
  }

  Future<void> _onWatchTimetableEntriesByInstitutionId(
    WatchTimetableEntriesByInstitutionIdEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    await emit.forEach(
      watchTimetableEntriesByInstitutionId(
        WatchTimetableEntriesByInstitutionIdParams(
          institutionId: event.institutionId,
        ),
      ),
      onData: (result) {
        return result.fold(
          (failure) =>
              TimetableEntryError(message: _mapFailureToMessage(failure)),
          (entries) => TimetableEntriesLoaded(entries: entries),
        );
      },
      onError: (error, stackTrace) {
        return TimetableEntryError(message: error.toString());
      },
    );
  }

  Future<void> _onCreateOrUpdateTimetableEntry(
    CreateOrUpdateTimetableEntryEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    emit(const TimetableEntryLoading());

    final result = await createOrUpdateTimetableEntry(
      CreateOrUpdateTimetableEntryParams(entry: event.entry),
    );

    result.fold(
      (failure) =>
          emit(TimetableEntryError(message: _mapFailureToMessage(failure))),
      (entry) => emit(
        const TimetableEntryOperationSuccess(
          message: 'Timetable entry saved successfully',
        ),
      ),
    );
  }

  Future<void> _onCreateOrUpdateTimetableEntries(
    CreateOrUpdateTimetableEntriesEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    emit(const TimetableEntryLoading());

    final result = await createOrUpdateTimetableEntries(
      CreateOrUpdateTimetableEntriesParams(entries: event.entries),
    );

    result.fold(
      (failure) =>
          emit(TimetableEntryError(message: _mapFailureToMessage(failure))),
      (entries) => emit(
        TimetableEntryOperationSuccess(
          message: '${entries.length} timetable entries saved successfully',
        ),
      ),
    );
  }

  Future<void> _onGetTimetableEntryById(
    GetTimetableEntryByIdEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    emit(const TimetableEntryLoading());

    final result = await getTimetableEntryById(
      GetTimetableEntryByIdParams(id: event.id),
    );

    result.fold(
      (failure) =>
          emit(TimetableEntryError(message: _mapFailureToMessage(failure))),
      (entry) => emit(TimetableEntryLoaded(entry: entry)),
    );
  }

  Future<void> _onDeleteTimetableEntry(
    DeleteTimetableEntryEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    emit(const TimetableEntryLoading());

    final result = await deleteTimetableEntry(
      DeleteTimetableEntryParams(id: event.id),
    );

    result.fold(
      (failure) =>
          emit(TimetableEntryError(message: _mapFailureToMessage(failure))),
      (_) => emit(
        const TimetableEntryOperationSuccess(
          message: 'Timetable entry deleted successfully',
        ),
      ),
    );
  }

  Future<void> _onDeleteTimetableEntries(
    DeleteTimetableEntriesEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    emit(const TimetableEntryLoading());

    final result = await deleteTimetableEntries(
      DeleteTimetableEntriesParams(ids: event.ids),
    );

    result.fold(
      (failure) =>
          emit(TimetableEntryError(message: _mapFailureToMessage(failure))),
      (_) => emit(
        TimetableEntryOperationSuccess(
          message: '${event.ids.length} timetable entries deleted successfully',
        ),
      ),
    );
  }

  Future<void> _onSyncTimetableEntries(
    SyncTimetableEntriesEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    emit(const TimetableEntrySyncing());

    final result = await syncTimetableEntries(NoParams());

    result.fold(
      (failure) =>
          emit(TimetableEntryError(message: _mapFailureToMessage(failure))),
      (_) => emit(const TimetableEntrySyncSuccess()),
    );
  }

  Future<void> _onFetchTimetableEntriesFromRemote(
    FetchTimetableEntriesFromRemoteEvent event,
    Emitter<TimetableEntryState> emit,
  ) async {
    emit(const TimetableEntryLoading());

    final result = await fetchTimetableEntriesFromRemote(
      FetchTimetableEntriesFromRemoteParams(timetableId: event.timetableId),
    );

    result.fold(
      (failure) =>
          emit(TimetableEntryError(message: _mapFailureToMessage(failure))),
      (entries) => emit(TimetableEntriesLoaded(entries: entries)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message ?? 'Server error occurred';
    } else if (failure is CacheFailure) {
      return failure.message ?? 'Local database error occurred';
    } else if (failure is NetworkFailure) {
      return failure.message ?? 'No internet connection';
    } else {
      return 'Unexpected error occurred';
    }
  }
}
