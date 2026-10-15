import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/study_entities.dart';
import '../routes/study_tools_routes.dart';

class PodcastDownloadCard extends StatelessWidget {
  const PodcastDownloadCard({
    required this.episode,
    required this.onRemove,
    super.key,
  });

  final PodcastDownloadedEpisode episode;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card.filled(
      color: colors.tertiaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => StudyPodcastPlayerRoute(
          materialId: episode.noteId,
          episodeKey: episode.episodeKey,
        ).push(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: SizedBox.square(
                      dimension: 48,
                      child: Icon(
                        Icons.podcasts_rounded,
                        color: colors.onPrimary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Remove downloaded episode',
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                episode.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                episode.courseLabel.isEmpty
                    ? 'Study Tools'
                    : episode.courseLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.download_done_rounded, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Saved offline',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Spacer(),
                  Text(
                    _size(episode.sizeBytes),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              if (episode.downloadedAt != null) ...[
                const SizedBox(height: 6),
                Text(
                  DateFormat.MMMd().format(episode.downloadedAt!.toLocal()),
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _size(int bytes) => bytes >= 1024 * 1024
      ? '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB'
      : '${(bytes / 1024).ceil()} KB';
}
