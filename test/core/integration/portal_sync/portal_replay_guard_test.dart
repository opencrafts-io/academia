import 'dart:async';

import 'package:academia/core/integration/portal_sync/portal_replay_guard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'suspends replay before browsing and restores only if it was active',
    () async {
      var active = true;
      var stops = 0;
      var resumes = 0;
      final guard = PortalReplayGuard(
        isActive: () async => active,
        stop: () async {
          active = false;
          stops++;
        },
        resume: () async {
          active = true;
          resumes++;
        },
      );
      await guard.enter();
      await guard.enter();
      expect(active, isFalse);
      expect(stops, 1);
      await guard.exit();
      await guard.exit();
      expect(resumes, 1);
    },
  );

  test('closing during initialization waits before restoring replay', () async {
    final pending = Completer<bool>();
    var calls = 0;
    var resumed = false;
    final guard = PortalReplayGuard(
      isActive: () => calls++ == 0 ? pending.future : Future.value(false),
      stop: () async {},
      resume: () async {
        resumed = true;
      },
    );
    final entering = guard.enter();
    final exiting = guard.exit();
    pending.complete(true);
    await entering;
    await exiting;
    expect(resumed, isTrue);
  });

  test('inactive replay remains inactive', () async {
    var resumes = 0;
    final guard = PortalReplayGuard(
      isActive: () async => false,
      stop: () async {},
      resume: () async {
        resumes++;
      },
    );
    await guard.enter();
    await guard.exit();
    expect(resumes, 0);
  });

  test('refuses private browsing when replay cannot be stopped', () async {
    final guard = PortalReplayGuard(
      isActive: () async => true,
      stop: () async {},
      resume: () async {},
    );
    await expectLater(guard.enter(), throwsStateError);
    await guard.exit();
  });
}
