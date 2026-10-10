import 'package:academia/core/integration/portal_sync/academia_portal_calendar_importer.dart';
import 'package:academia/core/integration/portal_sync/academia_portal_importer.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/portal_sync.dart';
import 'package:todos/todos.dart';

/// Covers the app-layer adapter that writes calendar-feed deadlines into the
/// shipped todos repository. The engine-side parsing/classification is tested
/// in `packages/portal_sync/test`; this file pins the import behaviors the
/// design doc requires of every portal importer: no duplicate on repeat
/// import, class meetings never written automatically, and writes stopping
/// when the signed-in account changes.
void main() {
  PortalCalendarEventDraft event(
    String sourceId, {
    required PortalCalendarEventShape shape,
    String summary = 'Essay due',
  }) => PortalCalendarEventDraft(
    sourceId: sourceId,
    uid: '$sourceId@example.edu',
    summary: summary,
    start: DateTime.utc(2026, 3, 2, 9),
    shape: shape,
  );

  PortalCalendarDraft draft({
    List<PortalCalendarEventDraft> deadlines = const [],
    List<PortalCalendarEventDraft> classMeetings = const [],
    List<PortalCalendarEventDraft> needsReview = const [],
  }) => PortalCalendarDraft(
    deadlines: deadlines,
    classMeetings: classMeetings,
    needsReview: needsReview,
    sourceFeedId: 'feed-hash-1',
  );

  AcademiaPortalCalendarImporter importer(
    _TodoItems items,
    _TodoLists lists,
    _MemoryLedger ledger, {
    bool Function()? isCurrentAccount,
  }) => AcademiaPortalCalendarImporter(
    createTodoItem: CreateTodoItem(items),
    getDefaultTodoList: GetDefaultTodoListUsecase(lists),
    ledger: ledger,
    accountId: 'account-a',
    isCurrentAccount: isCurrentAccount ?? () => true,
  );

  test('a deadline is written once as a task on the default list', () async {
    final items = _TodoItems();
    final sut = importer(items, _TodoLists(), _MemoryLedger());

    final result = await sut.importCalendarDraft(
      draft(deadlines: [event('d1', shape: PortalCalendarEventShape.deadline)]),
    );

    expect(result.importedDeadlines, 1);
    expect(items.created, hasLength(1));
    expect(items.created.single.title, 'Essay due');
    expect(items.created.single.due, DateTime.utc(2026, 3, 2, 9));
    expect(items.created.single.taskListLocalId, 7);
  });

  test('re-importing the same feed creates no duplicate task', () async {
    final items = _TodoItems();
    final ledger = _MemoryLedger();
    final feed = draft(
      deadlines: [event('d1', shape: PortalCalendarEventShape.deadline)],
    );

    final first = await importer(
      items,
      _TodoLists(),
      ledger,
    ).importCalendarDraft(feed);
    final second = await importer(
      items,
      _TodoLists(),
      ledger,
    ).importCalendarDraft(feed);

    expect(first.importedDeadlines, 1);
    expect(
      second.importedDeadlines,
      0,
      reason: 'the ledger link must suppress a second write',
    );
    expect(items.created, hasLength(1));
  });

  test(
    'class meetings and ambiguous events are held for review, never written',
    () async {
      final items = _TodoItems();
      final sut = importer(items, _TodoLists(), _MemoryLedger());

      final result = await sut.importCalendarDraft(
        draft(
          classMeetings: [
            event(
              'c1',
              shape: PortalCalendarEventShape.classMeeting,
              summary: 'CS101 Lecture',
            ),
          ],
          needsReview: [
            event('a1', shape: PortalCalendarEventShape.ambiguous),
          ],
        ),
      );

      expect(result.importedDeadlines, 0);
      expect(result.heldForReview, 2);
      expect(
        items.created,
        isEmpty,
        reason:
            'a class meeting has no reliable course identity in a feed, so it '
            'must never be auto-written',
      );
    },
  );

  test('a feed with no deadlines reports plainly and writes nothing', () async {
    final items = _TodoItems();
    final sut = importer(items, _TodoLists(), _MemoryLedger());

    final result = await sut.importCalendarDraft(draft());

    expect(result.importedDeadlines, 0);
    expect(result.heldForReview, 0);
    expect(result.message, 'No deadlines were found in this feed.');
    expect(items.created, isEmpty);
  });

  test('an account change stops writes mid-import', () async {
    final items = _TodoItems();
    var current = true;
    final sut = importer(
      items,
      _TodoLists(),
      _MemoryLedger(),
      isCurrentAccount: () => current,
    );

    items.onCreate = () {
      // The account switches right after the first task is written.
      current = false;
    };

    final result = await sut.importCalendarDraft(
      draft(
        deadlines: [
          event('d1', shape: PortalCalendarEventShape.deadline),
          event('d2', shape: PortalCalendarEventShape.deadline),
          event('d3', shape: PortalCalendarEventShape.deadline),
        ],
      ),
    );

    expect(items.created, hasLength(1));
    expect(result.importedDeadlines, 1);
  });

  test(
    'an already-signed-out account is refused before any write',
    () async {
      final items = _TodoItems();
      final sut = importer(
        items,
        _TodoLists(),
        _MemoryLedger(),
        isCurrentAccount: () => false,
      );

      await expectLater(
        sut.importCalendarDraft(
          draft(
            deadlines: [event('d1', shape: PortalCalendarEventShape.deadline)],
          ),
        ),
        throwsA(isA<StateError>()),
      );
      expect(items.created, isEmpty);
    },
  );

  test('a missing task list holds everything instead of dropping it', () async {
    final items = _TodoItems();
    final sut = importer(items, _TodoLists(hasDefault: false), _MemoryLedger());

    final result = await sut.importCalendarDraft(
      draft(deadlines: [event('d1', shape: PortalCalendarEventShape.deadline)]),
    );

    expect(result.importedDeadlines, 0);
    expect(result.heldForReview, 1);
    expect(result.message, 'Could not find a task list to save deadlines into.');
    expect(items.created, isEmpty);
  });

  test(
    'a deadline the student deleted is not resurrected on re-import',
    () async {
      final items = _TodoItems();
      final ledger = _MemoryLedger();
      final feed = draft(
        deadlines: [event('d1', shape: PortalCalendarEventShape.deadline)],
      );

      await importer(items, _TodoLists(), ledger).importCalendarDraft(feed);
      expect(items.created, hasLength(1));

      // The student deletes the imported task, then the feed is imported
      // again. Per the import-ledger rule in docs/portal-sync-internal.md
      // ("user-deleted records are kept"), the deletion must stick.
      items.created.clear();

      final second = await importer(
        items,
        _TodoLists(),
        ledger,
      ).importCalendarDraft(feed);

      expect(second.importedDeadlines, 0);
      expect(items.created, isEmpty);
    },
  );

  test(
    'a linked task outside the fetched page is not duplicated',
    () async {
      final items = _TodoItems();
      final ledger = _MemoryLedger();
      final feed = draft(
        deadlines: [event('d1', shape: PortalCalendarEventShape.deadline)],
      );

      await importer(items, _TodoLists(), ledger).importCalendarDraft(feed);

      // The task still exists but has fallen off the single page the importer
      // reads, which must not be mistaken for "it is gone, write it again".
      items.hidePageContents = true;

      final second = await importer(
        items,
        _TodoLists(),
        ledger,
      ).importCalendarDraft(feed);

      expect(second.importedDeadlines, 0);
      expect(items.created, hasLength(1));
    },
  );

  test('an untitled feed event still saves with a readable title', () async {
    final items = _TodoItems();
    final sut = importer(items, _TodoLists(), _MemoryLedger());

    await sut.importCalendarDraft(
      draft(
        deadlines: [
          event('d1', shape: PortalCalendarEventShape.deadline, summary: '   '),
        ],
      ),
    );

    expect(items.created.single.title, 'Imported deadline');
  });
}

class _MemoryLedger implements PortalImportLedger {
  final Map<String, PortalImportLink> entries = {};

  @override
  Future<PortalImportLink?> get(String key) async => entries[key];

  @override
  Future<void> put(String key, PortalImportLink value) async {
    entries[key] = value;
  }
}

class _TodoItems implements TodoItemRepository {
  final List<TodoItemEntity> created = [];
  void Function()? onCreate;

  /// Simulates an existing task that is real but falls outside the single
  /// page the importer reads back.
  bool hidePageContents = false;
  var _nextId = 100;

  @override
  Future<Either<Failure, TodoItemEntity>> createTodoItem(
    TodoItemEntity entity,
  ) async {
    final saved = entity.copyWith(localId: _nextId++);
    created.add(saved);
    onCreate?.call();
    return Right(saved);
  }

  @override
  Future<Either<Failure, TodoItemPage>> getTodoItems({
    String? url,
    String? taskListId,
    int? taskListLocalId,
  }) async =>
      Right(TodoItemPage(items: hidePageContents ? const [] : List.of(created)));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _TodoLists implements TodoListRepository {
  _TodoLists({this.hasDefault = true});
  final bool hasDefault;

  @override
  Future<Either<Failure, TodoListEntity>> getDefaultTodoList() async =>
      hasDefault
      ? const Right(
          TodoListEntity(
            localId: 7,
            title: 'Tasks',
            isDefault: true,
            syncStatus: SyncStatus.synced,
            taskCount: 0,
            isPendingDeletion: false,
          ),
        )
      : Left(CacheFailure(message: 'no default list'));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
