import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution_key.freezed.dart';

@freezed
abstract class InstitutionKey with _$InstitutionKey {
  const factory InstitutionKey({
    required int institutionId,
    required String commandId,
    required Map<String, dynamic> keySets,
    required DateTime createdAt,
  }) = _InstitutionKey;
}
