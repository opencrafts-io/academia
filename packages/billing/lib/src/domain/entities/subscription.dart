import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';

@freezed
abstract class Subscription with _$Subscription {
  const factory Subscription({
    required int id,
    required String planCode,
    required int planId,
    required String planName,
    required String status,
    required bool cancelAtPeriodEnd,
    required DateTime? cancelledAt,
    required DateTime currentPeriodEnd,
    required DateTime currentPeriodStart,
    required DateTime startedAt,
  }) = _Subscription;
}
