// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:academia/database/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v16.dart' as v16;
import 'generated/schema_v17.dart' as v17;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDataBase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  // TODO: This generated template shows how these tests could be written. Adopt
  // it to your own needs when testing migrations with data integrity.
  test('migration from v16 to v17 does not corrupt data', () async {
    // Add data to insert into the old database, and the expected rows after the
    // migration.
    // TODO: Fill these lists
    final oldUserProfileData = <v16.UserProfileData>[];
    final expectedNewUserProfileData = <v17.UserProfileData>[];

    final oldTokenData = <v16.TokenData>[];
    final expectedNewTokenData = <v17.TokenData>[];

    final oldAttachmentTableData = <v16.AttachmentTableData>[];
    final expectedNewAttachmentTableData = <v17.AttachmentTableData>[];

    final oldPostTableData = <v16.PostTableData>[];
    final expectedNewPostTableData = <v17.PostTableData>[];

    final oldCommentTableData = <v16.CommentTableData>[];
    final expectedNewCommentTableData = <v17.CommentTableData>[];

    final oldTodoData = <v16.TodoData>[];
    final expectedNewTodoData = <v17.TodoData>[];

    final oldEventTableData = <v16.EventTableData>[];
    final expectedNewEventTableData = <v17.EventTableData>[];

    final oldAttendeeTableData = <v16.AttendeeTableData>[];
    final expectedNewAttendeeTableData = <v17.AttendeeTableData>[];

    final oldTicketTableData = <v16.TicketTableData>[];
    final expectedNewTicketTableData = <v17.TicketTableData>[];

    final oldPaymentInfoTableData = <v16.PaymentInfoTableData>[];
    final expectedNewPaymentInfoTableData = <v17.PaymentInfoTableData>[];

    final oldShereheUserTableData = <v16.ShereheUserTableData>[];
    final expectedNewShereheUserTableData = <v17.ShereheUserTableData>[];

    final oldGroupTableData = <v16.GroupTableData>[];
    final expectedNewGroupTableData = <v17.GroupTableData>[];

    final oldAgendaEventData = <v16.AgendaEventData>[];
    final expectedNewAgendaEventData = <v17.AgendaEventData>[];

    final oldNotificationTableData = <v16.NotificationTableData>[];
    final expectedNewNotificationTableData = <v17.NotificationTableData>[];

    final oldInstitutionData = <v16.InstitutionData>[];
    final expectedNewInstitutionData = <v17.InstitutionData>[];

    final oldInstitutionScrappingCommandData =
        <v16.InstitutionScrappingCommandData>[];
    final expectedNewInstitutionScrappingCommandData =
        <v17.InstitutionScrappingCommandData>[];

    final oldInstitutionKeyData = <v16.InstitutionKeyData>[];
    final expectedNewInstitutionKeyData = <v17.InstitutionKeyData>[];

    final oldExamTimetableData = <v16.ExamTimetableData>[];
    final expectedNewExamTimetableData = <v17.ExamTimetableData>[];

    final oldChirpUserData = <v16.ChirpUserData>[];
    final expectedNewChirpUserData = <v17.ChirpUserData>[];

    final oldCommunityData = <v16.CommunityData>[];
    final expectedNewCommunityData = <v17.CommunityData>[];

    final oldChirpCommunityMembershipData =
        <v16.ChirpCommunityMembershipData>[];
    final expectedNewChirpCommunityMembershipData =
        <v17.ChirpCommunityMembershipData>[];

    final oldLeaderboardRankData = <v16.LeaderboardRankData>[];
    final expectedNewLeaderboardRankData = <v17.LeaderboardRankData>[];

    final oldStreakActivityData = <v16.StreakActivityData>[];
    final expectedNewStreakActivityData = <v17.StreakActivityData>[];

    final oldStreakMilestoneData = <v16.StreakMilestoneData>[];
    final expectedNewStreakMilestoneData = <v17.StreakMilestoneData>[];

    await verifier.testWithDataIntegrity(
      oldVersion: 16,
      newVersion: 17,
      createOld: v16.DatabaseAtV16.new,
      createNew: v17.DatabaseAtV17.new,
      openTestedDatabase: AppDataBase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.userProfile, oldUserProfileData);
        batch.insertAll(oldDb.token, oldTokenData);
        batch.insertAll(oldDb.attachmentTable, oldAttachmentTableData);
        batch.insertAll(oldDb.postTable, oldPostTableData);
        batch.insertAll(oldDb.commentTable, oldCommentTableData);
        batch.insertAll(oldDb.todo, oldTodoData);
        batch.insertAll(oldDb.eventTable, oldEventTableData);
        batch.insertAll(oldDb.attendeeTable, oldAttendeeTableData);
        batch.insertAll(oldDb.ticketTable, oldTicketTableData);
        batch.insertAll(oldDb.paymentInfoTable, oldPaymentInfoTableData);
        batch.insertAll(oldDb.shereheUserTable, oldShereheUserTableData);
        batch.insertAll(oldDb.groupTable, oldGroupTableData);
        batch.insertAll(oldDb.agendaEvent, oldAgendaEventData);
        batch.insertAll(oldDb.notificationTable, oldNotificationTableData);
        batch.insertAll(oldDb.institution, oldInstitutionData);
        batch.insertAll(
          oldDb.institutionScrappingCommand,
          oldInstitutionScrappingCommandData,
        );
        batch.insertAll(oldDb.institutionKey, oldInstitutionKeyData);
        batch.insertAll(oldDb.examTimetable, oldExamTimetableData);
        batch.insertAll(oldDb.chirpUser, oldChirpUserData);
        batch.insertAll(oldDb.community, oldCommunityData);
        batch.insertAll(
          oldDb.chirpCommunityMembership,
          oldChirpCommunityMembershipData,
        );
        batch.insertAll(oldDb.leaderboardRank, oldLeaderboardRankData);
        batch.insertAll(oldDb.streakActivity, oldStreakActivityData);
        batch.insertAll(oldDb.streakMilestone, oldStreakMilestoneData);
      },
      validateItems: (newDb) async {
        expect(
          expectedNewUserProfileData,
          await newDb.select(newDb.userProfile).get(),
        );
        expect(expectedNewTokenData, await newDb.select(newDb.token).get());
        expect(
          expectedNewAttachmentTableData,
          await newDb.select(newDb.attachmentTable).get(),
        );
        expect(
          expectedNewPostTableData,
          await newDb.select(newDb.postTable).get(),
        );
        expect(
          expectedNewCommentTableData,
          await newDb.select(newDb.commentTable).get(),
        );
        expect(expectedNewTodoData, await newDb.select(newDb.todo).get());
        expect(
          expectedNewEventTableData,
          await newDb.select(newDb.eventTable).get(),
        );
        expect(
          expectedNewAttendeeTableData,
          await newDb.select(newDb.attendeeTable).get(),
        );
        expect(
          expectedNewTicketTableData,
          await newDb.select(newDb.ticketTable).get(),
        );
        expect(
          expectedNewPaymentInfoTableData,
          await newDb.select(newDb.paymentInfoTable).get(),
        );
        expect(
          expectedNewShereheUserTableData,
          await newDb.select(newDb.shereheUserTable).get(),
        );
        expect(
          expectedNewGroupTableData,
          await newDb.select(newDb.groupTable).get(),
        );
        expect(
          expectedNewAgendaEventData,
          await newDb.select(newDb.agendaEvent).get(),
        );
        expect(
          expectedNewNotificationTableData,
          await newDb.select(newDb.notificationTable).get(),
        );
        expect(
          expectedNewInstitutionData,
          await newDb.select(newDb.institution).get(),
        );
        expect(
          expectedNewInstitutionScrappingCommandData,
          await newDb.select(newDb.institutionScrappingCommand).get(),
        );
        expect(
          expectedNewInstitutionKeyData,
          await newDb.select(newDb.institutionKey).get(),
        );
        expect(
          expectedNewExamTimetableData,
          await newDb.select(newDb.examTimetable).get(),
        );
        expect(
          expectedNewChirpUserData,
          await newDb.select(newDb.chirpUser).get(),
        );
        expect(
          expectedNewCommunityData,
          await newDb.select(newDb.community).get(),
        );
        expect(
          expectedNewChirpCommunityMembershipData,
          await newDb.select(newDb.chirpCommunityMembership).get(),
        );
        expect(
          expectedNewLeaderboardRankData,
          await newDb.select(newDb.leaderboardRank).get(),
        );
        expect(
          expectedNewStreakActivityData,
          await newDb.select(newDb.streakActivity).get(),
        );
        expect(
          expectedNewStreakMilestoneData,
          await newDb.select(newDb.streakMilestone).get(),
        );
      },
    );
  });
}
