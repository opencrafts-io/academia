import 'package:core/core.dart';
import 'package:core/config/flavor.dart';
import 'package:database/database.dart';
import 'package:billing/billing.dart';
import 'package:ads/ads.dart';
import 'package:analytics/analytics.dart';
import 'package:academia/core/in_app_update/posthog_app_update_configuration_source.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:lock_in/lock_in.dart';
import 'package:settings/settings.dart';

import 'package:injectable/injectable.dart';

import 'package:get_it/get_it.dart';

@InjectableInit()
void configureDependencies(GetIt getIt, FlavorConfig flavorConfig) {
  configureCoreDependencies(getIt, flavorConfig);
  configureLocalDatabaseDependencies(getIt);
  configureLockInDependencies(getIt);
  configureBillingDependencies(getIt);
  configureAdsDependencies(getIt);
  configureAnalyticsDependencies(getIt);
  configureSettingsDependencies(getIt);
  configureInAppUpdateDependencies(
    getIt,
    configurationSource: flavorConfig.isProduction
        ? PosthogAppUpdateConfigurationSource(getIt<FeatureFlagReader>())
        : const DisabledAppUpdateConfigurationSource(),
    storeUrls: AppUpdateStoreUrls(
      android: Uri.parse(
        'https://play.google.com/store/apps/details?id=io.opencrafts.academia&hl=en&gl=KE',
      ),
      ios: Uri.parse(
        'https://apps.apple.com/us/app/academia-for-campus-students/id6753922995',
      ),
    ),
  );
}
