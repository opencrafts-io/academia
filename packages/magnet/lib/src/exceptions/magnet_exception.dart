class MagnetException implements Exception {
  final String message;
  final String code;
  final bool isRetryable;

  const MagnetException(
    this.message, {
    required this.code,
    this.isRetryable = false,
  });

  @override
  String toString() => 'MagnetException($code): $message';
}
