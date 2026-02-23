import 'package:academia/core/core.dart';
import 'package:academia/features/timetable/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  final WatchAllTimetables watchAllTimetables;
  final WatchTimetablesByUserId watchTimetablesByUserId;
  final WatchTimetablesByInstitutionId watchTimetablesByInstitutionId;
  final CreateOrUpdateTimetable createOrUpdateTimetable;
  final GetTimetableById getTimetableById;
  final DeleteTimetable deleteTimetable;
  final SyncTimetables syncTimetables;
  final FetchTimetablesFromRemote fetchTimetablesFromRemote;

  TimetableBloc({
    required this.watchAllTimetables,
    required this.watchTimetablesByUserId,
    required this.watchTimetablesByInstitutionId,
    required this.createOrUpdateTimetable,
    required this.getTimetableById,
    required this.deleteTimetable,
    required this.syncTimetables,
    required this.fetchTimetablesFromRemote,
  }) : super(const TimetableInitial()) {
    on<WatchAllTimetablesEvent>(_onWatchAllTimetables);
    on<WatchTimetablesByUserIdEvent>(_onWatchTimetablesByUserId);
    on<WatchTimetablesByInstitutionIdEvent>(_onWatchTimetablesByInstitutionId);
    on<CreateOrUpdateTimetableEvent>(_onCreateOrUpdateTimetable);
    on<GetTimetableByIdEvent>(_onGetTimetableById);
    on<DeleteTimetableEvent>(_onDeleteTimetable);
    on<SyncTimetablesEvent>(_onSyncTimetables);
    on<FetchTimetablesFromRemoteEvent>(_onFetchTimetablesFromRemote);
  }

  Future<void> _onWatchAllTimetables(
    WatchAllTimetablesEvent event,
    Emitter<TimetableState> emit,
  ) async {
    await emit.forEach(
      watchAllTimetables(NoParams()),
      onData: (result) {
        return result.fold(
          (failure) => TimetableError(message: _mapFailureToMessage(failure)),
          (timetables) => TimetablesLoaded(timetables: timetables),
        );
      },
      onError: (error, stackTrace) {
        return TimetableError(message: error.toString());
      },
    );
  }

  Future<void> _onWatchTimetablesByUserId(
    WatchTimetablesByUserIdEvent event,
    Emitter<TimetableState> emit,
  ) async {
    await emit.forEach(
      watchTimetablesByUserId(
        WatchTimetablesByUserIdParams(userId: event.userId),
      ),
      onData: (result) {
        return result.fold(
          (failure) => TimetableError(message: _mapFailureToMessage(failure)),
          (timetables) => TimetablesLoaded(timetables: timetables),
        );
      },
      onError: (error, stackTrace) {
        return TimetableError(message: error.toString());
      },
    );
  }

  Future<void> _onWatchTimetablesByInstitutionId(
    WatchTimetablesByInstitutionIdEvent event,
    Emitter<TimetableState> emit,
  ) async {
    await emit.forEach(
      watchTimetablesByInstitutionId(
        WatchTimetablesByInstitutionIdParams(
          institutionId: event.institutionId,
        ),
      ),
      onData: (result) {
        return result.fold(
          (failure) => TimetableError(message: _mapFailureToMessage(failure)),
          (timetables) => TimetablesLoaded(timetables: timetables),
        );
      },
      onError: (error, stackTrace) {
        return TimetableError(message: error.toString());
      },
    );
  }

  Future<void> _onCreateOrUpdateTimetable(
    CreateOrUpdateTimetableEvent event,
    Emitter<TimetableState> emit,
  ) async {
    emit(const TimetableLoading());

    final result = await createOrUpdateTimetable(
      CreateOrUpdateTimetableParams(timetable: event.timetable),
    );

    result.fold(
      (failure) => emit(TimetableError(message: _mapFailureToMessage(failure))),
      (timetable) => emit(
        const TimetableOperationSuccess(
          message: 'Timetable saved successfully',
        ),
      ),
    );
  }

  Future<void> _onGetTimetableById(
    GetTimetableByIdEvent event,
    Emitter<TimetableState> emit,
  ) async {
    emit(const TimetableLoading());

    final result = await getTimetableById(GetTimetableByIdParams(id: event.id));

    result.fold(
      (failure) => emit(TimetableError(message: _mapFailureToMessage(failure))),
      (timetable) => emit(TimetableLoaded(timetable: timetable)),
    );
  }

  Future<void> _onDeleteTimetable(
    DeleteTimetableEvent event,
    Emitter<TimetableState> emit,
  ) async {
    emit(const TimetableLoading());

    final result = await deleteTimetable(DeleteTimetableParams(id: event.id));

    result.fold(
      (failure) => emit(TimetableError(message: _mapFailureToMessage(failure))),
      (_) => emit(
        const TimetableOperationSuccess(
          message: 'Timetable deleted successfully',
        ),
      ),
    );
  }

  Future<void> _onSyncTimetables(
    SyncTimetablesEvent event,
    Emitter<TimetableState> emit,
  ) async {
    emit(const TimetableSyncing());

    final result = await syncTimetables(NoParams());

    result.fold(
      (failure) => emit(TimetableError(message: _mapFailureToMessage(failure))),
      (_) => emit(const TimetableSyncSuccess()),
    );
  }

  Future<void> _onFetchTimetablesFromRemote(
    FetchTimetablesFromRemoteEvent event,
    Emitter<TimetableState> emit,
  ) async {
    emit(const TimetableLoading());

    final result = await fetchTimetablesFromRemote(NoParams());

    result.fold(
      (failure) => emit(TimetableError(message: _mapFailureToMessage(failure))),
      (timetables) => emit(TimetablesLoaded(timetables: timetables)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return failure.message;
    } else {
      return 'Unexpected error occurred';
    }
  }
}
