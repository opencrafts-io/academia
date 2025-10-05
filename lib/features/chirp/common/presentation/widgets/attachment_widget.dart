import 'dart:ui';

import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/domain/entities/attachments.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:url_launcher/url_launcher.dart';

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
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Blurred background
            CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Center(child: SpinningScallopIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Theme.of(context).colorScheme.scrim.withAlpha(10),
                  ),
                ),
              ),
            ),

            // Centered original image with proper aspect ratio
            Center(
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.contain,
                placeholder: (context, url) => const SizedBox.shrink(),
                errorWidget: (context, url, error) => Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
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

class _MediaKitVideoWidgetState extends State<_MediaKitVideoWidget> {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (player.platform is NativePlayer) {
        await (player.platform as dynamic).setProperty('force-seekable', 'yes');
      }
      // player.stream.log.listen((event) {
      //   print("log $event");
      // });
    });
    player.open(
      Media(
        widget.url,
        httpHeaders: {
          'User-Agent': 'MediaKit/Flutter',
          'Accept': 'video/mp4,video/*,*/*;q=0.9',
          'Accept-Encoding': 'identity;q=1, *;q=0',
          'Range': 'bytes=0-',
        },
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Video(controller: controller),
        ),
      ),
    );
  }
}
