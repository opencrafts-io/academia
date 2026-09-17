import 'package:academia/core/di/injection.dart';
import 'package:academia/core/permissions/analytics_permission_request_observer.dart';
import 'package:analytics/analytics.dart';
import 'package:core/config/flavor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:permissions/permissions.dart';
import 'package:settings/settings.dart';

void main() {
  test(
    'configures package-owned analytics and update dependencies centrally',
    () {
      final getIt = GetIt.asNewInstance();

      configureDependencies(
        getIt,
        FlavorConfig(
          flavor: Flavor.staging,
          appName: 'Academia - Staging',
          apiBaseUrl: 'https://api.opencrafts.io',
        ),
      );

      expect(getIt<FeatureFlagReader>(), isA<FeatureFlagReader>());
      expect(getIt.isRegistered<AnalyticsTracker>(), isTrue);
      expect(getIt<AnalyticsGateway>(), isA<DisabledAnalyticsGateway>());
      expect(getIt<InAppUpdateBloc>(), isA<InAppUpdateBloc>());
      expect(getIt.isRegistered<SettingsCubit>(), isTrue);
      expect(getIt.isRegistered<PermissionCubit>(), isTrue);
      expect(
        getIt<PermissionRequestObserver>(),
        isA<AnalyticsPermissionRequestObserver>(),
      );
      expect(
        getIt<AppUpdateConfigurationSource>(),
        isA<DisabledAppUpdateConfigurationSource>(),
      );
    },
  );
}
