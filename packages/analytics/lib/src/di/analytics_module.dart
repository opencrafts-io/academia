import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../business/analytics_gateway.dart';
import '../business/analytics_tracker.dart';
import 'analytics_module.config.dart';

@InjectableInit(
  initializerName: 'initAnalytics',
  preferRelativeImports: true,
  asExtension: false,
)
void configureAnalyticsDependencies(
  GetIt getIt, {
  AnalyticsGateway? analyticsGateway,
}) {
  initAnalytics(getIt);
  if (!getIt.isRegistered<AnalyticsGateway>()) {
    getIt.registerLazySingleton<AnalyticsGateway>(
      () => analyticsGateway ?? PosthogAnalyticsGateway(),
    );
  }
  if (!getIt.isRegistered<AnalyticsTracker>()) {
    getIt.registerLazySingleton<AnalyticsTracker>(
      () => AnalyticsTracker(getIt<AnalyticsGateway>()),
    );
  }
}
