import 'dart:convert';

import 'package:academia/core/core.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:local_auth_platform_interface/types/auth_exception.dart';
import 'dart:async';

/// Local datasource responsible for persisting and retrieving authentication
/// tokens using [FlutterSecureStorage].
///
/// ## Why local_auth instead of AndroidOptions.biometric()
///
/// [FlutterSecureStorage] exposes [AndroidOptions.biometric()] which binds the
/// encryption key to the Android hardware Keystore and triggers the system
/// biometric sheet on every read. This is technically stronger than a software
/// gate, but it creates two problems that make it unsuitable here:
///
/// 1. iOS has no equivalent. [IOSOptions] does not support hardware-bound
///    biometric key derivation, so using [AndroidOptions.biometric()] would
///    mean maintaining two completely separate authentication flows -- one that
///    is hardware-enforced on Android and one that is a software gate on iOS.
///    The security posture would differ silently between platforms with no way
///    to express that in a shared interface.
///
/// 2. The Keystore prompt fires on every read with no session concept. There is
///    no built-in way to say "the user already authenticated two seconds ago,
///    do not prompt again". The result is repeated biometric prompts within a
///    single user session, which is poor UX and inconsistent with how users
///    expect authentication to work in a mobile app.
///
/// Using [LocalAuthentication] gives us a single, consistent authentication
/// layer across all platforms with an explicit session model: the user
/// authenticates once per foreground session and [_sessionUnlocked] suppresses
/// further prompts until the app is backgrounded. On devices with no biometrics
/// or PIN enrolled the gate is skipped entirely so the app remains usable.
///
/// The tradeoff is that the encryption key backing [FlutterSecureStorage] is
/// not hardware-bound to user presence -- it is protected by the platform
/// secure enclave / Keystore at rest but not tied to biometric verification at
/// the key level. For the threat model of a typical mobile app (stolen unlocked
/// device, malicious process on a rooted device) this is an acceptable
/// tradeoff given the cross-platform consistency and session UX it enables.
///
/// ## Request queuing
///
/// [ensureAuthenticated] uses a [Completer] so that if multiple callers arrive
/// simultaneously (e.g. several requests firing on app start before the session
/// is unlocked), only one biometric prompt is shown. All other callers suspend
/// on the same [Future] and are released together once the single prompt
/// resolves. This prevents stacked prompts and ensures no request slips through
/// without a token because it lost a race against the prompt.
class AuthLocalDatasource {
  static const _tokenPrefix = 'token_';

  final FlutterSecureStorage _storage;
  final LocalAuthentication _localAuth;

  bool _sessionUnlocked = false;

  // When a prompt is in flight every subsequent caller awaits this completer
  // rather than spawning a second prompt. Null when no auth is in progress.
  Completer<Either<Failure, void>>? _authCompleter;

  AuthLocalDatasource({
    FlutterSecureStorage? storage,
    LocalAuthentication? localAuth,
  }) : _storage =
           storage ??
           const FlutterSecureStorage(
             aOptions: AndroidOptions(),
             iOptions: IOSOptions(
               accessibility: KeychainAccessibility.first_unlock_this_device,
             ),
           ),
       _localAuth = localAuth ?? LocalAuthentication();

  /// Invalidates the current session lock so the next protected access
  /// re-prompts. Call this from [AppLifecycleState.paused].
  ///
  /// If a prompt is currently showing this is a no-op -- invalidation is
  /// deferred until the in-flight prompt resolves to avoid cancelling an
  /// active auth attempt.
  void invalidateSession() {
    if (_authCompleter != null) return;
    _sessionUnlocked = false;
  }

  /// Ensures the user has authenticated at least once in this foreground
  /// session. Safe to call from multiple concurrent callers -- only one
  /// biometric prompt will ever be shown at a time.
  ///
  /// Exposed publicly so the Dio interceptor can await it before attaching
  /// tokens, which prevents any request from being dispatched unauthenticated
  /// while the prompt is pending.
  Future<Either<Failure, void>> ensureAuthenticated() async {
    if (_sessionUnlocked) return right(null);

    // A prompt is already in flight -- join the queue and wait for it.
    if (_authCompleter != null) return _authCompleter!.future;

    _authCompleter = Completer();

    try {
      final result = await _authenticate();
      _authCompleter!.complete(result);
      return result;
    } catch (e) {
      final failure = left<Failure, void>(
        AuthorizationFailure(
          message: 'An unexpected error occurred during authentication.',
          error: e,
        ),
      );
      _authCompleter!.complete(failure);
      return failure;
    } finally {
      _authCompleter = null;
    }
  }

  Future<Either<Failure, void>> _authenticate() async {
    final canAuth =
        await _localAuth.canCheckBiometrics ||
        await _localAuth.isDeviceSupported();

    if (!canAuth) {
      _sessionUnlocked = true;
      return right(null);
    }

    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason:
            "Just making sure it's you before we show the goodies.",
        biometricOnly: false,
        sensitiveTransaction: true,
        persistAcrossBackgrounding: true,
        authMessages: const [
          AndroidAuthMessages(cancelButton: 'No thanks'),
          IOSAuthMessages(cancelButton: 'No thanks'),
        ],
      );

      if (!authenticated) {
        return left(
          AuthorizationFailure(
            message:
                'Authentication was cancelled or failed. Please try again.',
            error: Exception('LocalAuthentication.authenticate returned false'),
          ),
        );
      }
    } on LocalAuthException catch (e) {
      switch (e.code) {
        // Device has no credentials enrolled -- treat as an unsecured device
        // and skip the gate rather than locking the user out.
        case LocalAuthExceptionCode.noBiometricsEnrolled:
        case LocalAuthExceptionCode.noCredentialsSet:
        // System dismissed the prompt (e.g. incoming call).
        // persistAcrossBackgrounding should prevent this but handle defensively.
        case LocalAuthExceptionCode.systemCanceled:
          break;

        case LocalAuthExceptionCode.userCanceled:
          return left(
            AuthorizationFailure(
              message: 'Authentication was cancelled. Please try again.',
              error: e,
            ),
          );

        case LocalAuthExceptionCode.temporaryLockout:
        case LocalAuthExceptionCode.biometricLockout:
          return left(
            AuthorizationFailure(
              message: 'Too many failed attempts. Please try again later.',
              error: e,
            ),
          );

        default:
          return left(
            AuthorizationFailure(
              message: 'Authentication is unavailable on this device.',
              error: e,
            ),
          );
      }
    }

    _sessionUnlocked = true;
    return right(null);
  }

  String _keyFor(String provider) => '$_tokenPrefix$provider';

  Future<void> _write(String provider, TokenData token) =>
      _storage.write(key: _keyFor(provider), value: jsonEncode(token.toJson()));

  Future<TokenData?> _read(String provider) async {
    final raw = await _storage.read(key: _keyFor(provider));
    if (raw == null) return null;
    return TokenData.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  /// Persists [token] to secure storage keyed by its provider.
  /// Does not require authentication -- called immediately after login.
  Future<Either<Failure, TokenData>> cacheOrUpdateToken(TokenData token) async {
    try {
      await _write(token.provider, token);
      return right(token);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              'We failed to save your authentication token. '
              'A quick restart or checking your storage might fix this.',
        ),
      );
    }
  }

  /// Returns every token stored across all providers.
  /// Requires authentication for the current session.
  Future<Either<Failure, List<TokenData>>> getAllCachedTokens() async {
    final authResult = await ensureAuthenticated();
    if (authResult.isLeft()) return authResult.map((_) => []);

    try {
      final all = await _storage.readAll();
      final tokens = all.entries
          .where((e) => e.key.startsWith(_tokenPrefix))
          .map(
            (e) =>
                TokenData.fromJson(jsonDecode(e.value) as Map<String, dynamic>),
          )
          .toList();
      return right(tokens);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              'An error occurred while reading your stored tokens. '
              'A quick app restart might fix this.',
        ),
      );
    }
  }

  /// Returns the token for [provider].
  /// Requires authentication for the current session.
  Future<Either<Failure, TokenData>> getTokenByProvider(String provider) async {
    final authResult = await ensureAuthenticated();
    if (authResult.isLeft()) {
      return authResult.map((_) => throw StateError('unreachable'));
    }

    try {
      final token = await _read(provider);
      if (token == null) {
        return left(
          NoDataFoundFailure(
            message:
                'No authentication token was found for $provider on your device. '
                'You may need to log in again.',
            error: Exception("Token for provider '$provider' not found."),
          ),
        );
      }
      return right(token);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              'An error occurred while reading your stored authentication token. '
              'A quick app restart might fix this.',
        ),
      );
    }
  }

  /// Wipes all stored tokens and invalidates the session.
  /// Does not require authentication -- logout must be reachable from a locked state.
  Future<Either<Failure, void>> deleteAllTokens() async {
    try {
      final all = await _storage.readAll();
      await Future.wait(
        all.keys
            .where((k) => k.startsWith(_tokenPrefix))
            .map((k) => _storage.delete(key: k)),
      );
      _sessionUnlocked = false;
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              'An error occurred while clearing your stored tokens. '
              'This issue has been noted.',
        ),
      );
    }
  }

  /// Deletes the token for a single [provider] without affecting others.
  Future<Either<Failure, void>> deleteTokenByProvider(String provider) async {
    try {
      await _storage.delete(key: _keyFor(provider));
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: 'Failed to remove the stored token for $provider.',
        ),
      );
    }
  }
}
