import 'package:flutter/material.dart';
import 'package:material3_indicators/material3_indicators.dart';

import '../../domain/entities/study_entities.dart';
import '../routes/study_tools_routes.dart';
import 'study_material_sections.dart';

class StudyPodcastSection extends StatelessWidget {
  const StudyPodcastSection({
    required this.material,
    required this.podcast,
    required this.isGenerating,
    required this.isLoading,
    required this.hasJob,
    required this.progressMessage,
    required this.onGenerate,
    super.key,
  });

  final StudyMaterial material;
  final StudyPodcast? podcast;
  final bool isGenerating;
  final bool isLoading;
  final bool hasJob;
  final String progressMessage;
  final VoidCallback onGenerate;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final busy = isGenerating || isLoading || hasJob;
    final title = podcast?.title.trim().isNotEmpty == true
        ? podcast!.title
        : 'A conversation about ${material.filename}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StudySectionHeading(
          title: 'Study podcast',
          subtitle: 'Listen to a guided conversation based on this material.',
        ),
        const SizedBox(height: 14),
        Card.filled(
          color: colors.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.podcasts_rounded,
                      color: colors.onSecondaryContainer,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            podcast == null
                                ? 'Turn this material into audio'
                                : title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: colors.onSecondaryContainer,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            podcast == null
                                ? 'Your generated episode will stay with this material.'
                                : '${material.courseLabel.isEmpty ? 'Study Tools' : material.courseLabel} · ${_duration(podcast!.duration)} · Ready to listen',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: colors.onSecondaryContainer.withValues(
                                    alpha: .8,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (podcast != null)
                      Icon(
                        Icons.headphones_rounded,
                        color: colors.onSecondaryContainer,
                      ),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  child: busy
                      ? Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TickerMode(
                                enabled: !MediaQuery.disableAnimationsOf(
                                  context,
                                ),
                                child: const WavyLinearProgressIndicator(
                                  semanticsLabel: 'Generating podcast',
                                ),
                              ),
                              const SizedBox(height: 9),
                              Text(
                                progressMessage,
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(
                                      color: colors.onSecondaryContainer,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    if (podcast != null)
                      FilledButton.icon(
                        onPressed: () =>
                            StudyPodcastPlayerRoute(materialId: material.id)
                                .push(context),
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('Open episode'),
                      ),
                    if (podcast == null)
                      FilledButton.icon(
                        onPressed: busy ? null : onGenerate,
                        icon: const Icon(Icons.graphic_eq_rounded),
                        label: const Text('Generate podcast'),
                      )
                    else
                      OutlinedButton.icon(
                        onPressed: busy ? null : onGenerate,
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Make a new version'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.onSecondaryContainer,
                          side: BorderSide(
                            color: colors.onSecondaryContainer.withValues(
                              alpha: .32,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static String _duration(Duration value) {
    final minutes = value.inMinutes;
    final seconds = value.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
