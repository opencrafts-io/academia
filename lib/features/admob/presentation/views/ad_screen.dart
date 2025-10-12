import 'package:academia/features/admob/admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdScreen extends StatelessWidget {
  const AdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdMob Demo'),
        actions: [
          BlocBuilder<AdBloc, AdState>(
            builder: (context, state) {
              return Switch(
                value: state is TestModeSetState ? state.enabled : false,
                onChanged: (value) {
                  context.read<AdBloc>().add(SetTestModeEvent(enabled: value));
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Ad Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Banner Ad',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const BannerAdWidget(
                      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
                      height: 50,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AdBloc>().add(
                          const LoadBannerAdEvent(
                            adUnitId: 'ca-app-pub-3940256099942544/6300978111',
                          ),
                        );
                      },
                      child: const Text('Load Banner Ad'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Interstitial Ad Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interstitial Ad',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AdBloc, AdState>(
                      builder: (context, state) {
                        String? interstitialAdId;
                        if (state is InterstitialAdLoadedState) {
                          interstitialAdId = state.ad.id;
                        }

                        return Column(
                          children: [
                            if (interstitialAdId != null) ...[
                              AdStatusWidget(adId: interstitialAdId),
                              const SizedBox(height: 8),
                              InterstitialAdButton(
                                adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test ID
                                adId: interstitialAdId,
                                child: const Text('Show Interstitial Ad'),
                                onAdShown: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Interstitial ad shown!'),
                                    ),
                                  );
                                },
                              ),
                            ],
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.read<AdBloc>().add(
                                  const LoadInterstitialAdEvent(
                                    adUnitId: 'ca-app-pub-3940256099942544/1033173712',
                                  ),
                                );
                              },
                              child: const Text('Load Interstitial Ad'),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Rewarded Ad Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rewarded Ad',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AdBloc, AdState>(
                      builder: (context, state) {
                        String? rewardedAdId;
                        if (state is RewardedAdLoadedState) {
                          rewardedAdId = state.ad.id;
                        }

                        return Column(
                          children: [
                            if (rewardedAdId != null) ...[
                              AdStatusWidget(adId: rewardedAdId),
                              const SizedBox(height: 8),
                              RewardedAdButton(
                                adUnitId: 'ca-app-pub-3940256099942544/5224354917', // Test ID
                                adId: rewardedAdId,
                                child: const Text('Show Rewarded Ad'),
                                onRewardEarned: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Reward earned!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                              ),
                            ],
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.read<AdBloc>().add(
                                  const LoadRewardedAdEvent(
                                    adUnitId: 'ca-app-pub-3940256099942544/5224354917',
                                  ),
                                );
                              },
                              child: const Text('Load Rewarded Ad'),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Loaded Ads Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Loaded Ads',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AdBloc, AdState>(
                      builder: (context, state) {
                        if (state is AdsLoadedState) {
                          return Column(
                            children: state.ads.map((ad) {
                              return ListTile(
                                title: Text('${ad.adType.name} Ad'),
                                subtitle: Text('ID: ${ad.id}'),
                                trailing: AdStatusWidget(adId: ad.id),
                              );
                            }).toList(),
                          );
                        }

                        return const Text('No ads loaded');
                      },
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AdBloc>().add(const LoadLoadedAdsEvent());
                      },
                      child: const Text('Refresh Loaded Ads'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
