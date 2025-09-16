import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:dartz/dartz.dart';

class SearchForInstitutionByNameUsecase
    extends UseCase<List<Institution>, String> {
  InstitutionRepository institutionRepository;

  SearchForInstitutionByNameUsecase({required this.institutionRepository});

  @override
  Future<Either<Failure, List<Institution>>> call(String searchTerm) {
    return institutionRepository.searchForInstitutionByName(searchTerm);
  }
}
