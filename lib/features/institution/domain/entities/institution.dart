import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution.freezed.dart';

@freezed
abstract class Institution with _$Institution {
  const factory Institution({
    required int institutionId,
    required String name,
    required List<String>? webPages,
    required List<String>? domains,
    required String? alphaTwoCode,
    required String? country,
    String? stateProvince,
  }) = _Institution;
}
