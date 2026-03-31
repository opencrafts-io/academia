import 'dart:convert';

import 'package:academia/core/core.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

/// Local datasource responsible for persisting and retrieving authentication
/// tokens using [FlutterSecureStorage].
class AuthLocalDatasource {
  static const _tokenPrefix = 'token_';

  final FlutterSecureStorage _storage;

  AuthLocalDatasource({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(),
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.first_unlock_this_device,
            ),
          );

  String _keyFor(String provider) => '$_tokenPrefix$provider';

  Future<void> _write(String provider, TokenData token) =>
      _storage.write(key: _keyFor(provider), value: jsonEncode(token.toJson()));

  Future<TokenData?> _read(String provider) async {
    final raw = await _storage.read(key: _keyFor(provider));
    if (raw == null) return null;
    return TokenData.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  /// Persists [token] to secure storage keyed by its provider.
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
  Future<Either<Failure, List<TokenData>>> getAllCachedTokens() async {
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
  Future<Either<Failure, TokenData>> getTokenByProvider(String provider) async {
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

  /// Wipes all stored tokens effectively invalidating the session.
  Future<Either<Failure, void>> deleteAllTokens() async {
    try {
      final all = await _storage.readAll();
      await Future.wait(
        all.keys
            .where((k) => k.startsWith(_tokenPrefix))
            .map((k) => _storage.delete(key: k)),
      );
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
