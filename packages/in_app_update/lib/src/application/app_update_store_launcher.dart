import 'package:in_app_update/src/domain/update_campaign.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

abstract interface class StoreUrlOpener {
  Future<bool> openExternalApplication(Uri url);
}

@LazySingleton(as: StoreUrlOpener)
class UrlLauncherStoreUrlOpener implements StoreUrlOpener {
  const UrlLauncherStoreUrlOpener();

  @override
  Future<bool> openExternalApplication(Uri url) {
    return launchUrl(url, mode: LaunchMode.externalApplication);
  }
}

@lazySingleton
class AppUpdateStoreLauncher {
  AppUpdateStoreLauncher(
    this._opener, {
    @ignoreParam Set<String>? trustedStoreHosts,
  }) : _trustedStoreHosts =
           trustedStoreHosts ?? const {'play.google.com', 'apps.apple.com'};

  final StoreUrlOpener _opener;
  final Set<String> _trustedStoreHosts;

  Future<bool> open(UpdateCampaign campaign) {
    if (!_isTrustedStoreUrl(campaign.storeUrl)) return Future.value(false);
    return _opener.openExternalApplication(campaign.storeUrl);
  }

  bool _isTrustedStoreUrl(Uri url) {
    return url.scheme == 'https' &&
        url.host.isNotEmpty &&
        _trustedStoreHosts.contains(url.host.toLowerCase());
  }
}
