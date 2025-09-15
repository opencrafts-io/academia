part of 'institution_bloc.dart';


abstract class InstitutionEvent extends Equatable {
  const InstitutionEvent();

  @override
  List<Object?> get props => [];
}

class SearchInstitutionByNameEvent extends InstitutionEvent {
  final String nameSearchTerm;
  const SearchInstitutionByNameEvent(this.nameSearchTerm);

  @override
  List<Object?> get props => [nameSearchTerm];
}

class LinkAccountToInstitutionEvent extends InstitutionEvent {
  final String accountID;
  final int institutionID;
  const LinkAccountToInstitutionEvent({
    required this.accountID,
    required this.institutionID,
  });

  @override
  List<Object?> get props => [accountID, institutionID];
}

class GetCachedUserInstitutionsEvent extends InstitutionEvent {
  final String accountID;
  const GetCachedUserInstitutionsEvent(this.accountID);

  @override
  List<Object?> get props => [accountID];
}

class RefreshUserInstitutionsEvent extends InstitutionEvent {
  final String accountID;
  const RefreshUserInstitutionsEvent(this.accountID);

  @override
  List<Object?> get props => [accountID];
}
