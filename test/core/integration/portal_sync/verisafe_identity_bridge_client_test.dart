import 'package:academia/core/integration/portal_sync/verisafe_identity_bridge_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/portal_sync.dart';

void main() {
  test('the flag defaults to false: no real build enables this without an explicit override', () {
    expect(portalIdentityBridgeEnabled, isFalse);
  });

  test(
    'a disabled client refuses to run even with a valid session and bridge',
    () async {
      final client = VerisafePortalIdentityBridgeClient(
        enabled: false,
        bridge: _FakeBridge(
          (_) async => const PortalIdentityBridgeToken('token'),
        ),
        readVerisafeAccessToken: () async => 'verisafe-token',
      );
      await expectLater(client.exchangeCurrentSession(), throwsStateError);
    },
  );

  test(
    'an enabled client forwards the current Verisafe token to the bridge',
    () async {
      String? forwarded;
      final client = VerisafePortalIdentityBridgeClient(
        enabled: true,
        bridge: _FakeBridge((token) async {
          forwarded = token;
          return const PortalIdentityBridgeToken('firebase-custom-token');
        }),
        readVerisafeAccessToken: () async => 'verisafe-token-123',
      );
      final outcome = await client.exchangeCurrentSession();
      expect(forwarded, 'verisafe-token-123');
      expect(outcome, isA<PortalIdentityBridgeToken>());
      expect(
        (outcome as PortalIdentityBridgeToken).firebaseCustomToken,
        'firebase-custom-token',
      );
    },
  );

  test(
    'no active Verisafe session fails locally without calling the bridge',
    () async {
      var bridgeCalled = false;
      final client = VerisafePortalIdentityBridgeClient(
        enabled: true,
        bridge: _FakeBridge((_) async {
          bridgeCalled = true;
          return const PortalIdentityBridgeToken('token');
        }),
        readVerisafeAccessToken: () async => null,
      );
      final outcome = await client.exchangeCurrentSession();
      expect(outcome, isA<PortalIdentityBridgeFailure>());
      expect(
        (outcome as PortalIdentityBridgeFailure).reason,
        PortalIdentityBridgeFailureReason.sessionInvalid,
      );
      expect(bridgeCalled, isFalse);
    },
  );

  test(
    'an empty Verisafe token also fails locally without calling the bridge',
    () async {
      var bridgeCalled = false;
      final client = VerisafePortalIdentityBridgeClient(
        enabled: true,
        bridge: _FakeBridge((_) async {
          bridgeCalled = true;
          return const PortalIdentityBridgeToken('token');
        }),
        readVerisafeAccessToken: () async => '',
      );
      final outcome = await client.exchangeCurrentSession();
      expect(
        (outcome as PortalIdentityBridgeFailure).reason,
        PortalIdentityBridgeFailureReason.sessionInvalid,
      );
      expect(bridgeCalled, isFalse);
    },
  );

  test('a bridge-reported failure passes through unchanged', () async {
    final client = VerisafePortalIdentityBridgeClient(
      enabled: true,
      bridge: _FakeBridge(
        (_) async => const PortalIdentityBridgeFailure(
          PortalIdentityBridgeFailureReason.bridgeUnavailable,
        ),
      ),
      readVerisafeAccessToken: () async => 'verisafe-token',
    );
    final outcome = await client.exchangeCurrentSession();
    expect(
      (outcome as PortalIdentityBridgeFailure).reason,
      PortalIdentityBridgeFailureReason.bridgeUnavailable,
    );
  });
}

class _FakeBridge implements PortalIdentityBridge {
  _FakeBridge(this.handler);
  final Future<PortalIdentityBridgeOutcome> Function(String) handler;

  @override
  Future<PortalIdentityBridgeOutcome> exchange(String verisafeAccessToken) =>
      handler(verisafeAccessToken);
}
