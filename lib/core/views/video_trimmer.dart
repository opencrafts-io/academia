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
  bool _progressVisibility = false;

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String? savedPath;

    await _trimmer.saveTrimmedVideo(
      startValue: _startValue,
      endValue: _endValue,
      onSave: (val) {
        savedPath = val;
      },
      outputType: OutputType.video,
    );
    setState(() {
      _progressVisibility = false;
    });

    return savedPath;
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
    return Scaffold(
      appBar: AppBar(title: Text("Video Trimmer")),
      body: Builder(
        builder: (context) => Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
            // color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Visibility(
                  visible: _progressVisibility,
                  child: LinearProgressIndicator(),
                ),
                Expanded(child: VideoViewer(trimmer: _trimmer)),

                Center(
                  child: TrimViewer(
                    trimmer: _trimmer,
                    viewerHeight: 50.0,
                    viewerWidth: MediaQuery.of(context).size.width,
                    maxVideoLength: const Duration(seconds: 90),
                    onChangeStart: (value) =>
                        setState(() => _startValue = value),
                    onChangeEnd: (value) => setState(() => _endValue = value),
                    onChangePlaybackState: (value) =>
                        setState(() => _isPlaying = value),
                    showDuration: true,
                    type: ViewerType.auto,
                    durationStyle: DurationStyle.FORMAT_MM_SS,
                    editorProperties: TrimEditorProperties(
                      borderPaintColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      scrubberWidth: 10,
                      scrubberPaintColor: Theme.of(context).colorScheme.primary,
                      circleSize: 12,
                      circlePaintColor: Theme.of(context).colorScheme.primary,
                      borderWidth: 4,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 2,
                        ),
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.all(32),
                          ),
                          label: Text("${_isPlaying ? 'Pause' : 'Play'} video"),
                          icon: _isPlaying
                              ? Icon(Icons.pause)
                              : Icon(Icons.play_arrow),
                          onPressed: () async {
                            bool playbackState = await _trimmer
                                .videoPlaybackControl(
                                  startValue: _startValue,
                                  endValue: _endValue,
                                );
                            setState(() {
                              _isPlaying = playbackState;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 2,
                      ),
                      child: IconButton.filled(
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.all(32),
                        ),
                        // label: Text("Save"),
                        icon: Icon(Icons.check),
                        onPressed: () async {
                          if (_progressVisibility) return;
                          late SnackBar snackbar;
                          final outputPath = await _saveVideo();
                          if (outputPath == null) {
                            snackbar = SnackBar(
                              content: Text(
                                'Failed to save video, check your storage',
                              ),
                              behavior: SnackBarBehavior.floating,
                            );
                          } else {
                            snackbar = SnackBar(
                              content: Text('Video Saved successfully'),
                              behavior: SnackBarBehavior.floating,
                            );
                          }
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          context.pop(outputPath);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
