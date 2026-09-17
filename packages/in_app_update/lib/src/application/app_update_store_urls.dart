import 'package:in_app_update/src/domain/app_update_platform.dart';

class AppUpdateStoreUrls {
  const AppUpdateStoreUrls({required this.android, required this.ios});

  final Uri android;
  final Uri ios;

  Uri forPlatform(AppUpdatePlatform platform) {
    return switch (platform) {
      AppUpdatePlatform.android => android,
      AppUpdatePlatform.ios => ios,
    };
  }
}
