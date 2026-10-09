import 'dart:ui' show ImageFilter;

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import '../audio/podcast_audio_handler.dart';
import '../routes/study_tools_routes.dart';

/// Floats the mini player over page content without adding a full-width footer.
class PodcastNowPlayingOverlay extends StatelessWidget {
  const PodcastNowPlayingOverlay({
    required this.child,
    required this.handler,
    this.bottomInset = 0,
    super.key,
  });

  final Widget child;
  final PodcastAudioHandler? handler;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final audioHandler = handler;
    if (audioHandler == null || MediaQuery.viewInsetsOf(context).bottom > 0) {
      return child;
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomInset,
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: PodcastNowPlayingBar(
                handler: audioHandler,
                floating: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
          final colorScheme = Theme.of(context).colorScheme;
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return Card.filled(
            margin: floating
                ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                : EdgeInsets.zero,
            color: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.black.withValues(alpha: isDark ? 0.32 : 0.16),
            elevation: floating ? 6 : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.55),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.surface.withValues(
                    alpha: isDark ? 0.74 : 0.68,
                  ),
                ),
                child: _controls(context, item, playback, noteId, colorScheme),
              ),
            ),
          );
        },
      );
    },
  );

  Widget _controls(
    BuildContext context,
    MediaItem item,
    PlaybackState? playback,
    int noteId,
    ColorScheme colorScheme,
  ) => Row(
    children: [
      InkWell(
        onTap: () => StudyPodcastPlayerRoute(
          materialId: noteId,
          episodeKey: item.extras?['episodeKey'] as String?,
        ).push(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
          child: Icon(Icons.podcasts_rounded, color: colorScheme.onSurface),
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
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  item.album ?? 'Study Tools',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
      ),
      IconButton(
        tooltip: playback?.playing == true ? 'Pause podcast' : 'Resume podcast',
        onPressed: playback?.playing == true ? handler.pause : handler.play,
        icon: Icon(
          playback?.playing == true
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded,
          color: colorScheme.onSurface,
        ),
      ),
      IconButton(
        tooltip: 'Stop podcast',
        onPressed: handler.stop,
        icon: Icon(Icons.stop_rounded, color: colorScheme.onSurface),
      ),
      const SizedBox(width: 6),
    ],
  );
}
