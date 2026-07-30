import 'package:academia/features/chirp/posts/domain/entities/attachments.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chewie/chewie.dart';

class AttachmentWidget extends StatelessWidget {
  final Attachments attachment;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? backgroundColor;
  final BorderRadius borderRadius;

  const AttachmentWidget({
    super.key,
    required this.attachment,
    this.width = 80,
    this.height = 80,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (attachment.attachmentType.trim().toLowerCase()) {
      case 'image':
        child = _ImagePreview(
          url: attachment.file,
          fit: fit,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
        );
        break;
      case 'video':
        child = _VideoPreview(
          url: attachment.file,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
        );
        break;
      case 'file':
        child = _FilePreview(
          url: attachment.file,
          fileName: attachment.name,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
        );
        break;
      default:
        child = const SizedBox.shrink();
    }
    return SizedBox(width: width, height: height, child: child);
  }
}

// --- Fullscreen Viewers ---

class FullScreenImageViewer extends StatelessWidget {
  final String url;
  const FullScreenImageViewer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image, color: Colors.white, size: 50),
          ),
        ),
      ),
    );
  }
}

class FullScreenVideoViewer extends StatefulWidget {
  final String url;
  const FullScreenVideoViewer({super.key, required this.url});

  @override
  State<FullScreenVideoViewer> createState() => _FullScreenVideoViewerState();
}

class _FullScreenVideoViewerState extends State<FullScreenVideoViewer> {
  late CachedVideoPlayerPlus _cachedPlayer;
  ChewieController? _chewieController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Shares the same on-disk cache as the muted inline feed preview - if
    // the user already watched the preview while scrolling, opening
    // fullscreen reuses that download instead of fetching it again.
    _cachedPlayer = CachedVideoPlayerPlus.networkUrl(Uri.parse(widget.url));
    _cachedPlayer.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _chewieController = ChewieController(
          videoPlayerController: _cachedPlayer.controller,
          autoPlay: true,
          looping: false,
          showControls: true,
          allowFullScreen: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: Theme.of(context).colorScheme.primary,
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _cachedPlayer.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: _isLoading || _chewieController == null
            ? const CircularProgressIndicator()
            : Chewie(controller: _chewieController!),
      ),
    );
  }
}

// --- Preview Widgets ---

abstract class _PreviewWidget extends StatelessWidget {
  const _PreviewWidget({this.backgroundColor, required this.borderRadius});

  final Color? backgroundColor;
  final BorderRadius borderRadius;

  Widget buildPreview(BuildContext context);
  void onPreviewTap(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPreviewTap(context),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: borderRadius,
          // A custom background (e.g. black, for full-bleed feed media) reads
          // as an intentional frame on its own - the default surface tint
          // needs the outline border to read as a bounded preview box.
          border: backgroundColor == null
              ? Border.all(
                  width: 1.0,
                  color: Theme.of(context).colorScheme.outlineVariant,
                )
              : null,
        ),
        child: buildPreview(context),
      ),
    );
  }
}

class _ImagePreview extends _PreviewWidget {
  final String url;
  final BoxFit fit;
  const _ImagePreview({
    required this.url,
    this.fit = BoxFit.cover,
    super.backgroundColor,
    required super.borderRadius,
  });

  @override
  void onPreviewTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FullScreenImageViewer(url: url)),
    );
  }

  @override
  Widget buildPreview(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: (context, url) => const SizedBox.shrink(),
      errorWidget: (context, url, error) => Icon(
        Icons.broken_image,
        size: 40,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
    );
  }
}

class _VideoPreview extends _PreviewWidget {
  final String url;
  const _VideoPreview({
    required this.url,
    super.backgroundColor,
    required super.borderRadius,
  });

  @override
  void onPreviewTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FullScreenVideoViewer(url: url)),
    );
  }

  @override
  Widget buildPreview(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // In a real app, we'd use a thumbnail generator.
        // For now, a static icon is sufficient.
        Icon(
          Icons.videocam,
          size: 40,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        Center(
          child: Icon(
            Icons.play_circle_outline,
            size: 32,
            color: Colors.white.withAlpha((0.8 * 255).round()),
          ),
        ),
      ],
    );
  }
}

class _FilePreview extends _PreviewWidget {
  final String url;
  final String fileName;
  const _FilePreview({
    required this.url,
    required this.fileName,
    super.backgroundColor,
    required super.borderRadius,
  });

  @override
  Future<void> onPreviewTap(BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Could not open file.")));
    }
  }

  @override
  Widget buildPreview(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.insert_drive_file,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            fileName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
