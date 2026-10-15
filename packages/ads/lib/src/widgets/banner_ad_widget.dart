import 'dart:async';

import 'package:ads/src/ad_service.dart';
import 'package:ads/src/banner_ad_size.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({
    super.key,
    this.size = BannerAdSize.banner,
    this.adRequest,
    this.listener,
    this.adService,
  });

  final BannerAdSize size;
  final AdRequest? adRequest;
  final BannerAdListener? listener;
  final AdService? adService;

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget>
    with AutomaticKeepAliveClientMixin {
  late final AdService _adService;
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _visibilityChecked = false;
  bool _isLoading = false;
  int _loadGeneration = 0;
  final Expando<bool> _disposedAds = Expando<bool>();

  @override
  bool get wantKeepAlive => _isAdLoaded;

  @override
  void initState() {
    super.initState();
    _adService = widget.adService ?? GetIt.I<AdService>();
    _adService.adsAllowed.addListener(_onEligibilityChanged);
    unawaited(_loadBanner());
  }

  Future<void> _loadBanner() async {
    if (_isLoading || _bannerAd != null) return;
    _isLoading = true;
    final generation = ++_loadGeneration;
    try {
      final bannerAd = await _adService.createBannerAd(
        size: widget.size,
        adRequest: widget.adRequest,
        bannerAdListener: BannerAdListener(
          onAdLoaded: (ad) {
            if (!mounted ||
                generation != _loadGeneration ||
                !_adService.adsAllowed.value) {
              _disposeAd(ad);
              return;
            }
            widget.listener?.onAdLoaded?.call(ad);
            if (!mounted ||
                generation != _loadGeneration ||
                !_adService.adsAllowed.value) {
              _disposeAd(ad);
              return;
            }
            setState(() {
              _bannerAd = ad as BannerAd;
              _isAdLoaded = true;
            });
            updateKeepAlive();
          },
          onAdFailedToLoad: (ad, error) {
            widget.listener?.onAdFailedToLoad?.call(ad, error);
            _disposeAd(ad);
            if (!mounted || generation != _loadGeneration) return;
            _loadGeneration++;
            _isLoading = false;
            setState(() {
              _bannerAd = null;
              _isAdLoaded = false;
              _visibilityChecked = true;
            });
            updateKeepAlive();
          },
        ),
      );

      if (!mounted || generation != _loadGeneration) {
        if (bannerAd != null) _disposeAd(bannerAd);
        return;
      }

      if (bannerAd == null || !_adService.adsAllowed.value) {
        if (bannerAd != null) _disposeAd(bannerAd);
        setState(() {
          _bannerAd = null;
          _isAdLoaded = false;
          _visibilityChecked = true;
        });
        return;
      }

      if (_isAdLoaded) return;

      setState(() {
        _bannerAd = bannerAd;
        _isAdLoaded = false;
        _visibilityChecked = true;
      });
    } on Object {
      if (mounted && generation == _loadGeneration) {
        setState(() {
          _bannerAd = null;
          _isAdLoaded = false;
          _visibilityChecked = true;
        });
      }
    } finally {
      if (generation == _loadGeneration) _isLoading = false;
    }
  }

  void _onEligibilityChanged() {
    if (_adService.adsAllowed.value) {
      if (mounted && _bannerAd == null) unawaited(_loadBanner());
      return;
    }

    _loadGeneration++;
    _isLoading = false;
    final ad = _bannerAd;
    _bannerAd = null;
    if (mounted) {
      setState(() {
        _isAdLoaded = false;
        _visibilityChecked = true;
      });
      updateKeepAlive();
    }
    if (ad != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _disposeAd(ad));
    }
  }

  void _disposeAd(Ad ad) {
    if (_disposedAds[ad] == true) return;
    _disposedAds[ad] = true;
    unawaited(ad.dispose());
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
    _adService.adsAllowed.removeListener(_onEligibilityChanged);
    _loadGeneration++;
    final ad = _bannerAd;
    if (ad != null) _disposeAd(ad);
    super.dispose();
  }
}
