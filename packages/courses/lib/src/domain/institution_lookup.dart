import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution_lookup.freezed.dart';

abstract interface class InstitutionLookup {
  Future<List<InstitutionSummary>> search(String query);
}

@freezed
abstract class InstitutionSummary with _$InstitutionSummary {
  const factory InstitutionSummary({required int id, required String name}) =
      _InstitutionSummary;
}
