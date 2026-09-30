import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_update/in_app_update.dart';

void main() {
  test(
    'registers update runtime dependencies through the package initializer',
    () {
      final getIt = GetIt.asNewInstance();

      configureInAppUpdateDependencies(
        getIt,
        configurationSource: const DisabledAppUpdateConfigurationSource(),
        storeUrls: AppUpdateStoreUrls(
          android: Uri.parse(
            'https://play.google.com/store/apps/details?id=io.opencrafts.academia',
          ),
          ios: Uri.parse('https://apps.apple.com/app/id6753922995'),
        ),
      );

      expect(getIt<AppUpdateStoreLauncher>(), isA<AppUpdateStoreLauncher>());
      expect(getIt<InAppUpdateBloc>(), isA<InAppUpdateBloc>());
    },
  );
}
