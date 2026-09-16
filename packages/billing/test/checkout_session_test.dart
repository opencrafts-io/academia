import 'package:billing/src/data/datasources/checkout_remote_datasource.dart';
import 'package:billing/src/data/dtos/create_checkout_session_dto.dart';
import 'package:billing/src/domain/entities/checkout_session.dart';
import 'package:billing/src/domain/entities/create_checkout_session_request.dart';
import 'package:billing/src/domain/repository/repository.dart';
import 'package:billing/src/domain/usecases/create_checkout_session.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CheckoutRemoteDatasource', () {
    test('creates a checkout session for an order', () async {
      final apiClient = _RecordingApiClient(
        response: {
          'checkout_url': 'https://checkout.example.test/start?code=abc',
          'expires_at': '2026-09-11T06:25:43Z',
        },
      );

      final result = await CheckoutRemoteDatasourceImpl(apiClient: apiClient)
          .createCheckoutSession(
            const CreateCheckoutSessionDto(orderId: 'ORD-ABC12345'),
          );

      expect(apiClient.path, endsWith('/checkout-sessions'));
      expect(apiClient.data, {'order_id': 'ORD-ABC12345'});
      expect(result.isRight(), isTrue);
      final session = result.getOrElse(
        () => throw StateError('missing checkout session'),
      );
      expect(
        session.checkoutUrl,
        'https://checkout.example.test/start?code=abc',
      );
      expect(session.expiresAt, DateTime.utc(2026, 9, 11, 6, 25, 43));
    });
  });

  test('creates a checkout session through the repository', () async {
    final repository = _FakeCheckoutRepository();
    final useCase = CreateCheckoutSession(repository);

    final result = await useCase(
      const CreateCheckoutSessionRequest(orderId: 'ORD-ABC12345'),
    );

    expect(repository.request?.orderId, 'ORD-ABC12345');
    expect(result.isRight(), isTrue);
    expect(
      result.getOrElse(() => throw StateError('missing session')).orderId,
      'ORD-ABC12345',
    );
  });
}

class _RecordingApiClient implements ApiClient {
  _RecordingApiClient({required this.response});

  final Map<String, dynamic> response;
  String? path;
  Object? data;

  @override
  Future<Either<Failure, T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) async {
    this.path = path;
    this.data = data;
    return right(decoder == null ? response as T : decoder(response));
  }

  @override
  Future<Either<Failure, T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) => throw UnimplementedError();
}

class _FakeCheckoutRepository implements CheckoutRepository {
  CreateCheckoutSessionRequest? request;

  @override
  Future<Either<Failure, CheckoutSession>> createCheckoutSession(
    CreateCheckoutSessionRequest request,
  ) async {
    this.request = request;
    return right(
      CheckoutSession(
        orderId: request.orderId,
        checkoutUrl: 'https://checkout.example.test/start?code=abc',
        expiresAt: DateTime.utc(2026, 9, 11, 6, 25, 43),
      ),
    );
  }
}
