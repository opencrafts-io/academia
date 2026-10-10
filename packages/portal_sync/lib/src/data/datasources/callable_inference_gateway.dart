import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';

import '../../domain/entities/portal_analysis_plan.dart';
import '../../domain/repositories/portal_sync_repositories.dart';
import 'firebase_portal_analysis_client.dart';

/// The underlying call `cloud_functions`' `httpsCallable(...).call(...)`
/// performs: invoke [callableName] with [payload], bounded by [timeout],
/// and return the raw decoded response body. Injectable because
/// `cloud_functions`'s own `HttpsCallable` cannot be constructed or faked
/// from outside the plugin (see [CallableInferenceGateway]'s doc comment).
typedef HttpsCallableInvoker = Future<Object?> Function(
  String callableName,
  Map<String, Object?> payload,
  Duration timeout,
);

/// UNTESTABLE AGAINST A REAL BACKEND IN THIS REPOSITORY.
///
/// This is the Phase 3 "callable inference adapter" from
/// docs/portal-sync-plan.md: a [PortalInferenceGateway] that calls a Firebase
/// Cloud Function (`cloud_functions`'s `httpsCallable`) instead of calling
/// Gemini directly from the client, so entitlement/allowance checks and the
/// model call itself can move server-side.
///
/// No such Cloud Function exists in any checkout reachable from this
/// repository: there is no `functions/` source tree here, and the
/// "Professor" backend repository the design docs reference lives on a
/// different machine entirely. This class is therefore written against a
/// *documented contract* for a callable that does not exist yet, verified
/// here only against a fake/mock `HttpsCallable` (see
/// `callable_inference_gateway_test.dart`). Wiring this adapter into the app
/// composition root (replacing [FirebasePortalAnalysisClient] as the
/// `inferenceGateway` passed to `PortalSyncController`) is a DI registration
/// change for whoever deploys and verifies the real function — do not wire
/// it in before that happens, and do not represent this class as satisfying
/// the Phase 3 acceptance gate on its own.
///
/// ### Request contract (what the callable must accept)
///
/// A JSON object:
/// ```json
/// {
///   "accountId": "<Academia account id>",
///   "budgetKey": "<stable account/connection/content-fingerprint key>",
///   "modelVersion": "<model name, e.g. gemini-3.8-flash>",
///   "structuralContent": { /* same bounded, redacted structural JSON the
///                            direct client sends: node ids, table headers,
///                            coarse cell types — never raw values,
///                            screenshots, passwords, or cookies */ }
/// }
/// ```
/// The structural payload is size-capped identically to the direct adapter
/// ([FirebasePortalAnalysisClient.maxPromptBytes]) before the call is made;
/// callers never depend on the server to enforce that cap.
///
/// A real deployment is expected to authenticate the caller through Firebase
/// Auth (via the Verisafe-to-Firebase identity bridge — see
/// `portal_identity_bridge.dart`) rather than trusting the `accountId` field
/// alone; `accountId`/`budgetKey` here describe the request *shape*, not a
/// claim that this client-supplied value is treated as authoritative
/// server-side.
///
/// ### Response contract (what the callable must return)
///
/// Either a successful plan:
/// ```json
/// {"status": "ok", "plan": { /* PortalAnalysisPlan.toJson() shape */ }}
/// ```
/// or a typed rejection distinct from a transport/technical failure:
/// ```json
/// {"status": "rejected", "reason": "no_entitlement" | "allowance_exhausted", "message": "optional, student-facing"}
/// ```
/// Any other shape, and any `FirebaseFunctionsException`, is treated as a
/// technical failure and thrown — never silently treated as a rejection or a
/// success.
///
/// ### Retry/backoff
///
/// A bounded number of attempts ([maxAttempts], default 2) are made for
/// callable-reported transient codes (`unavailable`, `deadline-exceeded`,
/// `internal`) with an injectable backoff delay between attempts, so a
/// single flaky call does not immediately surface as a page-level analysis
/// failure to the student. This is independent of — and happens *before* —
/// the student-facing single bounded retry already implemented in
/// `PortalSyncController` for a page whose analysis failed outright.
/// Non-retryable codes (for example `unauthenticated`, `permission-denied`,
/// `invalid-argument`) are rethrown immediately.
///
/// ### Why this does not call `cloud_functions` types directly in tests
///
/// `cloud_functions`'s `HttpsCallable` has a library-private constructor
/// (`HttpsCallable._`) and is only ever produced by
/// `FirebaseFunctions.httpsCallable`, which itself resolves a real platform
/// channel delegate. Neither can be constructed or faked from outside the
/// plugin without a full Firebase platform-channel test harness. [invoke]
/// is therefore the actual seam this class is tested against: the default
/// ([_defaultInvoker]) performs the real `cloud_functions` call a
/// deployment would receive, while
/// `callable_inference_gateway_test.dart` injects a fake to verify request
/// shaping, response parsing, typed-rejection handling, and retry/backoff
/// without any Firebase platform channel or real deployment.
class CallableInferenceGateway implements PortalInferenceGateway {
  /// A factory (not a plain generative constructor) so [maxAttempts] is
  /// validated *before* [functions] ?? [FirebaseFunctions.instance] is ever
  /// touched: resolving the default Firebase app is unrelated to whether
  /// `maxAttempts` is sane, and must not happen — nor require a Firebase
  /// app to exist — just to reject a bad argument.
  factory CallableInferenceGateway({
    FirebaseFunctions? functions,
    String callableName = defaultCallableName,
    Duration callTimeout = const Duration(seconds: 30),
    int maxAttempts = 2,
    Duration Function(int attempt)? backoff,
    HttpsCallableInvoker? invoke,
  }) {
    if (maxAttempts < 1) {
      throw ArgumentError('maxAttempts must be at least 1.');
    }
    return CallableInferenceGateway._(
      invoke:
          invoke ?? _defaultInvoker(functions ?? FirebaseFunctions.instance),
      callableName: callableName,
      callTimeout: callTimeout,
      maxAttempts: maxAttempts,
      backoff: backoff ?? _defaultBackoff,
    );
  }

  // The public factory above names these arguments `invoke`/`backoff`; an
  // initializing formal would force the private field's leading underscore
  // into that external-facing name, so they're assigned explicitly instead.
  CallableInferenceGateway._({
    required HttpsCallableInvoker invoke,
    required this.callableName,
    required this.callTimeout,
    required this.maxAttempts,
    required Duration Function(int attempt) backoff,
  })
    // ignore: prefer_initializing_formals
    : _invoke = invoke,
       // ignore: prefer_initializing_formals
       _backoff = backoff;

  static const String defaultCallableName = 'portalInferenceAnalyze';

  static const Set<String> _retryableCodes = {
    'unavailable',
    'deadline-exceeded',
    'internal',
  };

  static Duration _defaultBackoff(int attempt) =>
      Duration(milliseconds: 250 * attempt);

  static HttpsCallableInvoker _defaultInvoker(FirebaseFunctions functions) =>
      (name, payload, timeout) async {
        final callable = functions.httpsCallable(
          name,
          options: HttpsCallableOptions(timeout: timeout),
        );
        final result = await callable.call<Object?>(payload);
        return result.data;
      };

  final HttpsCallableInvoker _invoke;
  final String callableName;
  final Duration callTimeout;
  final int maxAttempts;
  final Duration Function(int attempt) _backoff;

  @override
  Future<PortalInferenceOutcome> analyze(PortalInferenceRequest request) async {
    final payload = _buildPayload(request);
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final data = await _invoke(callableName, payload, callTimeout);
        return _parseResponse(data);
      } on FirebaseFunctionsException catch (error) {
        final isLastAttempt = attempt >= maxAttempts;
        if (isLastAttempt || !_retryableCodes.contains(error.code)) {
          rethrow;
        }
        await Future<void>.delayed(_backoff(attempt));
      }
    }
    // Unreachable: the loop above always either returns or throws.
    throw StateError('Callable inference gateway exhausted retries.');
  }

  Map<String, Object?> _buildPayload(PortalInferenceRequest request) {
    final structuralJson = jsonEncode(request.structuralContent);
    if (utf8.encode(structuralJson).length >
        FirebasePortalAnalysisClient.maxPromptBytes) {
      throw const FormatException(
        'Portal analysis structure exceeds the prompt limit.',
      );
    }
    return {
      'accountId': request.accountId,
      'budgetKey': request.budgetKey,
      'modelVersion': request.modelVersion,
      'structuralContent': request.structuralContent,
    };
  }

  PortalInferenceOutcome _parseResponse(Object? data) {
    if (data is! Map) {
      throw const FormatException(
        'Callable inference response must be a JSON object.',
      );
    }
    final status = data['status'];
    if (status == 'ok') {
      final plan = data['plan'];
      if (plan is! Map) {
        throw const FormatException(
          'Callable inference response is missing a plan.',
        );
      }
      return PortalInferenceSuccess(PortalAnalysisPlan.fromJson(plan));
    }
    if (status == 'rejected') {
      final reason = switch (data['reason']) {
        'no_entitlement' => PortalInferenceRejectionReason.noEntitlement,
        'allowance_exhausted' =>
          PortalInferenceRejectionReason.allowanceExhausted,
        final other => throw FormatException(
          'Unknown callable inference rejection reason: $other',
        ),
      };
      final message = data['message'];
      return PortalInferenceRejected(
        reason,
        message: message is String ? message : null,
      );
    }
    throw FormatException('Unknown callable inference status: $status');
  }
}
