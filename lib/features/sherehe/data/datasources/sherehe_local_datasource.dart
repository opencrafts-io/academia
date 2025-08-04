import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

class ShereheLocalDataSource {
  final AppDataBase localDB;
  final Logger _logger = Logger();

  ShereheLocalDataSource({required this.localDB});

  // Cache or update a list of events
  Future<Either<Failure, List<EventData>>> cacheEvents(
    List<EventData> events,
  ) async {
    try {
      _logger.d("Attempting to cache ${events.length} events");
      _logger.d(
        "First event: ${events.isNotEmpty ? events.first : 'No events'}",
      );
      await localDB.batch((batch) {
        batch.insertAllOnConflictUpdate(localDB.eventTable, events);
      });
      
      final ids = events.map((e) => e.id).toList();

      final cachedEvents = await (localDB.select(
        localDB.eventTable,
      )..where((tbl) => tbl.id.isIn(ids))).get();

      return right(cachedEvents);
    } catch (e) {
      return left(
        CacheFailure(message: "Could not cache events locally.", error: e),
      );
    }
  }

  // Get all cached events
  Future<Either<Failure, List<EventData>>> getCachedEvents() async {
    try {
      final events = await localDB.select(localDB.eventTable).get();
      if (events.isEmpty) {
        return left(
          NoDataFoundFailure(
            message: "No events cached locally yet.",
            error: Exception("Empty event cache"),
          ),
        );
      }
      return right(events);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to fetch cached events.", error: e),
      );
    }
  }

  // Get single event by ID
  Future<Either<Failure, EventData>> getCachedEventById(String id) async {
    try {
      final event = await (localDB.select(
        localDB.eventTable,
      )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

      if (event == null) {
        return left(
          NoDataFoundFailure(
            message: "Event not found locally.",
            error: Exception("Event not cached"),
          ),
        );
      }
      return right(event);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to retrieve event locally.", error: e),
      );
    }
  }

  // Cache or update attendees for an event
  Future<Either<Failure, List<AttendeeData>>> cacheAttendees(
    List<AttendeeData> attendees,
  ) async {
    try {
      await localDB.batch((batch) {
        batch.insertAllOnConflictUpdate(localDB.attendeeTable, attendees);
      });
      return right(attendees);
    } catch (e) {
      return left(
        CacheFailure(message: "Could not cache attendees locally.", error: e),
      );
    }
  }

  // Get cached attendees for a specific event
  Future<Either<Failure, List<AttendeeData>>> getCachedAttendeesByEventId(
    String eventId,
  ) async {
    try {
      final attendees = await (localDB.select(
        localDB.attendeeTable,
      )..where((tbl) => tbl.eventId.equals(eventId))).get();

      if (attendees.isEmpty) {
        return left(
          NoDataFoundFailure(
            message: "No attendees cached for this event.",
            error: Exception("Empty attendee cache"),
          ),
        );
      }
      return right(attendees);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to fetch cached attendees.", error: e),
      );
    }
  }

  // Get single attendee by ID
  Future<Either<Failure, AttendeeData>> getCachedAttendeeById(String id) async {
    try {
      final attendee = await (localDB.select(
        localDB.attendeeTable,
      )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

      if (attendee == null) {
        return left(
          NoDataFoundFailure(
            message: "Attendee not found in cache.",
            error: Exception("Attendee not cached"),
          ),
        );
      }
      return right(attendee);
    } catch (e) {
      return left(
        CacheFailure(message: "Could not fetch attendee from cache.", error: e),
      );
    }
  }
}
