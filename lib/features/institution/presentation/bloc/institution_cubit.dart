import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'institution_state.dart';

class InstitutionCubit extends Cubit<InstitutionState> {
  final SearchForInstitutionByNameUsecase searchForInstitutionByNameUsecase;
  final AddAccountToInstitution addAccountToInstitution;
  final GetAllCachedInstitutionsUsecase getAllCachedInstitutionsUsecase;
  final GetAllUserAccountInstitutionsUsecase
  getAllUserAccountInstitutionsUsecase;

  InstitutionCubit({
    required this.searchForInstitutionByNameUsecase,
    required this.getAllUserAccountInstitutionsUsecase,
    required this.getAllCachedInstitutionsUsecase,
    required this.addAccountToInstitution,
  }) : super(InstitutionInitialState());

  Future<Either<String, List<Institution>>> searchForInstitutionByName(
    String nameSearchTerm,
  ) async {
    final result = await searchForInstitutionByNameUsecase(nameSearchTerm);
    return result.fold(
      (error) => left(error.message),
      (institutions) => right(institutions),
    );
  }

  Future<Either<String, bool>> linkAccountToInstitution(
    String accountID,
    int institutionID,
  ) async {
    final result = await addAccountToInstitution(
      AddAccountToInstitutionParams(
        accountID: accountID,
        institutionID: institutionID,
      ),
    );

    return result.fold((error) => left(error.message), (ok) => right(ok));
  }
}
