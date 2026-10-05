import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magnet/magnet.dart';

void main() {
  test(
    'clears a table capture notice when the next capture is complete',
    () async {
      final browser = _Browser();
      final notices = <String?>[];
      final observer = PortalBrowserObserver(
        controller: browser,
        allowedOrigins: {'https://portal.example.edu'},
        onSnapshot: (_) {},
        onHint: notices.add,
      );
      addTearDown(observer.dispose);
      await observer.start();
      browser.truncated = true;
      await observer.capture();
      await observer.capture();
      expect(
        notices,
        hasLength(1),
        reason: 'Repeated limits should not spam hints.',
      );
      browser.truncated = false;
      await observer.capture();
      expect(notices, [isA<String>(), null]);
      browser.truncated = true;
      await observer.capture();
      expect(notices, [isA<String>(), null, isA<String>()]);
    },
  );

  test(
    'privacy exclusions do not claim that table rows exceeded a limit',
    () async {
      final browser = _Browser();
      browser.nodes = [
        {
          'id': 'n0',
          'kind': 'table',
          'label': 'Roster',
          'headers': ['Student Name'],
          'rows': [
            ['Private student'],
          ],
        },
      ];
      final notices = <String?>[];
      final observer = PortalBrowserObserver(
        controller: browser,
        allowedOrigins: {'https://portal.example.edu'},
        onSnapshot: (_) {},
        onHint: notices.add,
      );
      addTearDown(observer.dispose);
      await observer.start();
      final snapshot = await observer.capture();
      expect(snapshot!['nodes'], isEmpty);
      expect(notices, isEmpty);
    },
  );

  test(
    'local payload trimming still reports a partial table capture',
    () async {
      final browser = _Browser();
      browser.nodes = [
        {
          'id': 'n0',
          'kind': 'table',
          'label': 'Courses',
          'headers': List.generate(16, (i) => 'Column $i'),
          'rows': List.generate(
            30,
            (i) => List.generate(16, (j) => 'Row $i ${'x' * 170}'),
          ),
        },
      ];
      final notices = <String?>[];
      final observer = PortalBrowserObserver(
        controller: browser,
        allowedOrigins: {'https://portal.example.edu'},
        onSnapshot: (_) {},
        onHint: notices.add,
      );
      addTearDown(observer.dispose);
      await observer.start();
      final snapshot = await observer.capture();
      expect(
        (snapshot!['nodes'] as List).single['rows'],
        hasLength(lessThan(30)),
      );
      expect(notices, [isA<String>()]);
    },
  );
}

class _Browser implements InAppWebViewController {
  bool truncated = false;
  List<Map<String, Object?>> nodes = [];

  @override
  Future<WebUri?> getUrl() async =>
      WebUri('https://portal.example.edu/courses');

  @override
  Future<dynamic> evaluateJavascript({
    required String source,
    ContentWorld? contentWorld,
  }) async {
    if (!source.contains('const snapshot = window.__magnetPortalCapture();')) {
      return true;
    }
    return {
      'snapshot': {
        'origin': 'https://portal.example.edu',
        'path': '/courses',
        'title': 'Courses',
        'language': 'en',
        'nodes': nodes,
      },
      'truncated': truncated,
    };
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
