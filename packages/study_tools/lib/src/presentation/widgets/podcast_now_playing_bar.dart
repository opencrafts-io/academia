import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import '../audio/podcast_audio_handler.dart';
import '../routes/study_tools_routes.dart';

/// Compact controls backed by the same app-scoped AudioHandler used by
/// notifications, lock-screen controls and headsets.
class PodcastNowPlayingBar extends StatelessWidget {
  const PodcastNowPlayingBar({
    required this.handler,
    super.key,
    this.floating = false,
  });

  final PodcastAudioHandler handler;
  final bool floating;

  @override
  Widget build(BuildContext context) => StreamBuilder<MediaItem?>(
    stream: handler.mediaItem,
    builder: (context, itemSnapshot) {
      final item = itemSnapshot.data;
      if (item == null) return const SizedBox.shrink();
      return StreamBuilder<PlaybackState>(
        stream: handler.playbackState,
        builder: (context, playbackSnapshot) {
          final playback = playbackSnapshot.data;
          final noteId = item.extras?['noteId'] as int?;
          if (noteId == null) return const SizedBox.shrink();
          return Card.filled(
            margin: floating
                ? const EdgeInsets.symmetric(horizontal: 16)
                : EdgeInsets.zero,
            color: Theme.of(context).colorScheme.tertiaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                InkWell(
                  onTap: () => StudyPodcastPlayerRoute(
                    materialId: noteId,
                    episodeKey: item.extras?['episodeKey'] as String?,
                  ).push(context),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
                    child: Icon(
                      Icons.podcasts_rounded,
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => StudyPodcastPlayerRoute(
                      materialId: noteId,
                      episodeKey: item.extras?['episodeKey'] as String?,
                    ).push(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            item.album ?? 'Study Tools',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: playback?.playing == true
                      ? 'Pause podcast'
                      : 'Resume podcast',
                  onPressed: playback?.playing == true
                      ? handler.pause
                      : handler.play,
                  icon: Icon(
                    playback?.playing == true
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                  ),
                ),
                IconButton(
                  tooltip: 'Stop podcast',
                  onPressed: handler.stop,
                  icon: const Icon(Icons.stop_rounded),
                ),
                const SizedBox(width: 6),
              ],
            ),
          );
        },
      );
    },
  );
}
