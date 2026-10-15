import 'package:academia/core/network/sensitive_request_inspector.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('captures Study Tools material and multipart request metadata', () {
    final recorder = _RecordingInterceptor();
    final inspector = SensitiveRequestInspector(recorder);
    final options = RequestOptions(
      path: '/qa-professor/api/notes/',
      method: 'POST',
      data: FormData()..fields.add(const MapEntry('course_id', 'course-uuid')),
    );

    inspector.onRequest(options, RequestInterceptorHandler());

    expect(recorder.requests, hasLength(1));
    expect(recorder.requests.single.path, '/qa-professor/api/notes/');
  });

  test('captures question endpoint status without recording its answers', () {
    final recorder = _RecordingInterceptor();
    final inspector = SensitiveRequestInspector(recorder);
    final options = RequestOptions(
      path: '/qa-professor/api/notes/7/questions/',
      method: 'GET',
    );
    final questionResponse = Response<dynamic>(
      requestOptions: options,
      statusCode: 200,
      data: {
        'sets': [
          {
            'questions': [
              {'front': 'Private prompt', 'back': 'Private answer'},
            ],
          },
        ],
      },
    );

    inspector.onRequest(options, RequestInterceptorHandler());
    inspector.onResponse(questionResponse, ResponseInterceptorHandler());

    expect(recorder.responses, hasLength(1));
    expect(recorder.responses.single.statusCode, 200);
    expect(recorder.responses.single.data, {'redacted': true});
    expect(
      recorder.responses.single.data.toString(),
      isNot(contains('Private')),
    );
  });
}

class _RecordingInterceptor extends Interceptor {
  final requests = <RequestOptions>[];
  final responses = <Response<dynamic>>[];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    requests.add(options);
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    responses.add(response);
    handler.next(response);
  }
}
