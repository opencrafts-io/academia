import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:dartz/dartz.dart';

/// Use case for saving an [InstitutionKey] for an institution.
class SaveInstitutionKeyUsecase extends UseCase<void, InstitutionKey> {
  final InstitutionKeyRepository repository;

  SaveInstitutionKeyUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(InstitutionKey key) {
    return repository.saveKey(institutionKey: key);
  }
}
