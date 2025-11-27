import 'package:academia/features/chirp/posts/domain/entities/attachments.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class AttachmentWidget extends StatelessWidget {
  final Attachments attachment;

  const AttachmentWidget({super.key, required this.attachment});

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (attachment.attachmentType) {
      case 'image':
        child = _ImagePreview(url: attachment.file);
        break;
      case 'video':
        child = _VideoPreview(url: attachment.file);
        break;
      case 'file':
        child = _FilePreview(url: attachment.file, fileName: attachment.name);
        break;
      default:
        child = const SizedBox.shrink();
    }
    return SizedBox(
      width: 80,
      height: 80,
      child: child,
    );
  }
}

// --- Fullscreen Viewers ---

class _FullScreenImageViewer extends StatelessWidget {
  final String url;
  const _FullScreenImageViewer({required this.url});

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

class _FullScreenVideoViewer extends StatefulWidget {
  final String url;
  const _FullScreenVideoViewer({required this.url});

  @override
  State<_FullScreenVideoViewer> createState() => _FullScreenVideoViewerState();
}

class _FullScreenVideoViewerState extends State<_FullScreenVideoViewer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      showControls: true,
      allowFullScreen: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Theme.of(context).colorScheme.primary,
      ),
    );
    _videoPlayerController.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
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
        child: _isLoading
            ? const CircularProgressIndicator()
            : Chewie(controller: _chewieController),
      ),
    );
  }
}


// --- Preview Widgets ---

abstract class _PreviewWidget extends StatelessWidget {
  const _PreviewWidget({super.key});

  Widget buildPreview(BuildContext context);
  void onPreviewTap(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPreviewTap(context),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1.0,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: buildPreview(context),
      ),
    );
  }
}

class _ImagePreview extends _PreviewWidget {
  final String url;
  const _ImagePreview({required this.url});

  @override
  void onPreviewTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _FullScreenImageViewer(url: url)),
    );
  }

  @override
  Widget buildPreview(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => const SizedBox.shrink(),
      errorWidget: (context, url, error) => Icon(
        Icons.broken_image,
        size: 40,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}


class _VideoPreview extends _PreviewWidget {
  final String url;
  const _VideoPreview({required this.url});

  @override
  void onPreviewTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _FullScreenVideoViewer(url: url)),
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
            color: Colors.white.withOpacity(0.8),
          ),
        )
      ],
    );
  }
}

class _FilePreview extends _PreviewWidget {
  final String url;
  final String fileName;
  const _FilePreview({required this.url, required this.fileName});

  @override
  Future<void> onPreviewTap(BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not open file."),
        ),
      );
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
