import '../../domain/entities/portal_identity_bridge.dart';

/// The network call a real identity-bridge endpoint would require: send the
/// student's current Verisafe access token, get back the raw JSON response
/// body. Nothing in this repository supplies a production implementation of
/// this typedef — there is no deployed endpoint to call. Tests inject a
/// fake; a real composition root would inject a call to a verified endpoint
/// only once one is deployed. This package deliberately ships no HTTP
/// client wiring and no guessed URL.
typedef PortalIdentityBridgeEndpoint = Future<Map<String, Object?>> Function(
  String verisafeAccessToken,
);

/// The client that WOULD perform the Verisafe-to-Firebase identity exchange
/// against a real endpoint, once one exists. See
/// `portal_identity_bridge.dart` for the full scope note: no such endpoint
/// exists in any checkout reachable from this repository, so this class is
/// verified only against a fake [PortalIdentityBridgeEndpoint] in tests.
///
/// Expected response shape from the endpoint:
/// - success: `{"status": "ok", "firebaseCustomToken": "<token>"}`
/// - typed rejection: `{"status": "failed", "reason": "session_invalid" |
///   "bridge_unavailable", "message": "optional"}`
///
/// Any other shape is a technical/transport-layer problem and is thrown as
/// a [FormatException] rather than silently treated as a rejection.
class EndpointPortalIdentityBridge implements PortalIdentityBridge {
  EndpointPortalIdentityBridge(this._endpoint);

  final PortalIdentityBridgeEndpoint _endpoint;

  @override
  Future<PortalIdentityBridgeOutcome> exchange(
    String verisafeAccessToken,
  ) async {
    final response = await _endpoint(verisafeAccessToken);
    final status = response['status'];
    if (status == 'ok') {
      final token = response['firebaseCustomToken'];
      if (token is! String || token.isEmpty) {
        throw const FormatException(
          'Identity bridge response is missing a Firebase custom token.',
        );
      }
      return PortalIdentityBridgeToken(token);
    }
    if (status == 'failed') {
      final reason = switch (response['reason']) {
        'session_invalid' => PortalIdentityBridgeFailureReason.sessionInvalid,
        'bridge_unavailable' =>
          PortalIdentityBridgeFailureReason.bridgeUnavailable,
        final other => throw FormatException(
          'Unknown identity bridge failure reason: $other',
        ),
      };
      final message = response['message'];
      return PortalIdentityBridgeFailure(
        reason,
        message: message is String ? message : null,
      );
    }
    throw FormatException('Unknown identity bridge status: $status');
  }
}
