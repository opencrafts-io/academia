import 'package:portal_sync/portal_sync.dart';

/// Feature flag for the Verisafe-to-Firebase identity bridge described in
/// docs/portal-sync-plan.md's Phase 3 row: "Verisafe-to-Firebase identity
/// bridge". Follows the same `--dart-define` pattern as
/// `PORTAL_SYNC_ENABLED` / `PORTAL_BYPASS_SUBSCRIPTION` in this directory.
///
/// SCOPE NOTE: no server endpoint implementing this exchange exists in any
/// checkout reachable from this repository — no Firebase Cloud Functions
/// source, no access to the "Professor" backend repository. This flag must
/// stay false in every real build (its default) until a real, verified
/// endpoint exists and [VerisafePortalIdentityBridgeClient] is wired to an
/// actual [PortalIdentityBridgeEndpoint] at the composition root. Flipping
/// this flag on its own enables nothing: no production
/// [PortalIdentityBridgeEndpoint] is registered anywhere in this app.
const portalIdentityBridgeEnabled = bool.fromEnvironment(
  'PORTAL_IDENTITY_BRIDGE_ENABLED',
  defaultValue: false,
);

/// App-level driver for [PortalIdentityBridge]: reads the student's current
/// Verisafe access token the same way Academia's `VerisafeAuthInterceptor`
/// does when attaching it to ordinary API requests, and forwards it to an
/// injected bridge implementation.
///
/// This class is intentionally NOT wired into
/// `lib/core/integration/portal_sync/school_portal_page.dart` or
/// `lib/injection_container.dart`. It exists so that once a real
/// identity-bridge endpoint is deployed and verified, wiring it in is a
/// small, isolated composition-root change — constructing this class with a
/// real [PortalIdentityBridge] and calling [exchangeCurrentSession] at the
/// point server-verified inference is introduced — rather than new
/// plumbing through the controller or capture/extraction/review/import
/// logic.
class VerisafePortalIdentityBridgeClient {
  VerisafePortalIdentityBridgeClient({
    required this.bridge,
    required this.readVerisafeAccessToken,
    this.enabled = portalIdentityBridgeEnabled,
  });

  /// The exchange implementation. In every real build today this would be
  /// an [EndpointPortalIdentityBridge] wrapping a real HTTP/callable
  /// endpoint — but no such endpoint exists yet, so nothing in this
  /// repository constructs one for production use.
  final PortalIdentityBridge bridge;

  /// Reads the student's current Verisafe bearer access token (the same
  /// value `VerisafeAuthInterceptor` attaches to ordinary Academia API
  /// requests), or `null`/empty if there is no active session. Injected
  /// rather than reading `AuthLocalDatasource` directly so this class stays
  /// testable without secure storage.
  final Future<String?> Function() readVerisafeAccessToken;

  /// Whether this driver is permitted to run at all. Defaults to
  /// [portalIdentityBridgeEnabled]; overridable per instance for testing.
  final bool enabled;

  Future<PortalIdentityBridgeOutcome> exchangeCurrentSession() async {
    if (!enabled) {
      throw StateError(
        'The Verisafe-to-Firebase identity bridge is not enabled in this build.',
      );
    }
    final token = await readVerisafeAccessToken();
    if (token == null || token.isEmpty) {
      return const PortalIdentityBridgeFailure(
        PortalIdentityBridgeFailureReason.sessionInvalid,
        message: 'No active Verisafe session.',
      );
    }
    return bridge.exchange(token);
  }
}
