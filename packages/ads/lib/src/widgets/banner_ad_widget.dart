import 'package:ads/src/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({
    super.key,
    required this.size,
    this.adRequest,
    this.listener,
    this.adService,
  });

  final AdSize size;
  final AdRequest? adRequest;
  final BannerAdListener? listener;
  final AdService? adService;

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget>
    with AutomaticKeepAliveClientMixin {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _visibilityChecked = false;

  @override
  bool get wantKeepAlive => _isAdLoaded;

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  Future<void> _loadBanner() async {
    final adService = widget.adService ?? GetIt.I<AdService>();
    final bannerAd = await adService.createBannerAd(
      size: widget.size,
      adRequest: widget.adRequest,
      bannerAdListener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) return;
          widget.listener?.onAdLoaded?.call(ad);
          setState(() {
            _bannerAd = ad as BannerAd;
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          widget.listener?.onAdFailedToLoad?.call(ad, error);
          ad.dispose();
          if (!mounted) return;
          setState(() {
            _bannerAd = null;
            _isAdLoaded = false;
          });
        },
      ),
    );

    if (!mounted) {
      bannerAd?.dispose();
      return;
    }

    if (bannerAd == null) {
      setState(() {
        _bannerAd = null;
        _isAdLoaded = false;
        _visibilityChecked = true;
      });
    } else {
      setState(() {
        _bannerAd = bannerAd;
        _visibilityChecked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final bannerAd = _bannerAd;
    if (_visibilityChecked && bannerAd == null) {
      return const SizedBox.shrink();
    }

    if (!_isAdLoaded || bannerAd == null) {
      return SizedBox(
        width: widget.size.width.toDouble(),
        height: widget.size.height.toDouble(),
      );
    }

    return SizedBox(
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
