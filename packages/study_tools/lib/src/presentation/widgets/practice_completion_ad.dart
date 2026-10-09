import 'package:ads/ads.dart';
import 'package:get_it/get_it.dart';

Future<void> showPracticeInterstitialAd() async {
  final services = GetIt.I;
  if (!services.isRegistered<AdService>()) return;

  try {
    await services<AdService>().showInterstitialAd();
  } on Object {
    // Ad failures should never prevent the learner from completing the set.
  }
}
