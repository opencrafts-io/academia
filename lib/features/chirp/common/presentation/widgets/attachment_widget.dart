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
    switch (attachment.attachmentType) {
      case 'image':
        return _ImageWidget(url: attachment.file);
      case 'video':
        return _MediaKitVideoWidget(url: attachment.file);
      case 'file':
        return _FileWidget(url: attachment.file, fileName: attachment.name);
      default:
        return const SizedBox.shrink();
    }
  }
}

class _ImageWidget extends StatelessWidget {
  final String url;
  const _ImageWidget({required this.url});

  void _openFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: InteractiveViewer(
                child: CachedNetworkImage(imageUrl: url),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openFullScreen(context),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1.5,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox.shrink(),
          errorWidget: (context, url, error) => Icon(
            Icons.broken_image,
            size: 50,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class _FileWidget extends StatelessWidget {
  final String url;
  final String fileName;
  const _FileWidget({required this.url, required this.fileName});

  Future<void> _openFile() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          leading: Icon(
            Icons.insert_drive_file,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(fileName, overflow: TextOverflow.ellipsis),
          trailing: IconButton(
            icon: const Icon(Icons.download),
            onPressed: _openFile,
          ),
        ),
      ),
    );
  }
}

class _MediaKitVideoWidget extends StatefulWidget {
  final String url;
  const _MediaKitVideoWidget({required this.url});

  @override
  State<_MediaKitVideoWidget> createState() => _MediaKitVideoWidgetState();
}

class _MediaKitVideoWidgetState extends State<_MediaKitVideoWidget>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController videoPlayerController =
      VideoPlayerController.networkUrl(Uri.parse(widget.url));
  late ChewieController chewieController = ChewieController(
    videoPlayerController: videoPlayerController,
    autoPlay: true,
    looping: false,
    playbackSpeeds: [0.25, 0.5, 1.0, 1.5, 2.0],
    showControls: true,
    allowFullScreen: true,
    aspectRatio: videoPlayerController.value.aspectRatio,
    materialProgressColors: ChewieProgressColors(
      playedColor: Theme.of(context).colorScheme.primary,
    ),
  );

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: 600,
      color: Colors.black,
      child: GestureDetector(
        onTap: () async {},
        child: Chewie(controller: chewieController),
      ),
    );
  }
}
