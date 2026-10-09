import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material3_indicators/material3_indicators.dart';

import '../../data/services/podcast_local_store.dart';
import '../../domain/entities/study_entities.dart';
import '../cubit/podcast_cubit.dart';
import '../cubit/study_tools_cubit.dart';
import '../study_tools_host.dart';
import '../widgets/study_material_sections.dart';
import '../widgets/study_progress_widgets.dart';
import '../widgets/study_tools_feedback.dart';

class StudyPodcastPlayerPage extends StatefulWidget {
  const StudyPodcastPlayerPage({
    required this.materialId,
    this.episodeKey,
    super.key,
  });
  final int materialId;
  final String? episodeKey;

  @override
  State<StudyPodcastPlayerPage> createState() => _StudyPodcastPlayerPageState();
}

class _StudyPodcastPlayerPageState extends State<StudyPodcastPlayerPage> {
  @override
  void initState() {
    super.initState();
    unawaited(_loadMaterial());
    unawaited(context.read<PodcastCubit>().loadDownloads());
  }

  Future<void> _loadMaterial() async {
    final cubit = context.read<StudyToolsCubit>();
    await cubit.loadMaterial(
      widget.materialId,
      loadPodcastMetadata: widget.episodeKey == null,
    );
    if (widget.episodeKey case final key?) {
      await cubit.loadPodcastVersion(key);
    }
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
    listeners: [
      BlocListener<StudyToolsCubit, StudyToolsState>(
        listenWhen: (before, after) =>
            before.error != after.error && after.error != null,
        listener: (context, state) {
          showStudyToolsSnackBar(context, state.error!, isError: true);
        },
      ),
      BlocListener<PodcastCubit, PodcastCubitState>(
        listenWhen: (before, after) =>
            before.error != after.error && after.error != null,
        listener: (context, state) => _showPlaybackError(context, state),
      ),
    ],
    child: BlocBuilder<StudyToolsCubit, StudyToolsState>(
      builder: (context, studyState) {
        final material = studyState.selectedMaterial;
        final podcast = studyState.podcast;
        if (material == null) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                _appBar(),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: studyState.status == StudyLoadStatus.loading
                      ? const StudyToolsLoadingView(
                          message: 'Opening the episode…',
                        )
                      : StudyToolsFailureView(
                          message:
                              studyState.error ??
                              'This material is unavailable.',
                          onRetry: () => context
                              .read<StudyToolsCubit>()
                              .loadMaterial(widget.materialId),
                          onUpgrade:
                              studyState.errorCode == 'entitlement_required',
                        ),
                ),
              ],
            ),
          );
        }
        if (podcast == null) {
          final generationRunning = studyState.jobs.containsKey(material.id);
          final loadingPodcast = studyState.isLoadingPodcast;
          final readUnavailable =
              studyState.errorCode == 'podcast_read_access_unavailable' ||
              studyState.errorCode == 'network_unavailable';
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                _appBar(),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.podcasts_rounded,
                            size: 52,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            loadingPodcast
                                ? 'Checking for your episode'
                                : generationRunning
                                ? 'Your episode is being prepared'
                                : readUnavailable
                                ? 'Episode unavailable'
                                : 'No podcast yet',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loadingPodcast
                                ? 'Looking for an episode already generated for this material.'
                                : generationRunning
                                ? 'You can leave this page. Study Tools will check its progress when you return.'
                                : readUnavailable
                                ? studyState.error ??
                                      'Episode details could not be loaded.'
                                : 'Generate a podcast from this material, then return here to listen.',
                            textAlign: TextAlign.center,
                          ),
                          if (loadingPodcast) ...[
                            const SizedBox(height: 24),
                            SizedBox(
                              width: 120,
                              child: TickerMode(
                                enabled: !MediaQuery.disableAnimationsOf(
                                  context,
                                ),
                                child: WavyLinearProgressIndicator(
                                  semanticsLabel: 'Checking saved episodes',
                                ),
                              ),
                            ),
                          ] else if (studyState.isGeneratingPodcast ||
                              generationRunning) ...[
                            const SizedBox(height: 24),
                            SizedBox(
                              width: 120,
                              child: TickerMode(
                                enabled: !MediaQuery.disableAnimationsOf(
                                  context,
                                ),
                                child: WavyLinearProgressIndicator(
                                  semanticsLabel: 'Podcast generation progress',
                                ),
                              ),
                            ),
                          ] else if (readUnavailable) ...[
                            const SizedBox(height: 18),
                            OutlinedButton.icon(
                              onPressed: () =>
                                  context.read<StudyToolsCubit>().loadPodcast(),
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Retry'),
                            ),
                          ] else ...[
                            const SizedBox(height: 18),
                            FilledButton.icon(
                              onPressed: () => context
                                  .read<StudyToolsCubit>()
                                  .generatePodcast(),
                              icon: const Icon(Icons.graphic_eq_rounded),
                              label: const Text('Generate podcast'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return BlocBuilder<PodcastCubit, PodcastCubitState>(
          builder: (context, state) =>
              _player(context, material, podcast, state),
        );
      },
    ),
  );

  Widget _player(
    BuildContext context,
    StudyMaterial material,
    StudyPodcast podcast,
    PodcastCubitState state,
  ) {
    final colors = Theme.of(context).colorScheme;
    final episodeKey = PodcastLocalStore.episodeKey(podcast);
    final download = state.downloads
        .where(
          (item) =>
              item.noteId == podcast.noteId && item.episodeKey == episodeKey,
        )
        .firstOrNull;
    final mediaId =
        '${podcast.noteId}:${podcast.id ?? podcast.generatedAt.toUtc().microsecondsSinceEpoch}';
    final isCurrent = state.currentMediaItem?.id == mediaId;
    final playback = state.playbackState;
    final playing = isCurrent && (playback?.playing ?? false);
    final duration = podcast.duration > Duration.zero
        ? podcast.duration
        : (playback?.updatePosition ?? Duration.zero);
    final position = isCurrent
        ? playback?.updatePosition ?? Duration.zero
        : Duration.zero;
    final max = duration.inMilliseconds > 0
        ? duration.inMilliseconds.toDouble()
        : 1.0;
    final value = position.inMilliseconds.clamp(0, max.toInt()).toDouble();
    final title = podcast.title.trim().isNotEmpty
        ? podcast.title
        : 'A conversation about ${material.filename}';

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _appBar(),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 36),
            sliver: SliverList.list(
              children: [
                Card.filled(
                  color: colors.primaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: SizedBox.square(
                            dimension: 104,
                            child: Icon(
                              Icons.podcasts_rounded,
                              size: 48,
                              color: colors.onPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: colors.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${material.courseLabel.isEmpty ? 'Study Tools' : material.courseLabel} · ${material.filename}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: colors.onPrimaryContainer.withValues(
                                  alpha: .82,
                                ),
                              ),
                        ),
                        const SizedBox(height: 20),
                        if (isCurrent &&
                            playback?.processingState ==
                                AudioProcessingState.buffering)
                          TickerMode(
                            enabled: !MediaQuery.disableAnimationsOf(context),
                            child: const WavyLinearProgressIndicator(
                              semanticsLabel: 'Loading podcast audio',
                            ),
                          )
                        else
                          Slider(
                            value: value,
                            max: max,
                            onChanged: isCurrent && duration > Duration.zero
                                ? (next) => context
                                      .read<PodcastCubit>()
                                      .audioHandler
                                      .seek(
                                        Duration(milliseconds: next.round()),
                                      )
                                : null,
                            semanticFormatterCallback: (next) =>
                                '${_clock(Duration(milliseconds: next.round()))} of ${_clock(duration)}',
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Text(
                                _clock(position),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const Spacer(),
                              Text(
                                _clock(duration),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton.filledTonal(
                              tooltip: 'Back 10 seconds',
                              onPressed: isCurrent
                                  ? context
                                        .read<PodcastCubit>()
                                        .audioHandler
                                        .rewind
                                  : null,
                              icon: const Icon(Icons.replay_10_rounded),
                            ),
                            const SizedBox(width: 18),
                            SizedBox.square(
                              dimension: 68,
                              child: IconButton.filled(
                                tooltip: playing
                                    ? 'Pause podcast'
                                    : 'Play podcast',
                                onPressed: () {
                                  final cubit = context.read<PodcastCubit>();
                                  if (!isCurrent) {
                                    cubit.play(
                                      podcast: podcast,
                                      title: title,
                                      courseLabel: material.courseLabel,
                                    );
                                  } else if (playing) {
                                    cubit.audioHandler.pause();
                                  } else {
                                    cubit.audioHandler.play();
                                  }
                                },
                                icon: Icon(
                                  playing
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  size: 34,
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            IconButton.filledTonal(
                              tooltip: 'Forward 10 seconds',
                              onPressed: isCurrent
                                  ? context
                                        .read<PodcastCubit>()
                                        .audioHandler
                                        .fastForward
                                  : null,
                              icon: const Icon(Icons.forward_10_rounded),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        PopupMenuButton<double>(
                          tooltip: 'Playback speed',
                          initialValue: playback?.speed ?? 1,
                          onSelected: context
                              .read<PodcastCubit>()
                              .audioHandler
                              .setSpeed,
                          itemBuilder: (context) => [
                            for (final speed in [0.75, 1.0, 1.25, 1.5, 2.0])
                              PopupMenuItem(
                                value: speed,
                                child: Text('$speed×'),
                              ),
                          ],
                          child: Chip(
                            avatar: const Icon(Icons.speed_rounded, size: 18),
                            label: Text(
                              '${(playback?.speed ?? 1).toStringAsFixed(2).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '')}× speed',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    if (!context
                        .read<PodcastCubit>()
                        .store
                        .supportsPersistentDownloads)
                      Chip(
                        avatar: const Icon(Icons.info_outline_rounded),
                        label: const Text(
                          'Offline downloads aren’t supported on this device',
                        ),
                      )
                    else if (download != null)
                      FilledButton.tonalIcon(
                        onPressed: () => context.read<PodcastCubit>().play(
                          podcast: podcast,
                          title: title,
                          courseLabel: material.courseLabel,
                          offline: true,
                        ),
                        icon: const Icon(Icons.download_done_rounded),
                        label: const Text('Play offline'),
                      )
                    else
                      FilledButton.tonalIcon(
                        onPressed: state.isDownloading
                            ? null
                            : () => context.read<PodcastCubit>().download(
                                podcast: podcast,
                                title: title,
                                courseLabel: material.courseLabel,
                              ),
                        icon: const Icon(Icons.download_for_offline_outlined),
                        label: const Text('Download for offline'),
                      ),
                    if (download != null)
                      IconButton(
                        tooltip: 'Remove downloaded episode',
                        onPressed: () => context
                            .read<PodcastCubit>()
                            .removeDownload(download),
                        icon: const Icon(Icons.delete_outline_rounded),
                      ),
                    if (state.isDownloading)
                      IconButton(
                        tooltip: 'Cancel download',
                        onPressed: () => context
                            .read<PodcastCubit>()
                            .cancelDownload(podcast),
                        icon: const Icon(Icons.close_rounded),
                      ),
                  ],
                ),
                if (state.isDownloading) ...[
                  const SizedBox(height: 10),
                  if (state.totalBytes case final total? when total > 0)
                    TickerMode(
                      enabled: !MediaQuery.disableAnimationsOf(context),
                      child: WavyLinearProgressIndicator(
                        value: (state.receivedBytes ?? 0) / total,
                        semanticsLabel: 'Download progress',
                        semanticsValue:
                            '${((state.receivedBytes ?? 0) / total * 100).round()} percent',
                      ),
                    )
                  else
                    TickerMode(
                      enabled: !MediaQuery.disableAnimationsOf(context),
                      child: const WavyLinearProgressIndicator(
                        semanticsLabel: 'Saving podcast episode',
                      ),
                    ),
                  const SizedBox(height: 5),
                  Text(
                    state.totalBytes == null
                        ? 'Saving episode…'
                        : '${_size(state.receivedBytes ?? 0)} of ${_size(state.totalBytes!)}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
                const SizedBox(height: 28),
                const StudySectionHeading(
                  title: 'Episode transcript',
                  subtitle: 'Read along with the generated conversation.',
                ),
                const SizedBox(height: 12),
                _Transcript(script: podcast.script),
                const SizedBox(height: 14),
                Text(
                  'Generated ${DateFormat.yMMMd().format(podcast.generatedAt.toLocal())}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _appBar() => SliverAppBar.large(
    title: const Text('Podcast'),
    pinned: true,
    actions: [
      IconButton(
        tooltip: 'Refresh episode',
        onPressed: _loadMaterial,
        icon: const Icon(Icons.refresh_rounded),
      ),
      const SizedBox(width: 8),
    ],
  );

  void _showPlaybackError(BuildContext context, PodcastCubitState state) {
    final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    final requiresUpgrade =
        state.accessIssue == PodcastAccessIssue.subscriptionRequired;
    final verificationUnavailable =
        state.accessIssue == PodcastAccessIssue.verificationUnavailable;
    final study = context.read<StudyToolsCubit>().state;
    final material = study.selectedMaterial;
    final podcast = study.podcast;
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        content: Text(state.error!),
        action: requiresUpgrade
            ? SnackBarAction(
                label: 'View plans',
                onPressed: () => StudyToolsHost.openPaywall?.call(context),
              )
            : verificationUnavailable && material != null && podcast != null
            ? SnackBarAction(
                label: 'Retry',
                onPressed: () => context.read<PodcastCubit>().download(
                  podcast: podcast,
                  title: podcast.title.trim().isNotEmpty
                      ? podcast.title
                      : 'A conversation about ${material.filename}',
                  courseLabel: material.courseLabel,
                ),
              )
            : null,
      ),
    );
  }

  static String _clock(Duration value) =>
      '${value.inMinutes}:${value.inSeconds.remainder(60).toString().padLeft(2, '0')}';

  static String _size(int value) => value >= 1024 * 1024
      ? '${(value / (1024 * 1024)).toStringAsFixed(1)} MB'
      : '${(value / 1024).ceil()} KB';
}

class _Transcript extends StatelessWidget {
  const _Transcript({required this.script});
  final String script;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final turns = script
        .split(RegExp(r'\n\s*\n|\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .map((line) {
          final separator = line.indexOf(':');
          if (separator > 0 && separator < 32) {
            return (
              speaker: line.substring(0, separator).trim(),
              text: line.substring(separator + 1).trim(),
            );
          }
          return (speaker: 'Narration', text: line);
        })
        .toList(growable: false);
    return Card.filled(
      color: colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (index, turn) in turns.indexed) ...[
              if (index > 0) const Divider(height: 24),
              Chip(
                avatar: const Icon(Icons.record_voice_over_outlined, size: 17),
                label: Text(turn.speaker),
                visualDensity: VisualDensity.compact,
              ),
              const SizedBox(height: 5),
              SelectableText(
                turn.text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
