import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/shared_preferences_institution_fee_repository.dart';
import '../data/repositories/shared_preferences_institution_profile_repository.dart';
import '../domain/repositories/institution_repositories.dart';
import '../presentation/bloc/institution_records_cubit.dart';

/// Manual composition-root registration, mirroring the shape of
/// `injectable`-generated registration used elsewhere in this repo without
/// adding a build_runner step to this package. Call this once from the app
/// composition root (not from within this package) after `SharedPreferences`
/// is registered.
void registerInstitutionsDependencies(GetIt getIt) {
  if (!getIt.isRegistered<InstitutionProfileRepository>()) {
    getIt.registerLazySingleton<InstitutionProfileRepository>(
      () => SharedPreferencesInstitutionProfileRepository(
        getIt<SharedPreferences>(),
      ),
    );
  }
  if (!getIt.isRegistered<InstitutionFeeRepository>()) {
    getIt.registerLazySingleton<InstitutionFeeRepository>(
      () => SharedPreferencesInstitutionFeeRepository(
        getIt<SharedPreferences>(),
      ),
    );
  }
  getIt.registerFactory(
    () => InstitutionRecordsCubit(
      profileRepository: getIt<InstitutionProfileRepository>(),
      feeRepository: getIt<InstitutionFeeRepository>(),
    ),
  );
}
