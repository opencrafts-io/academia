import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Handles all ad-related operations including:
/// - Initializing the Mobile Ads SDK
/// - Providing platform-specific ad unit IDs
/// - Creating banner and interstitial ads
class AdService {
  bool _initialized = false;

  /// Initializes MobileAds plugins
  Future<void> initialize() async {
    if (_initialized) return;
    await MobileAds.instance.initialize();
    _initialized = true;
  }

  /// Returns the platform-appropriate AdMob banner ad unit ID.
  ///
  /// - Web: Returns `null` because AdMob does not support web platforms.
  /// - Android: Returns the production banner ad unit ID.
  /// - iOS: Currently returns `null` until an iOS ad unit is provided.
  /// - Other platforms: Returns `null` since they are not supported yet.
  ///
  /// This getter ensures that unsupported platforms fail gracefully by
  /// returning `null`, allowing your UI layer to decide how to handle the
  /// absence of ads without relying on exception handling.
  static String? get bannerAdUnitID {
    if (kIsWeb) {
      return null;
    }
    if (Platform.isAndroid) {
      return kDebugMode
          ? "ca-app-pub-3940256099942544/6300978111"
          : "ca-app-pub-4838989029590048/1220011077";
    }
    if (Platform.isIOS) {
      return null; // TODO (erick): Add iOS ad unit ID when available.
    }
    return null;
  }

  // Creates a banner ad with the specified parameters
  BannerAd? createBannerAd({
    required AdSize size,
    AdRequest? adRequest,
    BannerAdListener? bannerAdListener,
  }) {
    final id = bannerAdUnitID;
    if (id == null) return null;
    return BannerAd(
      size: size,
      request: adRequest ?? AdRequest(),
      adUnitId: id,
      listener: bannerAdListener ?? BannerAdListener(),
    )..load();
  }
}
