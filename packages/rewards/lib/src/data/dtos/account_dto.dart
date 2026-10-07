import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/account.dart';

part 'account_dto.freezed.dart';
part 'account_dto.g.dart';

@freezed
abstract class AccountDto with _$AccountDto {
  const AccountDto._();

  const factory AccountDto({
    @Default('') String id,
    @JsonKey(name: 'vibe_points') @Default(0) int vibePoints,
    @JsonKey(name: 'points_total') int? pointsTotal,
    int? points,
  }) = _AccountDto;

  factory AccountDto.fromJson(Map<String, dynamic> json) =>
      _$AccountDtoFromJson(json);

  RewardAccount toDomain() =>
      RewardAccount(id: id, vibePoints: pointsTotal ?? points ?? vibePoints);
}
