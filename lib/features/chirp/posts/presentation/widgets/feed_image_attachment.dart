import 'package:academia/features/chirp/chirp.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

/// X.com/Reddit-style feed image: full card width, sized to the image's own
/// aspect ratio (clamped so one extreme image can't dominate the feed),
/// letterboxed on black wherever the clamp and the image's true ratio don't
/// exactly match.
///
/// Renders through the same [CachedNetworkImage] widget as
/// [FullScreenImageViewer] (rather than a hand-rolled [ImageStream]
/// listener resolving its own [CachedNetworkImageProvider]) so both places
/// resolve to the exact same cache entry - two independently-configured
/// providers for the same URL raced during the fullscreen navigation
/// transition and could leave both showing a broken image.
class FeedImageAttachment extends StatefulWidget {
  const FeedImageAttachment({
    super.key,
    required this.url,
    this.onAspectRatioResolved,
  });

  final String url;

  /// Reported once the image's natural (clamped) aspect ratio is known, so
  /// an enclosing carousel can animate its frame to match.
  final ValueChanged<double>? onAspectRatioResolved;

  @override
  State<FeedImageAttachment> createState() => _FeedImageAttachmentState();
}

class _FeedImageAttachmentState extends State<FeedImageAttachment> {
  // Mirrors X.com's own clamp range so a single very tall or very wide image
  // can't take over the feed.
  static const double _minAspectRatio = 4 / 5;
  static const double _maxAspectRatio = 16 / 9;

  bool _reportedRatio = false;
  int _retryAttempt = 0;

  /// Evicts the (possibly corrupted, e.g. from a partial/interrupted past
  /// download) cache entry and retries once automatically. Only retries a
  /// single time so a genuinely broken/missing remote file still settles on
  /// the error state instead of looping.
  void _handleError(String url) {
    if (_retryAttempt != 0) return;
    CachedNetworkImage.evictFromCache(url);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _retryAttempt = 1);
    });
  }

  void _retryManually() {
    CachedNetworkImage.evictFromCache(widget.url);
    setState(() => _retryAttempt++);
  }

  /// Reads the natural size off the already-decoded [provider]. When the
  /// image is already sitting in Flutter's in-memory [ImageCache] (e.g. the
  /// user scrolled past it and back), [ImageStreamListener] replays it to a
  /// new listener *synchronously*, inline, while this very `imageBuilder`
  /// call is still on the stack - so [synchronousCall] is true and calling
  /// [onAspectRatioResolved] (which calls setState up in the enclosing
  /// carousel) here would be a setState-during-build. cached_network_image
  /// then catches that thrown FlutterError and mistakes it for a load
  /// failure, permanently wedging the image into its broken/retry state
  /// even though it decoded fine. Deferring to a post-frame callback only in
  /// the synchronous case keeps the prompt update for the normal (async,
  /// first-decode) path while avoiding the crash on cache replay.
  void _reportAspectRatio(ImageProvider provider) {
    if (_reportedRatio) return;
    _reportedRatio = true;
    final stream = provider.resolve(const ImageConfiguration());
    late final ImageStreamListener listener;
    listener = ImageStreamListener((info, synchronousCall) {
      final ratio = (info.image.width / info.image.height).clamp(
        _minAspectRatio,
        _maxAspectRatio,
      );
      stream.removeListener(listener);
      if (synchronousCall) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) widget.onAspectRatioResolved?.call(ratio);
        });
      } else {
        widget.onAspectRatioResolved?.call(ratio);
      }
    }, onError: (error, stackTrace) => stream.removeListener(listener));
    stream.addListener(listener);
  }

  @override
  void didUpdateWidget(covariant FeedImageAttachment oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.url != oldWidget.url) {
      _reportedRatio = false;
      _retryAttempt = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FullScreenImageViewer(url: widget.url),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: CachedNetworkImage(
          key: ValueKey('${widget.url}_$_retryAttempt'),
          imageUrl: widget.url,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              const Center(child: LoadingIndicatorM3E(color: Colors.white70)),
          errorWidget: (context, url, error) {
            _handleError(url);
            return GestureDetector(
              onTap: _retryManually,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.broken_image_rounded,
                    color: Colors.white54,
                    size: 40,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to retry',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            );
          },
          imageBuilder: (context, imageProvider) {
            _reportAspectRatio(imageProvider);
            return Image(image: imageProvider, fit: BoxFit.contain);
          },
        ),
      ),
    );
  }
}
