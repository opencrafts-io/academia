import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrapping_result.g.dart';
part 'scrapping_result.freezed.dart';

@freezed
@JsonSerializable()
class ScrappingResult with _$ScrappingResult {
  const ScrappingResult({
    this.commandID,
    required this.success,
    required this.data,
    required this.executionTime,
    this.timestamp,
    this.error,
  });

  @override
  @JsonKey(name: "command_id")
  final String? commandID;

  @override
  final String? error;

  @override
  final bool success;

  @override
  final Map<String, dynamic> data;

  @override
  @JsonKey(name: "execution_time")
  final Duration executionTime;

  @override
  final DateTime? timestamp;

  factory ScrappingResult.fromJson(Map<String, dynamic> json) =>
      _$ScrappingResultFromJson(json);
}
