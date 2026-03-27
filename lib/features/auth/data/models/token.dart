import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';
part 'token.g.dart';

@freezed
abstract class TokenData with _$TokenData {
  const factory TokenData({
    @JsonKey(name: "verisafe") required String provider,
    @JsonKey(name: "access_token") required String accessToken,
    @JsonKey(name: "refresh_token") required String refreshToken,
    @JsonKey(
      name: "access_expires_at",
      fromJson: _dateFromJson,
      toJson: _dateToJson,
    )
    required DateTime accessExpiresAt,
    @JsonKey(
      name: "refresh_expires_at",
      fromJson: _dateFromJson,
      toJson: _dateToJson,
    )
    required DateTime refreshExpiresAt,
  }) = _TokenData;

  factory TokenData.fromJson(Map<String, dynamic> json) =>
      _$TokenDataFromJson(json);
}

DateTime _dateFromJson(String? value) =>
    value == null ? DateTime.now() : DateTime.parse(value);

String? _dateToJson(DateTime? value) => value?.toIso8601String();
