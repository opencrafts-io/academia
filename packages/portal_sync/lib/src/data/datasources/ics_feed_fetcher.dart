import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../domain/entities/ics_feed_url_policy.dart';

/// Fetches the raw text of a student-supplied calendar feed. Implementations
/// must never log or persist [feedUrl]: it is credential-like material, the
/// same way a portal session cookie is.
abstract interface class IcsFeedFetcher {
  Future<String> fetchIcsText(Uri feedUrl);
}

/// Thrown by [DioIcsFeedFetcher] for every rejection path. Carries only a
/// stable reason code, never the feed URL or response body, so it is always
/// safe to log.
class IcsFeedFetchException implements Exception {
  const IcsFeedFetchException(this.reasonCode);
  final String reasonCode;

  @override
  String toString() => 'IcsFeedFetchException($reasonCode)';
}

/// A guarded, on-device HTTPS fetcher for calendar feed URLs.
///
/// Guardrails, matching the SSRF discipline the design doc asks for even on
/// a client fetcher:
/// - [IcsFeedUrlPolicy] (HTTPS-only, no embedded credentials, no obviously
///   private/loopback/link-local host) is applied to the initial URL and to
///   every redirect hop before it is followed — a redirect can never widen
///   access the initial URL did not already have.
/// - At most [maxRedirects] hops; redirects are never auto-followed by the
///   HTTP client, only by this explicit, re-validated loop.
/// - The response body is read incrementally and the request is aborted the
///   moment it exceeds [maxFeedBytes], before the rest of a hostile body is
///   ever buffered.
/// - The whole operation is bounded by [requestTimeout] regardless of how
///   slowly a malicious or broken server trickles bytes.
class DioIcsFeedFetcher implements IcsFeedFetcher {
  DioIcsFeedFetcher({Dio? dio}) : _dio = dio ?? Dio() {
    final options = _dio.options;
    options.followRedirects = false;
    options.validateStatus = _acceptAnyStatus;
    options.connectTimeout = requestTimeout;
    options.receiveTimeout = requestTimeout;
    options.responseType = ResponseType.stream;
    options.headers = {'Accept': 'text/calendar, text/plain;q=0.5, */*;q=0.1'};
  }

  static bool _acceptAnyStatus(int? status) => status != null && status < 600;

  static const int maxFeedBytes = 2 * 1024 * 1024;
  static const int maxRedirects = 5;
  static const Duration requestTimeout = Duration(seconds: 20);

  final Dio _dio;

  @override
  Future<String> fetchIcsText(Uri feedUrl) => _run(feedUrl).timeout(
    requestTimeout,
    onTimeout: () {
      throw const IcsFeedFetchException('timeout');
    },
  );

  Future<String> _run(Uri feedUrl) async {
    var current = _validate(feedUrl);
    for (var hop = 0; true; hop++) {
      final Response<ResponseBody> response;
      try {
        response = await _dio.getUri<ResponseBody>(current);
      } on DioException catch (error) {
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout) {
          throw const IcsFeedFetchException('timeout');
        }
        throw const IcsFeedFetchException('network_error');
      }
      final status = response.statusCode ?? 0;
      if (status >= 300 && status < 400) {
        if (hop >= maxRedirects) {
          throw const IcsFeedFetchException('too_many_redirects');
        }
        current = _validate(_resolveRedirect(current, response));
        continue;
      }
      if (status != 200) {
        throw const IcsFeedFetchException('unexpected_status');
      }
      final body = response.data;
      if (body == null) throw const IcsFeedFetchException('empty_response');
      return _readBounded(body.stream);
    }
  }

  Uri _resolveRedirect(Uri from, Response<ResponseBody> response) {
    final location = response.headers.value('location');
    if (location == null || location.trim().isEmpty) {
      throw const IcsFeedFetchException('redirect_missing_location');
    }
    final target = Uri.tryParse(location.trim());
    if (target == null) throw const IcsFeedFetchException('invalid_redirect');
    return from.resolveUri(target);
  }

  Uri _validate(Uri url) {
    try {
      return IcsFeedUrlPolicy.validate(url);
    } on IcsFeedUrlRejection catch (rejection) {
      throw IcsFeedFetchException(rejection.reasonCode);
    }
  }

  Future<String> _readBounded(Stream<Uint8List> stream) async {
    final builder = BytesBuilder(copy: false);
    await for (final chunk in stream) {
      builder.add(chunk);
      if (builder.length > maxFeedBytes) {
        throw const IcsFeedFetchException('response_too_large');
      }
    }
    return utf8.decode(builder.takeBytes(), allowMalformed: true);
  }
}
