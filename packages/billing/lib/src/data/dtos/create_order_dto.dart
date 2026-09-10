import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_dto.freezed.dart';
part 'create_order_dto.g.dart';

@freezed
abstract class CreateOrderDto with _$CreateOrderDto {
  const factory CreateOrderDto({
    required String currency,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @Default(<int>[]) List<int> metadata,
    @JsonKey(name: 'user_id') String? userId,
  }) = _CreateOrderDto;

  factory CreateOrderDto.fromJson(Map<String, Object?> json) =>
      _$CreateOrderDtoFromJson(json);
}
