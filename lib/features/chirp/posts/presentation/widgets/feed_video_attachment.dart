import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/features/settings/presentation/cubit/settings_state.dart';
import 'package:academia/features/settings/settings.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart' as gt;
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// X.com/Reddit-style feed video: full card width, sized to the video's own
/// aspect ratio, autoplays muted once enough of it scrolls into view, pauses
/// once it scrolls back out. The player itself is only created the moment
/// this attachment first becomes even partially visible - never eagerly for
/// items still off-screen - and reuses [CachedVideoPlayerPlus]'s on-disk
/// cache, so scrolling a video out of view and back doesn't re-download it.
class FeedVideoAttachment extends StatefulWidget {
  const FeedVideoAttachment({
    super.key,
    required this.url,
    required this.attachmentId,
    this.onAspectRatioResolved,
  });

  final String url;
  final int attachmentId;

  /// Reported once the video's (clamped) aspect ratio is known, so an
  /// enclosing carousel can animate its frame to match.
  final ValueChanged<double>? onAspectRatioResolved;

  @override
  State<FeedVideoAttachment> createState() => _FeedVideoAttachmentState();
}

class _FeedVideoAttachmentState extends State<FeedVideoAttachment> {
  // Mirrors X.com's own clamp range so a single very tall or very wide video
  // can't take over the feed.
  static const double _minAspectRatio = 4 / 5;
  static const double _maxAspectRatio = 16 / 9;
  static const double _playThreshold = 0.6;

  CachedVideoPlayerPlus? _player;
  Uint8List? _thumbnail;
  double? _aspectRatio;
  bool _isInitializing = false;
  bool _isPlaying = false;
  bool _hasStartedLoading = false;
  double _lastVisibleFraction = 0;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    try {
      final bytes = await gt.VideoThumbnail.thumbnailData(
        video: widget.url,
        quality: 40,
      );
      if (!mounted) return;

      if (_aspectRatio == null) {
        final codec = await ui.instantiateImageCodec(bytes);
        final frame = await codec.getNextFrame();
        final ratio = (frame.image.width / frame.image.height).clamp(
          _minAspectRatio,
          _maxAspectRatio,
        );
        if (!mounted) return;
        setState(() => _aspectRatio = ratio);
        widget.onAspectRatioResolved?.call(ratio);
      }
      setState(() => _thumbnail = bytes);
    } catch (_) {
      // Falls back to the plain loading indicator - not fatal, playback
      // still works once the visibility threshold triggers initialization.
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    _lastVisibleFraction = info.visibleFraction;

    if (!_hasStartedLoading && info.visibleFraction > 0) {
      _hasStartedLoading = true;
      _initializePlayer();
      return;
    }

    final player = _player;
    if (player == null || !player.isInitialized) return;

    if (info.visibleFraction >= _playThreshold && !_isPlaying) {
      _play();
    } else if (info.visibleFraction < _playThreshold && _isPlaying) {
      _pause();
    }
  }

  Future<void> _initializePlayer() async {
    if (_isInitializing || _player != null) return;
    _isInitializing = true;

    final player = CachedVideoPlayerPlus.networkUrl(Uri.parse(widget.url));
    await player.initialize();
    if (!mounted) {
      player.dispose();
      return;
    }

    await player.controller.setLooping(true);

    final ratio = player.controller.value.aspectRatio.clamp(
      _minAspectRatio,
      _maxAspectRatio,
    );

    setState(() {
      _player = player;
      _aspectRatio = ratio;
    });
    widget.onAspectRatioResolved?.call(ratio);

    if (!mounted) return;
    final muted = context.read<SettingsCubit>().state.chirpMuteVideos;
    await player.controller.setVolume(muted ? 0 : 1);

    if (_lastVisibleFraction >= _playThreshold) {
      _play();
    }
  }

  void _play() {
    _player?.controller.play();
    if (mounted) setState(() => _isPlaying = true);
  }

  void _pause() {
    _player?.controller.pause();
    if (mounted) setState(() => _isPlaying = false);
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final muted = context.select<SettingsCubit, bool>(
      (cubit) => cubit.state.chirpMuteVideos,
    );

    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (previous, current) =>
          previous.chirpMuteVideos != current.chirpMuteVideos,
      listener: (context, state) {
        _player?.controller.setVolume(state.chirpMuteVideos ? 0 : 1);
      },
      child: VisibilityDetector(
        key: ValueKey('feed_video_${widget.attachmentId}'),
        onVisibilityChanged: _onVisibilityChanged,
        child: GestureDetector(
          onTap: () {
            // Two players decoding the same video at once (this inline
            // preview and the fullscreen viewer's own player) fight over
            // the platform's video decoder, causing the fullscreen video to
            // stutter/restart briefly - pausing here leaves only one active.
            // The preview resumes on its own via the next VisibilityDetector
            // callback once the fullscreen route is popped, if still
            // sufficiently visible.
            _pause();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullScreenVideoViewer(url: widget.url),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _aspectRatio ?? _minAspectRatio,
                    child: _buildFrame(),
                  ),
                ),
                if (!_isPlaying)
                  const Icon(
                    Icons.play_circle_fill_rounded,
                    size: 56,
                    color: Colors.white70,
                  ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: _MuteButton(
                    muted: muted,
                    onTap: () =>
                        context.read<SettingsCubit>().toggleChirpMuteVideos(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrame() {
    final player = _player;
    if (player != null && player.isInitialized) {
      return VideoPlayer(player.controller);
    }
    if (_thumbnail != null) {
      return Image.memory(_thumbnail!, fit: BoxFit.contain);
    }
    return const Center(child: LoadingIndicatorM3E(color: Colors.white70));
  }
}

class _MuteButton extends StatelessWidget {
  const _MuteButton({required this.muted, required this.onTap});

  final bool muted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        foregroundColor: Colors.white,
      ),
      onPressed: onTap,
      icon: Icon(muted ? Icons.volume_off_rounded : Icons.volume_up_rounded),
    );
  }
}
