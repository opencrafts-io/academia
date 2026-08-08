import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_trimmer/video_trimmer.dart';

class VideoTrimmerPage extends StatefulWidget {
  const VideoTrimmerPage({super.key, required this.videoPath});
  final String videoPath;

  @override
  State<VideoTrimmerPage> createState() => _VideoTrimmerPageState();
}

class _VideoTrimmerPageState extends State<VideoTrimmerPage> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _isSaving = false;

  Future<String?> _saveVideo() async {
    final completer = Completer<String?>();
    await _trimmer.saveTrimmedVideo(
      startValue: _startValue,
      endValue: _endValue,
      outputType: OutputType.video,
      onSave: completer.complete,
    );
    return completer.future;
  }

  Future<void> _confirm() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    final outputPath = await _saveVideo();

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (outputPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Couldn't save video. Please try again."),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    context.pop(outputPath);
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: File(widget.videoPath));
  }

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    final darkScheme = ColorScheme.fromSeed(
      seedColor: Theme.of(context).colorScheme.primary,
      brightness: Brightness.dark,
    );

    return Theme(
      data: ThemeData(colorScheme: darkScheme, useMaterial3: true),
      child: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          return Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: AppBar(
              backgroundColor: colorScheme.surface,
              foregroundColor: colorScheme.onSurface,
              leading: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text("Trim video"),
              actions: [
                IconButton(
                  icon: _isSaving
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colorScheme.onSurface,
                          ),
                        )
                      : const Icon(Icons.check_rounded),
                  onPressed: _isSaving ? null : _confirm,
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_isSaving) const LinearProgressIndicator(),
                  Expanded(child: VideoViewer(trimmer: _trimmer)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: TrimViewer(
                      trimmer: _trimmer,
                      viewerHeight: 50.0,
                      viewerWidth: MediaQuery.of(context).size.width - 24,
                      // Matches Reddit's own video post length cap - generous
                      // enough that it's never the thing standing between a
                      // user and their post, but still a real ceiling.
                      maxVideoLength: const Duration(minutes: 15),
                      onChangeStart: (value) =>
                          setState(() => _startValue = value),
                      onChangeEnd: (value) =>
                          setState(() => _endValue = value),
                      onChangePlaybackState: (value) =>
                          setState(() => _isPlaying = value),
                      showDuration: true,
                      type: ViewerType.auto,
                      durationStyle: DurationStyle.FORMAT_MM_SS,
                      editorProperties: TrimEditorProperties(
                        borderPaintColor: colorScheme.primaryContainer,
                        scrubberWidth: 10,
                        scrubberPaintColor: colorScheme.primary,
                        circleSize: 12,
                        circlePaintColor: colorScheme.primary,
                        borderWidth: 4,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                    child: FilledButton.tonalIcon(
                      onPressed: () async {
                        final playing = await _trimmer.videoPlaybackControl(
                          startValue: _startValue,
                          endValue: _endValue,
                        );
                        if (!mounted) return;
                        setState(() => _isPlaying = playing);
                      },
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                      label: Text(_isPlaying ? "Pause" : "Play"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
