import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_trimmer/video_trimmer.dart';

class VideoTrimmerPage extends StatefulWidget {
  final File videoFile;
  const VideoTrimmerPage({super.key, required this.videoFile});

  @override
  State<VideoTrimmerPage> createState() => _VideoTrimmerPageState();
}

class _VideoTrimmerPageState extends State<VideoTrimmerPage> {
  final Trimmer _trimmer = Trimmer();
  double _start = 0.0;
  double _end = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  Future<void> _loadVideo() async {
    await _trimmer.loadVideo(videoFile: widget.videoFile);
    setState(() => _isLoading = false);
  }

  Future<void> _saveTrimmedVideo() async {
    final outputPath = await _trimmer.saveTrimmedVideo(
      startValue: _start,
      endValue: _end,
      applyVideoEncoding: true,
    );

    if (!mounted) return;
    Navigator.pop(context, File(outputPath!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trim Video"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveTrimmedVideo,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(child: VideoViewer(trimmer: _trimmer)),
                TrimEditor(
                  trimmer: _trimmer,
                  viewerHeight: 50.0,
                  viewerWidth: MediaQuery.of(context).size.width,
                  maxVideoLength: const Duration(seconds: 30),
                  onChangeStart: (value) => _start = value,
                  onChangeEnd: (value) => _end = value,
                  onChangePlaybackState: (playing) {},
                ),
              ],
            ),
    );
  }
}
