import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _Handler with DioErrorHandler {}

void main() {
  final handler = _Handler();
  final options = RequestOptions(path: '/posts/feed/');

  DioException badResponse(dynamic body, {int status = 500, String? reason}) =>
      DioException(
        requestOptions: options,
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: options,
          data: body,
          statusCode: status,
          statusMessage: reason,
        ),
      );

  String messageOf(Either<Failure, dynamic> result) =>
      result.fold((f) => f.message, (_) => fail('expected a failure'));

  test('plain-text gateway bodies do not throw', () {
    // A 502/503 from the ingress returns "Bad Gateway" as a String; indexing
    // it used to blow up with "'String' is not a subtype of type 'int'".
    final msg = messageOf(
      handler.handleDioError(badResponse('Bad Gateway', status: 502)),
    );
    expect(msg, contains('502'));
  });

  test('list bodies do not throw', () {
    final msg = messageOf(
      handler.handleDioError(
        badResponse(['oops'], status: 400, reason: 'Bad Request'),
      ),
    );
    expect(msg, 'Bad Request');
  });

  test('map bodies surface error / message / detail', () {
    expect(
      messageOf(
        handler.handleDioError(badResponse({'error': 'nope'}, status: 400)),
      ),
      'nope',
    );
    expect(
      messageOf(
        handler.handleDioError(badResponse({'message': 'm'}, status: 400)),
      ),
      'm',
    );
    expect(
      messageOf(
        handler.handleDioError(badResponse({'detail': 'd'}, status: 403)),
      ),
      'd',
    );
  });

  test('null body falls back to a generic message', () {
    final msg = messageOf(
      handler.handleDioError(badResponse(null, status: 418)),
    );
    expect(msg, isNotEmpty);
  });
}
