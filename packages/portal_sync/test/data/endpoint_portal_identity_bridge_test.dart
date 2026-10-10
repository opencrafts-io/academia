import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/portal_sync.dart';

void main() {
  test('parses a successful token response', () async {
    String? sentToken;
    final bridge = EndpointPortalIdentityBridge((token) async {
      sentToken = token;
      return {'status': 'ok', 'firebaseCustomToken': 'fake-custom-token'};
    });
    final outcome = await bridge.exchange('verisafe-access-token');
    expect(sentToken, 'verisafe-access-token');
    expect(outcome, isA<PortalIdentityBridgeToken>());
    expect(
      (outcome as PortalIdentityBridgeToken).firebaseCustomToken,
      'fake-custom-token',
    );
  });

  test('parses a session-invalid failure', () async {
    final bridge = EndpointPortalIdentityBridge(
      (_) async => {
        'status': 'failed',
        'reason': 'session_invalid',
        'message': 'Sign in again.',
      },
    );
    final outcome = await bridge.exchange('expired-token');
    expect(outcome, isA<PortalIdentityBridgeFailure>());
    final failure = outcome as PortalIdentityBridgeFailure;
    expect(failure.reason, PortalIdentityBridgeFailureReason.sessionInvalid);
    expect(failure.message, 'Sign in again.');
  });

  test('a missing token on an ok status is a format failure', () async {
    final bridge = EndpointPortalIdentityBridge((_) async => {'status': 'ok'});
    await expectLater(
      bridge.exchange('token'),
      throwsA(isA<FormatException>()),
    );
  });

  test(
    'a bridge-unavailable failure is distinguishable from session-invalid',
    () async {
      final bridge = EndpointPortalIdentityBridge(
        (_) async => {'status': 'failed', 'reason': 'bridge_unavailable'},
      );
      final outcome = await bridge.exchange('token');
      expect(
        (outcome as PortalIdentityBridgeFailure).reason,
        PortalIdentityBridgeFailureReason.bridgeUnavailable,
      );
    },
  );

  test(
    'an unknown failure reason is a format failure, never a silent success',
    () async {
      final bridge = EndpointPortalIdentityBridge(
        (_) async => {'status': 'failed', 'reason': 'mystery'},
      );
      await expectLater(
        bridge.exchange('token'),
        throwsA(isA<FormatException>()),
      );
    },
  );

  test('an unknown status is a format failure', () async {
    final bridge = EndpointPortalIdentityBridge(
      (_) async => {'status': 'weird'},
    );
    await expectLater(
      bridge.exchange('token'),
      throwsA(isA<FormatException>()),
    );
  });

  test('a technical failure from the endpoint propagates as-is', () async {
    final bridge = EndpointPortalIdentityBridge(
      (_) async => throw Exception('network down'),
    );
    await expectLater(bridge.exchange('token'), throwsA(isA<Exception>()));
  });
}
