import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    Object? error,
    StackTrace? stackTrace,
    String? code,
    int? statusCode,
    Map<String, dynamic>? metadata,
  }) = ServerFailure;

  const factory Failure.network({
    @Default('No internet connection') String message,

    Object? error,
    StackTrace? stackTrace,
    String? code,
    Map<String, dynamic>? metadata,
  }) = NetworkFailure;

  const factory Failure.auth({
    required String message,
    Object? error,
    StackTrace? stackTrace,
    String? code,
    int? statusCode,
    Map<String, dynamic>? metadata,
  }) = AuthFailure;

  const factory Failure.cache({
    required String message,
    Object? error,
    StackTrace? stackTrace,
    String? code,
    Map<String, dynamic>? metadata,
  }) = CacheFailure;

  const factory Failure.validation({
    required String message,
    Object? error,
    StackTrace? stackTrace,
    String? code,
    Map<String, dynamic>? metadata,
  }) = ValidationFailure;

  const factory Failure.unexpected({
    @Default('Unexpected error occurred') String message,

    Object? error,
    StackTrace? stackTrace,
    String? code,
    Map<String, dynamic>? metadata,
  }) = UnexpectedFailure;
}
