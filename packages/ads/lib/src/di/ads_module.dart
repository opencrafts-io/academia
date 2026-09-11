import 'package:get_it/get_it.dart';

import '../ad_service.dart';

void configureAdsDependencies(GetIt getIt) {
  if (!getIt.isRegistered<AdService>()) {
    getIt.registerLazySingleton<AdService>(
      () => AdService(billingService: getIt()),
    );
  }
}
