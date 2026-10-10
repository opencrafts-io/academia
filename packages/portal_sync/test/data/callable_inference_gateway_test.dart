import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/portal_sync.dart';

void main() {
  PortalInferenceRequest request({Map<String, Object?>? structuralContent}) =>
      PortalInferenceRequest(
        accountId: 'account-a',
        budgetKey: 'account-a|1|https://portal.example.edu|fp|model|v2',
        structuralContent: structuralContent ?? const {'nodes': <Object?>[]},
        modelVersion: 'gemini-3.8-flash',
      );

  test('sends the documented request shape to the callable', () async {
    Map<String, Object?>? sentPayload;
    String? sentName;
    Duration? sentTimeout;
    final gateway = CallableInferenceGateway(
      invoke: (name, payload, timeout) async {
        sentName = name;
        sentPayload = payload;
        sentTimeout = timeout;
        return {
          'status': 'ok',
          'plan': {'pageType': 'other', 'tables': <Object?>[]},
        };
      },
    );
    await gateway.analyze(
      request(structuralContent: {'nodes': <Object?>[], 'marker': 'x'}),
    );
    expect(sentName, CallableInferenceGateway.defaultCallableName);
    expect(sentTimeout, const Duration(seconds: 30));
    expect(sentPayload, {
      'accountId': 'account-a',
      'budgetKey': 'account-a|1|https://portal.example.edu|fp|model|v2',
      'modelVersion': 'gemini-3.8-flash',
      'structuralContent': {'nodes': <Object?>[], 'marker': 'x'},
    });
  });

  test('parses a successful response into PortalInferenceSuccess', () async {
    final gateway = CallableInferenceGateway(
      invoke: (name, payload, timeout) async => {
        'status': 'ok',
        'plan': {
          'pageType': 'courses',
          'tables': [
            {
              'nodeId': 'n0',
              'kind': 'courses',
              'columns': {'code': 0, 'title': 1},
            },
          ],
        },
      },
    );
    final outcome = await gateway.analyze(request());
    expect(outcome, isA<PortalInferenceSuccess>());
    final plan = (outcome as PortalInferenceSuccess).plan;
    expect(plan.pageType, PortalPageType.courses);
    expect(plan.tables.single.nodeId, 'n0');
  });

  test('parses a no-entitlement rejection into a typed rejection, not an exception', () async {
    final gateway = CallableInferenceGateway(
      invoke: (name, payload, timeout) async => {
        'status': 'rejected',
        'reason': 'no_entitlement',
        'message': 'Upgrade to use AI portal sync.',
      },
    );
    final outcome = await gateway.analyze(request());
    expect(outcome, isA<PortalInferenceRejected>());
    final rejected = outcome as PortalInferenceRejected;
    expect(rejected.reason, PortalInferenceRejectionReason.noEntitlement);
    expect(rejected.message, 'Upgrade to use AI portal sync.');
  });

  test(
    'parses an allowance-exhausted rejection distinctly from no entitlement',
    () async {
      final gateway = CallableInferenceGateway(
        invoke: (name, payload, timeout) async => {
          'status': 'rejected',
          'reason': 'allowance_exhausted',
        },
      );
      final outcome = await gateway.analyze(request());
      expect(
        (outcome as PortalInferenceRejected).reason,
        PortalInferenceRejectionReason.allowanceExhausted,
      );
    },
  );

  test(
    'an unknown rejection reason is a format failure, never a silent success',
    () async {
      final gateway = CallableInferenceGateway(
        invoke: (name, payload, timeout) async => {
          'status': 'rejected',
          'reason': 'something_new',
        },
      );
      await expectLater(
        gateway.analyze(request()),
        throwsA(isA<FormatException>()),
      );
    },
  );

  test('an unknown status is a format failure', () async {
    final gateway = CallableInferenceGateway(
      invoke: (name, payload, timeout) async => {'status': 'weird'},
    );
    await expectLater(
      gateway.analyze(request()),
      throwsA(isA<FormatException>()),
    );
  });

  test('a non-map response is a format failure', () async {
    final gateway = CallableInferenceGateway(
      invoke: (name, payload, timeout) async => 'not a map',
    );
    await expectLater(
      gateway.analyze(request()),
      throwsA(isA<FormatException>()),
    );
  });

  test(
    'an oversized structural payload is rejected locally before any call',
    () async {
      var invoked = false;
      final gateway = CallableInferenceGateway(
        invoke: (name, payload, timeout) async {
          invoked = true;
          return {
            'status': 'ok',
            'plan': {'pageType': 'other', 'tables': <Object?>[]},
          };
        },
      );
      final huge = {'blob': 'x' * (25 * 1024)};
      await expectLater(
        gateway.analyze(request(structuralContent: huge)),
        throwsA(isA<FormatException>()),
      );
      expect(invoked, isFalse);
    },
  );

  test(
    'a non-retryable exception code is rethrown on the first attempt',
    () async {
      var calls = 0;
      final gateway = CallableInferenceGateway(
        maxAttempts: 3,
        backoff: (_) => Duration.zero,
        invoke: (name, payload, timeout) async {
          calls++;
          throw FirebaseFunctionsException(
            message: 'no auth',
            code: 'unauthenticated',
          );
        },
      );
      await expectLater(
        gateway.analyze(request()),
        throwsA(isA<FirebaseFunctionsException>()),
      );
      expect(calls, 1);
    },
  );

  test(
    'a retryable exception code is retried up to maxAttempts with backoff',
    () async {
      var calls = 0;
      final backoffDelays = <int>[];
      final gateway = CallableInferenceGateway(
        maxAttempts: 3,
        backoff: (attempt) {
          backoffDelays.add(attempt);
          return Duration.zero;
        },
        invoke: (name, payload, timeout) async {
          calls++;
          throw FirebaseFunctionsException(
            message: 'unavailable',
            code: 'unavailable',
          );
        },
      );
      await expectLater(
        gateway.analyze(request()),
        throwsA(isA<FirebaseFunctionsException>()),
      );
      expect(calls, 3);
      expect(backoffDelays, [1, 2]);
    },
  );

  test(
    'a retryable call that succeeds on a later attempt returns success',
    () async {
      var calls = 0;
      final gateway = CallableInferenceGateway(
        maxAttempts: 3,
        backoff: (_) => Duration.zero,
        invoke: (name, payload, timeout) async {
          calls++;
          if (calls < 2) {
            throw FirebaseFunctionsException(
              message: 'deadline',
              code: 'deadline-exceeded',
            );
          }
          return {
            'status': 'ok',
            'plan': {'pageType': 'other', 'tables': <Object?>[]},
          };
        },
      );
      final outcome = await gateway.analyze(request());
      expect(outcome, isA<PortalInferenceSuccess>());
      expect(calls, 2);
    },
  );

  test('maxAttempts must be at least 1', () {
    expect(() => CallableInferenceGateway(maxAttempts: 0), throwsArgumentError);
  });
}
