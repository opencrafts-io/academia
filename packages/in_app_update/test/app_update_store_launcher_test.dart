import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pub_semver/pub_semver.dart';

void main() {
  test('opens the selected campaign store URL in an external application', () async {
    final opener = _StoreUrlOpener();
    final launcher = AppUpdateStoreLauncher(opener);
    final campaign = UpdateCampaign(
      id: 'required-update',
      targetVersion: Version.parse('3.4.0'),
      mode: AppUpdateMode.required,
      title: 'Update required',
      message: 'Install the supported release.',
      storeUrl: Uri.parse(
        'https://play.google.com/store/apps/details?id=io.opencrafts.academia',
      ),
    );

    final wasOpened = await launcher.open(campaign);

    expect(wasOpened, isTrue);
    expect(opener.openedUrl, campaign.storeUrl);
  });
}

class _StoreUrlOpener implements StoreUrlOpener {
  Uri? openedUrl;

  @override
  Future<bool> openExternalApplication(Uri url) async {
    openedUrl = url;
    return true;
  }
}
