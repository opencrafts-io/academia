import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class AgendaEventLocalDataSource {
  final AppDataBase localDB;
  AgendaEventLocalDataSource({required this.localDB});

  Stream<List<AgendaEventData>> getAgendaEventStream() {
    return (localDB.select(localDB.agendaEvent)..orderBy([
          (agenda) => OrderingTerm(
            expression: agenda.startTime,
            mode: OrderingMode.asc,
          ),
        ]))
        .watch();
  }

  Future<Either<Failure, AgendaEventData>> createOrUpdateAgendaEvent(
    AgendaEventData agendaEvent,
  ) async {
    try {
      final created = await localDB
          .into(localDB.agendaEvent)
          .insertReturning(
            agendaEvent,
            onConflict: DoUpdate((a) => agendaEvent),
          );
      return right(created);
    } catch (e) {
      // rethrow;
      return left(
        CacheFailure(
          error: e,
          message:
              // "Stairway to Heaven" - Led Zeppelin
              "Looks like we hit a stairway to nowhere! We couldn't save your agenda event locally. The database is having a mystical moment!",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteAgendaEvent(
    AgendaEventData agenda,
  ) async {
    try {
      await (localDB.delete(
        localDB.agendaEvent,
      )..where((t) => t.id.equals(agenda.id))).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Hotel California" - Eagles
              "You can check out any time you like, but that event just won't leave! There's a glitch in our local database matrix.",
        ),
      );
    }
  }
}
