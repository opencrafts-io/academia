import 'package:academia/features/institution/domain/entities/institution.dart';

class ShereheInstitutionRouteArgs {
  final List<Institution> selectedInstitutions;
  final List<Institution>? eligibleInstitutions;
  final bool? onlyShowEligibleInstitutions;

  const ShereheInstitutionRouteArgs({
    required this.selectedInstitutions,
    this.eligibleInstitutions = const [],
    this.onlyShowEligibleInstitutions = false,
  });
}
