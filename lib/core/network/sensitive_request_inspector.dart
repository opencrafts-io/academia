import 'dart:collection';

import 'package:dio/dio.dart';

/// Hides requests marked sensitive before inspection, and completes entries
/// for requests that became sensitive later in the auth interceptor.
class SensitiveRequestInspector extends Interceptor {
  SensitiveRequestInspector(this._inspector);

  final Interceptor _inspector;
  final Set<RequestOptions> _recordedRequests = HashSet.identity();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_isSensitive(options)) {
      handler.next(options);
      return;
    }

    _recordedRequests.add(options);
    _inspector.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final wasRecorded = _recordedRequests.remove(response.requestOptions);
    if (!wasRecorded && _isSensitive(response.requestOptions)) {
      handler.next(response);
      return;
    }

    _inspector.onResponse(response, handler);
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    final wasRecorded = _recordedRequests.remove(error.requestOptions);
    if (!wasRecorded && _isSensitive(error.requestOptions)) {
      handler.next(error);
      return;
    }

    _inspector.onError(error, handler);
  }

  bool _isSensitive(RequestOptions options) =>
      options.extra['sensitive'] == true ||
      options.extra['authRefreshAttempted'] == true ||
      options.extra['authRetried'] == true;
}
