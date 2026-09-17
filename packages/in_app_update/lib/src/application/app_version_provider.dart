import 'package:package_info_plus/package_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:pub_semver/pub_semver.dart';

abstract interface class AppVersionProvider {
  Future<Version> currentVersion();
}

@LazySingleton(as: AppVersionProvider)
class PackageInfoAppVersionProvider implements AppVersionProvider {
  const PackageInfoAppVersionProvider();

  @override
  Future<Version> currentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return Version.parse(packageInfo.version);
  }
}
