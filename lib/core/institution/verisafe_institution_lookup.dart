import 'package:academia/features/institution/data/datasources/institution_remote_datasource.dart';
import 'package:courses/courses.dart';

class VerisafeInstitutionLookup implements InstitutionLookup {
  VerisafeInstitutionLookup(this._datasource);

  final InstitutionRemoteDatasource _datasource;

  @override
  Future<List<InstitutionSummary>> search(String query) async {
    final result = await _datasource.searchForInstitutionByName(query);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (institutions) => institutions
          .map(
            (institution) => InstitutionSummary(
              id: institution.institutionId,
              name: institution.name,
            ),
          )
          .toList(),
    );
  }
}
