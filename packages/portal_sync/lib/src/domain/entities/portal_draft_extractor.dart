import 'portal_analysis_plan.dart';
import 'portal_connection.dart';
import 'portal_draft.dart';
import 'portal_snapshot.dart';
import 'portal_source_identity.dart';

typedef PortalCapture = (PortalSnapshot snapshot, PortalAnalysisPlan plan);

class PortalDraftExtractor {
  const PortalDraftExtractor();

  PortalDraft? extract(
    PortalConnection connection,
    Iterable<PortalCapture> captures, {
    DateTime? observedAt,
  }) {
    final materialized = captures.toList(growable: false);
    final courses = <String, PortalCourseDraft>{};
    final pendingMeetings =
        <
          ({PortalSnapshot snapshot, PortalTablePlan table, List<String> row})
        >[];

    for (final (snapshot, plan) in materialized) {
      if (!plan.validateFor(snapshot)) continue;
      final nodes = {for (final node in snapshot.nodes) node.id: node};
      for (final table in plan.tables) {
        final node = nodes[table.nodeId]!;
        if (table.kind == PortalTableKind.courses) {
          for (final row in node.rows) {
            if (row.length != node.headers.length) continue;
            final code = _cell(row, table.columns.code)?.trim() ?? '';
            final title = _cell(row, table.columns.title)?.trim() ?? '';
            if (code.isEmpty || title.isEmpty) continue;
            final term = _cell(row, table.columns.term)?.trim();
            final sourceId = PortalSourceIdentity.hash([
              connection.accountId,
              connection.origin,
              connection.institutionId,
              code.toLowerCase(),
              term?.toLowerCase(),
            ]);
            courses[sourceId] = PortalCourseDraft(
              sourceId: sourceId,
              code: code,
              title: title,
              term: _nonEmpty(term),
            );
          }
        }
      }
    }

    for (final (snapshot, plan) in materialized) {
      if (!plan.validateFor(snapshot)) continue;
      final nodes = {for (final node in snapshot.nodes) node.id: node};
      for (final table in plan.tables.where(
        (table) => table.kind == PortalTableKind.meetings,
      )) {
        final node = nodes[table.nodeId]!;
        for (final row in node.rows) {
          if (row.length != node.headers.length) continue;
          final code = _cell(row, table.columns.code)?.trim() ?? '';
          final title = _cell(row, table.columns.title)?.trim();
          final term = _cell(row, table.columns.term)?.trim();
          final existingForCode = courses.values
              .where(
                (course) => course.code.toLowerCase() == code.toLowerCase(),
              )
              .toList(growable: false);
          if (code.isNotEmpty &&
              existingForCode.isEmpty &&
              title != null &&
              title.isNotEmpty) {
            final sourceId = PortalSourceIdentity.hash([
              connection.accountId,
              connection.origin,
              connection.institutionId,
              code.toLowerCase(),
              term?.toLowerCase(),
            ]);
            courses.putIfAbsent(
              sourceId,
              () => PortalCourseDraft(
                sourceId: sourceId,
                code: code,
                title: title,
                term: _nonEmpty(term),
              ),
            );
          }
          pendingMeetings.add((snapshot: snapshot, table: table, row: row));
        }
      }
    }

    final meetings = <String, PortalMeetingDraft>{};
    final occurrenceCounts = <String, int>{};
    for (final pending in pendingMeetings) {
      final row = pending.row;
      final columns = pending.table.columns;
      final code = _cell(row, columns.code)?.trim() ?? '';
      final term = _cell(row, columns.term)?.trim();
      final matchingCourses = courses.values
          .where(
            (course) =>
                course.code.toLowerCase() == code.toLowerCase() &&
                (term == null ||
                    course.term?.toLowerCase() == term.toLowerCase()),
          )
          .toList(growable: false);
      // An omitted timetable term may be linked only when the captured course
      // code identifies exactly one term. Never attach it to an arbitrary one.
      if (matchingCourses.length != 1) continue;
      final courseSourceId = matchingCourses.single.sourceId;
      final day = normalizePortalDay(_cell(row, columns.day) ?? '');
      final start = normalizePortalTime(_cell(row, columns.start) ?? '');
      final end = normalizePortalTime(_cell(row, columns.end) ?? '');
      if (day == null ||
          start == null ||
          end == null ||
          !validPortalTimeRange(start, end)) {
        continue;
      }
      final occurrenceKey = '$courseSourceId|$day|${pending.table.nodeId}';
      final occurrence = occurrenceCounts.update(
        occurrenceKey,
        (count) => count + 1,
        ifAbsent: () => 0,
      );
      final sourceId = PortalSourceIdentity.hash([
        courseSourceId,
        day,
        pending.table.nodeId,
        occurrence,
      ]);
      meetings[sourceId] = PortalMeetingDraft(
        sourceId: sourceId,
        courseSourceId: courseSourceId,
        day: day,
        startTime: start,
        endTime: end,
        venue: _nonEmpty(_cell(row, columns.venue)?.trim()),
      );
    }

    if (courses.isEmpty) return null;
    final draft = PortalDraft(
      courses: courses.values.toList(),
      meetings: meetings.values.toList(),
      sourceOrigin: connection.origin,
      observedAt: observedAt ?? DateTime.now().toUtc(),
    );
    return draft.isValid ? draft : null;
  }

  static String? _cell(List<String> row, int? index) =>
      index == null || index >= row.length ? null : row[index];
  static String? _nonEmpty(String? value) =>
      value == null || value.isEmpty ? null : value;
}
