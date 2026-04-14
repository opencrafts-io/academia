import 'package:academia/features/institution/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:academia/config/config.dart';
import 'package:academia/injection_container.dart';

part 'institution_event.dart';
part 'institution_state.dart';

class InstitutionBloc extends Bloc<InstitutionEvent, InstitutionState> {
  final SearchForInstitutionByNameUsecase searchForInstitutionByNameUsecase;
  final AddAccountToInstitution addAccountToInstitution;
  final RemoveAccountFromInstitutionUsecase removeAccountFromInstitutionUsecase;
  final GetAllCachedInstitutionsUsecase getAllCachedInstitutionsUsecase;
  final GetAllUserAccountInstitutionsUsecase
  getAllUserAccountInstitutionsUsecase;
  final Posthog posthog = Posthog();

  InstitutionBloc({
    required this.searchForInstitutionByNameUsecase,
    required this.getAllUserAccountInstitutionsUsecase,
    required this.getAllCachedInstitutionsUsecase,
    required this.addAccountToInstitution,
    required this.removeAccountFromInstitutionUsecase,
  }) : super(InstitutionInitialState()) {
    on<SearchInstitutionByNameEvent>(_onSearchInstitutionByName);
    on<LinkAccountToInstitutionEvent>(_onLinkAccountToInstitution);
    on<GetCachedUserInstitutionsEvent>(_onGetCachedUserInstitutions);
    on<RefreshUserInstitutionsEvent>(_onRefreshUserInstitutions);
    on<UnLinkAccountFromInstitutionEvent>(_onUnLinkAccountFromInstitution);
  }

  Future<void> _onSearchInstitutionByName(
    SearchInstitutionByNameEvent event,
    Emitter<InstitutionState> emit,
  ) async {
    emit(InstitutionLoadingState());
    final result = await searchForInstitutionByNameUsecase(
      event.nameSearchTerm,
    );
    result.fold((error) => emit(InstitutionErrorState(error: error.message)), (
      institutions,
    ) {
      if (sl<FlavorConfig>().isProduction) {
        posthog.capture(
          eventName: "institution_search",
          properties: {"institution": event.nameSearchTerm},
        );
      }

      emit(InstitutionLoadedState(institutions: institutions));
    });
  }

  Future<void> _onLinkAccountToInstitution(
    LinkAccountToInstitutionEvent event,
    Emitter<InstitutionState> emit,
  ) async {
    emit(InstitutionLoadingState());
    final result = await addAccountToInstitution(
      AddAccountToInstitutionParams(
        accountID: event.accountID,
        institutionID: event.institutionID,
      ),
    );

    result.fold((error) => emit(InstitutionErrorState(error: error.message)), (
      link,
    ) {
      if (sl<FlavorConfig>().isProduction) {
        posthog.capture(
          eventName: "institution_link",
          properties: {
            "institution": event.institutionID,
            "user": event.accountID,
          },
        );
      }
      emit(InstitutionLinkedState());
    });
  }

  Future<void> _onUnLinkAccountFromInstitution(
    UnLinkAccountFromInstitutionEvent event,
    Emitter<InstitutionState> emit,
  ) async {
    emit(InstitutionLoadingState());
    final result = await removeAccountFromInstitutionUsecase(
      RemoveAccountFromInstitutionParams(
        accountID: event.accountID,
        institutionID: event.institutionID,
      ),
    );

    result.fold((error) => emit(InstitutionErrorState(error: error.message)), (
      link,
    ) {
      if (sl<FlavorConfig>().isProduction) {
        posthog.capture(
          eventName: "institution_unlink",
          properties: {
            "institution": event.institutionID,
            "user": event.accountID,
          },
        );
      }
      emit(InstitutionLinkedState());
    });
  }

  Future<void> _onGetCachedUserInstitutions(
    GetCachedUserInstitutionsEvent event,
    Emitter<InstitutionState> emit,
  ) async {
    emit(InstitutionLoadingState());
    final result = await getAllCachedInstitutionsUsecase(event.accountID);
    result.fold(
      (error) => emit(InstitutionErrorState(error: error.message)),
      (institutions) =>
          emit(InstitutionLoadedState(institutions: institutions)),
    );
  }

  Future<void> _onRefreshUserInstitutions(
    RefreshUserInstitutionsEvent event,
    Emitter<InstitutionState> emit,
  ) async {
    emit(InstitutionLoadingState());
    final result = await getAllUserAccountInstitutionsUsecase(event.accountID);
    result.fold(
      (error) => emit(InstitutionErrorState(error: error.message)),
      (institutions) =>
          emit(InstitutionLoadedState(institutions: institutions)),
    );
  }
}
