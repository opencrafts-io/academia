import 'package:academia/features/agenda/data/models/agenda_event.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:academia/features/chirp/common/data/models/chirp_user.dart';
import 'package:academia/features/chirp/communities/data/models/community_model.dart';
import 'package:academia/features/chirp/memberships/data/models/chirp_community_membership.dart';
import 'package:academia/features/chirp/posts/data/models/attachment_model.dart';
import 'package:academia/features/chirp/posts/data/models/post_model.dart';
import 'package:academia/features/chirp/posts/data/models/comment_model.dart';
import 'package:academia/features/exam_timetable/data/models/exam_timetable.dart';
import 'package:academia/features/institution/data/models/institution.dart';
import 'package:academia/features/institution/data/models/institution_scrapping_command.dart';
import 'package:academia/features/institution/data/models/institution_key.dart';
import 'package:academia/features/leaderboard/data/models/leaderboard_rank.dart';
import 'package:academia/features/chirp/posts/data/models/groups/group_model.dart';
import 'package:academia/features/profile/data/models/user_profile.dart';
import 'package:academia/features/streaks/data/streak_activity.dart';
import 'package:academia/features/streaks/data/streak_milestone.dart';
import 'package:academia/features/sherehe/data/models/sherehe_user_model.dart';
import 'package:academia/features/todos/data/models/todo.dart';
import 'package:academia/features/sherehe/data/data.dart';
import 'package:academia/features/notifications/data/models/notification_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:academia/core/core.dart';
import 'migrations.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    // Profile
    UserProfile,

    // Auth
    Token,

    // Posts
    AttachmentTable,
    PostTable,
    CommentTable,

    Todo,
    EventTable,
    AttendeeTable,
    TicketTable,
    PaymentInfoTable,
    ShereheUserTable, //temporary
    GroupTable,

    // Agenda
    AgendaEvent,

    // Notifications
    NotificationTable,

    // Institution
    Institution,
    InstitutionScrappingCommand,
    InstitutionKey,
    // Exam Timetable
    ExamTimetable,

    /**************************************************************
    *              CHIRP FEATURE DATA MODELS
    **************************************************************/
    // Users
    ChirpUser,
    //Communities
    Community,
    // Memberships
    ChirpCommunityMembership,

    /**************************************************************
    *               LEADERBOARD FEATURE DATA MODELS
    ***************************************************************/
    LeaderboardRank,

    // ---------------------- STREAKS -----------------------------
    StreakActivity,
    StreakMilestone,
  ],
)
class AppDataBase extends _$AppDataBase {
  final Logger _logger = Logger();
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDataBase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 17;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        _logger.i("Migrating from version $from to version $to");
        for (int version = from; version < to; version++) {
          switch (version) {
            case 14:
              await migrate14To15(m);
              break;
            case 15:
              await migrate15To16(m);
              break;
            case 16:
              await migrate16To17(m);
              break;
          }
        }
      },
      beforeOpen: (details) async {
        _logger.i(
          "Opening cache db version ${details.versionNow} initial version ${details.versionBefore}",
        );
      },
    );
  }

  static QueryExecutor _openConnection() {
    driftRuntimeOptions.defaultSerializer = const ValueSerializer.defaults(
      serializeDateTimeValuesAsString: true,
    );
    return driftDatabase(
      name: 'academia.db',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            Logger().d(
              'Using ${result.chosenImplementation} due to unsupported '
              'browser features: ${result.missingFeatures}',
            );
          }
        },
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
