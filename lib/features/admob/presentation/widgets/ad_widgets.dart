import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final String adUnitId;
  final double? height;
  final AdSize? adSize;

  const BannerAdWidget({
    super.key,
    required this.adUnitId,
    this.height,
    this.adSize,
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
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: widget.adUnitId,
      size: widget.adSize ?? AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
          context.read<AdBloc>().add(LoadLoadedAdsEvent());
        },
        onAdFailedToLoad: (ad, error) {
          // Log error for debugging
          debugPrint('Banner ad failed to load: $error');
        },
      ),
    );

    _bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdLoaded && _bannerAd != null) {
      return SizedBox(
        height: widget.height ?? 50,
        width: double.infinity,
        child: AdWidget(ad: _bannerAd!),
      );
    }

    return SizedBox(
      height: widget.height ?? 50,
      width: double.infinity,
      child: const Center(child: SpinningScallopIndicator()),
    );
  }
}

class InterstitialAdButton extends StatelessWidget {
  final String adUnitId;
  final String adId;
  final Widget child;
  final VoidCallback? onAdShown;

  const InterstitialAdButton({
    super.key,
    required this.adUnitId,
    required this.adId,
    required this.child,
    this.onAdShown,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdBloc, AdState>(
      listener: (context, state) {
        if (state is InterstitialAdShownState && state.adId == adId) {
          onAdShown?.call();
        }
      },
      child: ElevatedButton(
        onPressed: () {
          context.read<AdBloc>().add(ShowInterstitialAdEvent(adId: adId));
        },
        child: child,
      ),
    );
  }
}

class RewardedAdButton extends StatelessWidget {
  final String adUnitId;
  final String adId;
  final Widget child;
  final VoidCallback? onRewardEarned;

  const RewardedAdButton({
    super.key,
    required this.adUnitId,
    required this.adId,
    required this.child,
    this.onRewardEarned,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdBloc, AdState>(
      listener: (context, state) {
        if (state is RewardedAdShownState && state.adId == adId) {
          onRewardEarned?.call();
        }
      },
      child: ElevatedButton(
        onPressed: () {
          context.read<AdBloc>().add(ShowRewardedAdEvent(adId: adId));
        },
        child: child,
      ),
    );
  }
}

class AdStatusWidget extends StatelessWidget {
  final String adId;

  const AdStatusWidget({super.key, required this.adId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdBloc, AdState>(
      builder: (context, state) {
        if (state is AdsLoadedState) {
          final ad = state.ads.firstWhere(
            (ad) => ad.id == adId,
            orElse: () => const AdEntity(
              id: '',
              adUnitId: '',
              adType: AdType.banner,
              status: AdStatus.failed,
            ),
          );

          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getStatusColor(ad.status),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _getStatusText(ad.status),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Color _getStatusColor(AdStatus status) {
    switch (status) {
      case AdStatus.loading:
        return Colors.orange;
      case AdStatus.loaded:
        return Colors.green;
      case AdStatus.failed:
        return Colors.red;
      case AdStatus.shown:
        return Colors.blue;
      case AdStatus.dismissed:
        return Colors.grey;
      case AdStatus.rewarded:
        return Colors.purple;
    }
  }

  String _getStatusText(AdStatus status) {
    switch (status) {
      case AdStatus.loading:
        return 'Loading';
      case AdStatus.loaded:
        return 'Ready';
      case AdStatus.failed:
        return 'Failed';
      case AdStatus.shown:
        return 'Shown';
      case AdStatus.dismissed:
        return 'Dismissed';
      case AdStatus.rewarded:
        return 'Rewarded';
    }
  }
}
