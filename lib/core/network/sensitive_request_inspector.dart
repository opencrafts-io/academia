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

    if (_isQuestionResponse(response.requestOptions)) {
      _inspector.onResponse(
        Response<dynamic>(
          requestOptions: response.requestOptions,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          headers: response.headers,
          data: const {'redacted': true},
        ),
        ResponseInterceptorHandler(),
      );
      handler.next(response);
      return;
    }

    _inspector.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final wasRecorded = _recordedRequests.remove(err.requestOptions);
    if (!wasRecorded && _isSensitive(err.requestOptions)) {
      handler.next(err);
      return;
    }

    _inspector.onError(err, handler);
  }

  bool _isSensitive(RequestOptions options) =>
      options.extra['sensitive'] == true ||
      options.extra['authRefreshAttempted'] == true ||
      options.extra['authRetried'] == true;

  bool _isQuestionResponse(RequestOptions options) =>
      options.path.endsWith('/questions/');
}
