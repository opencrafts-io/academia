import 'package:academia/features/features.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final AdSize size;

  /// Optional: custom ad request
  final AdRequest? adRequest;

  /// Optional: custom listener
  final BannerAdListener? listener;

  const BannerAdWidget({
    super.key,
    required this.size,
    this.adRequest,
    this.listener,
  });

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  void _loadBanner() {
    final adService = sl<AdService>();

    _bannerAd = adService.createBannerAd(
      size: widget.size,
      adRequest: widget.adRequest,
      bannerAdListener: BannerAdListener(
        onAdLoaded: (ad) {
          widget.listener?.onAdLoaded?.call(ad);
          setState(() => _isAdLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _bannerAd = null;
          setState(() => _isAdLoaded = false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded || _bannerAd == null) {
      return const SizedBox.shrink(); // hide until loaded
    }

    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
