import 'package:academia/core/error/failures.dart';
import 'package:academia/features/timetable/domain/domain.dart';
import 'package:dartz/dartz.dart';

/// Domain layer repository contract for Timetable operations.
///
/// This interface defines what the domain layer expects from the data layer,
/// without knowing how the data is stored or retrieved (could be local DB,
/// remote API, or both).
///
/// The implementation lives in the data layer and handles the offline-first
/// sync logic between local and remote data sources.
abstract class TimetableRepository {
  /// Creates a new timetable or updates an existing one.
  ///
  /// In an offline-first architecture, this will:
  /// 1. Save to local database immediately (for instant UI update)
  /// 2. Mark for sync to remote server when connection is available
  ///
  /// Returns the created/updated [TimetableEntity] entity on success.
  Future<Either<Failure, TimetableEntity>> createOrUpdateTimetable({
    required TimetableEntity timetable,
  });

  /// Retrieves a specific timetable by its unique identifier.
  ///
  /// [id] is the local cache_id (UUID) of the timetable.
  /// Returns the [TimetableEntity] entity if found, or a [Failure] otherwise.
  Future<Either<Failure, TimetableEntity>> getTimetableById({
    required String id,
  });

  /// Provides a real-time stream of all timetables.
  ///
  /// The stream emits a new list whenever any timetable is created,
  /// updated, or deleted (soft delete excluded automatically).
  Stream<Either<Failure, List<TimetableEntity>>> watchAllTimetables();

  /// Watches timetables filtered by user ID.
  ///
  /// Useful for displaying a user's personal timetables.
  Stream<Either<Failure, List<TimetableEntity>>> watchTimetablesByUserId({
    required String userId,
  });

  /// Watches timetables filtered by institution ID.
  ///
  /// Useful for displaying institution-specific timetables.
  Stream<Either<Failure, List<TimetableEntity>>>
  watchTimetablesByInstitutionId({required int institutionId});

  /// Deletes a timetable by its ID.
  ///
  /// In an offline-first system:
  /// 1. Marks the timetable as deleted locally (soft delete)
  /// 2. Queues the deletion for sync to remote server
  /// 3. Hard delete occurs only after server confirmation
  Future<Either<Failure, Unit>> deleteTimetable({required String id});

  /// Synchronizes local timetables with the remote server.
  ///
  /// This operation:
  /// 1. Pushes locally-created/updated timetables to the server
  /// 2. Pulls remote changes and updates local cache
  /// 3. Resolves conflicts based on timestamps or server authority
  ///
  /// Returns [Unit] on successful sync or [Failure] on network/server errors.
  Future<Either<Failure, Unit>> syncTimetables();

  /// Fetches timetables from the remote server and caches them locally.
  ///
  /// Unlike sync, this is a one-way pull operation used for initial
  /// data loading or forced refresh.
  Future<Either<Failure, List<TimetableEntity>>> fetchTimetablesFromRemote();
}
