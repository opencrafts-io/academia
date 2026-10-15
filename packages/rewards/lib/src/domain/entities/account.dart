import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
abstract class RewardAccount with _$RewardAccount {
  const factory RewardAccount({required String id, required int vibePoints}) =
      _RewardAccount;
}
