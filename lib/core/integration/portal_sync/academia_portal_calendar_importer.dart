import 'package:crypto/crypto.dart';

import 'dart:convert';

import 'package:portal_sync/portal_sync.dart';
import 'package:todos/todos.dart';

import 'academia_portal_importer.dart';

/// Adapts a classified calendar feed draft to the existing agenda/task
/// boundary. Deadline-shaped events become tasks through the shipped todos
/// repository. Class-meeting-shaped and ambiguous events are never
/// auto-imported here: there is no reliable course identity in an arbitrary
/// calendar feed to attach a meeting to, and writing them as a generic
/// calendar entry would blur the line the design doc asks Academia to keep
/// between class meetings and non-class events. They are returned as
/// `heldForReview` so the UI can ask the student to confirm them manually.
class AcademiaPortalCalendarImporter implements PortalCalendarImporter {
  AcademiaPortalCalendarImporter({
    required this.createTodoItem,
    required this.getDefaultTodoList,
    required this.ledger,
    required this.accountId,
    required this.isCurrentAccount,
  });

  final CreateTodoItem createTodoItem;
  final GetDefaultTodoListUsecase getDefaultTodoList;
  final PortalImportLedger ledger;
  final String accountId;
  final bool Function() isCurrentAccount;

  String _key(String sourceFeedId, String sourceId) =>
      'portal_calendar_import_v1_${_hash([accountId, sourceFeedId, sourceId])}';

  static String _hash(List<Object?> fields) =>
      sha256.convert(utf8.encode(jsonEncode(fields))).toString();

  @override
  Future<PortalCalendarImportResult> importCalendarDraft(
    PortalCalendarDraft draft,
  ) async {
    if (!isCurrentAccount()) {
      throw StateError('The signed-in account changed.');
    }
    final heldForReview = draft.classMeetings.length + draft.needsReview.length;
    if (draft.deadlines.isEmpty) {
      return PortalCalendarImportResult(
        importedDeadlines: 0,
        heldForReview: heldForReview,
        message: heldForReview == 0
            ? 'No deadlines were found in this feed.'
            : null,
      );
    }
    final listResult = await getDefaultTodoList(const NoParams());
    final list = listResult.fold((_) => null, (value) => value);
    if (list == null) {
      return PortalCalendarImportResult(
        importedDeadlines: 0,
        heldForReview: draft.totalEvents,
        message: 'Could not find a task list to save deadlines into.',
      );
    }
    var imported = 0;
    final now = DateTime.now().toUtc();
    for (final deadline in draft.deadlines) {
      if (!isCurrentAccount()) break;
      final key = _key(draft.sourceFeedId, deadline.sourceId);
      // A ledger link means this feed event was already imported for this
      // account, so it is never written again — not even when the task is no
      // longer found. The student may have deleted it deliberately, and
      // docs/portal-sync-internal.md requires user-deleted records to stay
      // deleted. Skipping on the link alone also removes the duplicate window
      // that reading back a single page of existing tasks left open.
      if (await ledger.get(key) != null) continue;
      final created = await createTodoItem(
        TodoItemEntity(
          localId: 0,
          taskListLocalId: list.localId,
          title: deadline.summary.trim().isEmpty
              ? 'Imported deadline'
              : deadline.summary.trim(),
          notes: deadline.description,
          status: TodoStatus.needsAction,
          priority: TodoPriority.none,
          due: deadline.start,
          subtaskCount: 0,
          hidden: false,
          syncStatus: SyncStatus.pending,
          createdAt: now,
          updatedAt: now,
          isPendingDeletion: false,
          isDirty: true,
        ),
      );
      final savedId = created.fold((_) => null, (value) => value.localId);
      if (savedId != null) {
        imported++;
        await ledger.put(key, PortalImportLink('$savedId', deadline.sourceId));
      }
    }
    return PortalCalendarImportResult(
      importedDeadlines: imported,
      heldForReview: heldForReview,
      message: heldForReview > 0
          ? 'Saved $imported deadlines. $heldForReview events need your review.'
          : 'Saved $imported deadlines.',
    );
  }
}
