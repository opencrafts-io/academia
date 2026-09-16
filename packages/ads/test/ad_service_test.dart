import 'package:ads/ads.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdService.canShowAds', () {
    test('returns false when the user has the no_ads entitlement', () async {
      final service = AdService(
        hasNoAdsEntitlement: ({bool forceRefresh = false}) async => true,
      );

      expect(await service.canShowAds(), isFalse);
    });

    test(
      'returns true when the user does not have the no_ads entitlement',
      () async {
        final service = AdService(
          hasNoAdsEntitlement: ({bool forceRefresh = false}) async => false,
        );

        expect(await service.canShowAds(), isTrue);
      },
    );
  });

  group('BannerAdSize', () {
    test('keeps banner dimensions inside the ads package API', () {
      expect(BannerAdSize.banner.width, 320);
      expect(BannerAdSize.banner.height, 50);
    });
  });
}
