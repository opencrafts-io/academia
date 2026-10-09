import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  final mapper = _ErrorMapper();

  test('maps Professor nested errors with status and details', () {
    final failure = mapper.map(
      DioException(
        requestOptions: RequestOptions(path: '/notes/'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/notes/'),
          statusCode: 403,
          data: {
            'error': {
              'code': 'entitlement_required',
              'message': 'Upgrade required',
              'details': {'feature': 'notes'},
            },
          },
        ),
      ),
    );

    expect(failure, isA<ServerFailure>());
    expect((failure as ServerFailure).statusCode, 403);
    expect(failure.code, 'entitlement_required');
    expect(failure.message, 'Upgrade required');
    expect(failure.metadata, {'feature': 'notes'});
  });

  test('continues mapping existing message and error response shapes', () {
    final messageFailure = mapper.map(
      _responseError({'message': 'Old message shape'}, 400),
    ) as ServerFailure;
    final errorFailure = mapper.map(
      _responseError({'error': 'Old error shape'}, 422),
    ) as ServerFailure;

    expect(messageFailure.message, 'Old message shape');
    expect(messageFailure.statusCode, 400);
    expect(errorFailure.message, 'Old error shape');
    expect(errorFailure.statusCode, 422);
  });
}

DioException _responseError(Map<String, dynamic> body, int status) =>
    DioException(
      requestOptions: RequestOptions(path: '/legacy/'),
      type: DioExceptionType.badResponse,
      response: Response<dynamic>(
        requestOptions: RequestOptions(path: '/legacy/'),
        statusCode: status,
        data: body,
      ),
    );

class _ErrorMapper with DioErrorHandler {
  Failure map(DioException error) => handleDioError<void>(error).fold(
    (failure) => failure,
    (_) => throw StateError('An error response cannot succeed'),
  );
}
