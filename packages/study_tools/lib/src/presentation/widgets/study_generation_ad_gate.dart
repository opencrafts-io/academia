import 'package:ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/study_tools_cubit.dart';
import 'study_tools_feedback.dart';

Future<void> requestStudyGeneration({
  required BuildContext context,
  required String contentLabel,
  required int pointCost,
  required Future<void> Function() generate,
}) async {
  final cubit = context.read<StudyToolsCubit>();
  while (context.mounted) {
    final requirement = await cubit.generationAdRequirement();
    if (!context.mounted) return;

    switch (requirement) {
      case RewardedGenerationRequirement.notRequired:
        await generate();
        return;
      case RewardedGenerationRequirement.unavailable:
        showStudyToolsSnackBar(
          context,
          'Rewarded ads are unavailable right now. Please try again later.',
          isError: true,
        );
        return;
      case RewardedGenerationRequirement.required:
        final currentPoints = cubit.generationPoints;
        if (currentPoints >= pointCost) {
          await generate();
          return;
        }

        final shouldWatch = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            icon: const Icon(Icons.ondemand_video_outlined),
            title: const Text('Earn generation points'),
            content: Text(
              'Each rewarded ad earns '
              '${AdService.generationPointsPerRewardedAd} points. '
              '$contentLabel costs $pointCost points, and you have '
              '$currentPoints. Complete this ad to earn '
              '${AdService.generationPointsPerRewardedAd} points. '
              'You will be asked before each ad.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Not now'),
              ),
              FilledButton.icon(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Watch one ad'),
              ),
            ],
          ),
        );
        if (!context.mounted || shouldWatch != true) return;

        final earned = await cubit.watchGenerationAd();
        if (!context.mounted) return;
        if (!earned) return;
        showStudyToolsSnackBar(
          context,
          '${AdService.generationPointsPerRewardedAd} points earned. '
          '${cubit.generationPoints} available.',
        );
    }
  }
}
