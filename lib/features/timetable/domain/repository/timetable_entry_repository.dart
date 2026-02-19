import 'package:academia/core/error/failures.dart';
import 'package:academia/features/timetable/domain/domain.dart';
import 'package:dartz/dartz.dart';

/// Domain layer repository contract for TimetableEntry operations.
///
/// This interface defines what the domain layer expects from the data layer,
/// without knowing how the data is stored or retrieved (could be local DB,
/// remote API, or both).
///
/// The implementation lives in the data layer and handles the offline-first
/// sync logic between local and remote data sources.
abstract class TimetableEntryRepository {
  /// Creates a new timetable entry or updates an existing one.
  ///
  /// In an offline-first architecture, this will:
  /// 1. Save to local database immediately (for instant UI update)
  /// 2. Mark for sync to remote server when connection is available
  ///
  /// Returns the created/updated [TimetableEntry] entity on success.
  Future<Either<Failure, TimetableEntryEntity>> createOrUpdateTimetableEntry({
    required TimetableEntryEntity entry,
  });

  /// Batch operation: Creates or updates multiple timetable entries at once.
  ///
  /// More efficient than calling createOrUpdateTimetableEntry multiple times.
  /// Useful for bulk imports or syncing multiple entries from the server.
  Future<Either<Failure, List<TimetableEntryEntity>>>
  createOrUpdateTimetableEntries({required List<TimetableEntryEntity> entries});

  /// Retrieves a specific timetable entry by its unique identifier.
  ///
  /// [id] is the local cache_id (UUID) of the entry.
  /// Returns the [TimetableEntryEntity] entity if found, or a [Failure] otherwise.
  Future<Either<Failure, TimetableEntryEntity>> getTimetableEntryById({
    required String id,
  });

  /// Provides a real-time stream of all timetable entries.
  ///
  /// The stream emits a new list whenever any entry is created,
  /// updated, or deleted (soft delete excluded automatically).
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchAllTimetableEntries();

  /// Watches entries filtered by timetable ID.
  ///
  /// Essential for displaying all classes/events in a specific timetable.
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchTimetableEntriesByTimetableId({required String timetableId});

  /// Watches entries filtered by course ID.
  ///
  /// Useful for viewing all scheduled sessions for a specific course.
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchTimetableEntriesByCourseId({required String courseId});

  /// Watches entries filtered by user ID.
  ///
  /// Shows all timetable entries belonging to a specific user.
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchTimetableEntriesByUserId({required String userId});

  /// Watches entries filtered by institution ID.
  ///
  /// Shows all timetable entries for a specific institution.
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchTimetableEntriesByInstitutionId({required int institutionId});

  /// Deletes a timetable entry by its ID.
  ///
  /// In an offline-first system:
  /// 1. Marks the entry as deleted locally (soft delete)
  /// 2. Queues the deletion for sync to remote server
  /// 3. Hard delete occurs only after server confirmation
  Future<Either<Failure, Unit>> deleteTimetableEntry({required String id});

  /// Deletes multiple timetable entries at once.
  ///
  /// More efficient than calling deleteTimetableEntry multiple times.
  /// Useful for clearing a timetable or bulk operations.
  Future<Either<Failure, Unit>> deleteTimetableEntries({
    required List<String> ids,
  });

  /// Synchronizes local timetable entries with the remote server.
  ///
  /// This operation:
  /// 1. Pushes locally-created/updated entries to the server
  /// 2. Pulls remote changes and updates local cache
  /// 3. Resolves conflicts based on timestamps or server authority
  ///
  /// Returns [Unit] on successful sync or [Failure] on network/server errors.
  Future<Either<Failure, Unit>> syncTimetableEntries();

  /// Fetches timetable entries from the remote server and caches them locally.
  ///
  /// Unlike sync, this is a one-way pull operation used for initial
  /// data loading or forced refresh.
  ///
  /// [timetableId] can optionally filter entries for a specific timetable.
  Future<Either<Failure, List<TimetableEntryEntity>>>
  fetchTimetableEntriesFromRemote({String? timetableId});

  /// Watches timetable entries that occur today.
  ///
  /// This method considers both one-time events and recurring events with RRULE.
  /// For recurring events, it checks if the RRULE contains today's weekday.
  /// Returns entries sorted chronologically by start time.
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchTodayTimetableEntries();
}
