import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pub_semver/pub_semver.dart';

void main() {
  test(
    'emits required when the configuration requires the installed build',
    () async {
      final bloc = InAppUpdateBloc(
        configurationSource: _ConfigurationSource({
          'schema_version': 2,
          'platforms': {
            'android': {
              'campaigns': [
                {
                  'id': 'android-required',
                  'target_version': '3.4.0',
                  'mode': 'required',
                  'title': 'Update required',
                  'message': 'Install the supported release.',
                },
              ],
            },
          },
        }),
        platformProvider: const _PlatformProvider(AppUpdatePlatform.android),
        versionProvider: const _VersionProvider('3.3.1'),
        storeUrls: AppUpdateStoreUrls(
          android: Uri.parse(
            'https://play.google.com/store/apps/details?id=io.opencrafts.academia',
          ),
          ios: Uri.parse('https://apps.apple.com/app/id6753922995'),
        ),
      );

      final expectedState = expectLater(
        bloc.stream,
        emits(isA<InAppUpdateRequired>()),
      );

      bloc.add(const CheckForInAppUpdateEvent());
      await expectedState;
      await bloc.close();
    },
  );
}

class _ConfigurationSource implements AppUpdateConfigurationSource {
  const _ConfigurationSource(this._configuration);

  final Object _configuration;

  @override
  Future<Object?> load() async => _configuration;
}

class _PlatformProvider implements AppUpdatePlatformProvider {
  const _PlatformProvider(this._platform);

  final AppUpdatePlatform _platform;

  @override
  AppUpdatePlatform? get currentPlatform => _platform;
}

class _VersionProvider implements AppVersionProvider {
  const _VersionProvider(this._version);

  final String _version;

  @override
  Future<Version> currentVersion() async => Version.parse(_version);
}
