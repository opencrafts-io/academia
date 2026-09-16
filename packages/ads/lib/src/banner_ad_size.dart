import 'package:google_mobile_ads/google_mobile_ads.dart';

enum BannerAdSize {
  banner(320, 50),
  largeBanner(320, 100),
  mediumRectangle(300, 250),
  fullBanner(468, 60),
  leaderboard(728, 90);

  const BannerAdSize(this.width, this.height);

  final int width;
  final int height;

  AdSize get googleAdSize {
    return switch (this) {
      BannerAdSize.banner => AdSize.banner,
      BannerAdSize.largeBanner => AdSize.largeBanner,
      BannerAdSize.mediumRectangle => AdSize.mediumRectangle,
      BannerAdSize.fullBanner => AdSize.fullBanner,
      BannerAdSize.leaderboard => AdSize.leaderboard,
    };
  }
}
