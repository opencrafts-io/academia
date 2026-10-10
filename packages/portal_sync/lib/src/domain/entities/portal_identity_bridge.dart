/// Client-side contract for the "Verisafe-to-Firebase identity bridge"
/// described in docs/portal-sync-plan.md's Phase 3 row: "Add a trusted
/// bridge that verifies the existing session and issues a Firebase custom
/// token tied to the same account when server enforcement is introduced. Do
/// not require a second student login."
///
/// SCOPE NOTE — read before using any type in this file: no server endpoint
/// implementing this exchange exists in any checkout reachable from this
/// repository (no Firebase Cloud Functions source, no access to the
/// "Professor" backend repository). Everything here is a documented
/// contract and a client ready to call such an endpoint once one is
/// deployed and verified — not a working integration. See
/// docs/portal-sync-internal.md for the honest status of this scaffolding.
library;

/// Why a [PortalIdentityBridge] could not produce a Firebase custom token,
/// as opposed to a transport/technical failure which implementations
/// surface as a thrown exception.
enum PortalIdentityBridgeFailureReason {
  /// The supplied Verisafe session is missing, expired, or otherwise
  /// invalid and the bridge refused to issue a token.
  sessionInvalid,

  /// The bridge endpoint itself is not available (for example: not deployed
  /// yet, feature-flagged off server-side). Distinct from a network/5xx
  /// failure, which should surface as a thrown exception instead.
  bridgeUnavailable,
}

/// Result of a [PortalIdentityBridge.exchange] call that completed without a
/// technical failure: either a usable Firebase custom token, or a typed,
/// non-exceptional rejection.
sealed class PortalIdentityBridgeOutcome {
  const PortalIdentityBridgeOutcome();
}

class PortalIdentityBridgeToken extends PortalIdentityBridgeOutcome {
  const PortalIdentityBridgeToken(this.firebaseCustomToken);

  /// Opaque token to pass directly to
  /// `FirebaseAuth.instance.signInWithCustomToken`. Never logged.
  final String firebaseCustomToken;
}

class PortalIdentityBridgeFailure extends PortalIdentityBridgeOutcome {
  const PortalIdentityBridgeFailure(this.reason, {this.message});
  final PortalIdentityBridgeFailureReason reason;
  final String? message;
}

/// Exchanges the student's existing Verisafe session for a Firebase custom
/// token tied to the same account, so a future server-verified inference
/// gateway can authenticate through Firebase Auth without asking the
/// student to sign in a second time.
///
/// This interface has no production implementation anywhere in this
/// repository. [EndpointPortalIdentityBridge] (see
/// `endpoint_portal_identity_bridge.dart`) is the client that WOULD perform
/// this exchange against a real endpoint — it takes the endpoint as an
/// injected abstraction with no default, precisely so that no code path in
/// this app can silently call a guessed or placeholder URL.
abstract interface class PortalIdentityBridge {
  /// [verisafeAccessToken] is the student's current Verisafe bearer access
  /// token — the same one Academia's `VerisafeAuthInterceptor` attaches to
  /// ordinary API requests. Implementations must never log it.
  Future<PortalIdentityBridgeOutcome> exchange(String verisafeAccessToken);
}
