import 'dart:typed_data';

import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart' as gt;
import 'package:image_picker/image_picker.dart';

class AttachmentPreviewCarousel extends StatelessWidget {
  final List<XFile> attachments;
  final ValueChanged<int> onRemove;
  final ValueChanged<int> onCrop;
  final ValueChanged<String> onMessage;

  const AttachmentPreviewCarousel({
    super.key,
    required this.attachments,
    required this.onRemove,
    required this.onCrop,
    required this.onMessage,
  });

  Future<Uint8List?> _thumbnail(XFile attachment) async {
    try {
      if (attachment.path.contains('mp4')) {
        return await gt.VideoThumbnail.thumbnailData(
          video: attachment.path,
          quality: 25,
        );
      }
      return await attachment.readAsBytes();
    } catch (_) {
      return null;
    }
  }

  void _showActions(BuildContext context, int index) {
    final isVideo = attachments[index].path.endsWith('mp4');
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (sheetContext) => _AttachmentActionsSheet(
        showCrop: !isVideo,
        onCrop: () {
          Navigator.of(sheetContext).pop();
          onCrop(index);
        },
        onSaveToGallery: () async {
          Navigator.of(sheetContext).pop();
          try {
            final path = attachments[index].path;
            if (isVideo) {
              await Gal.putVideo(path, album: "Academia");
            } else {
              await Gal.putImage(path, album: "Academia");
            }
            onMessage("Saved to gallery");
          } on GalException catch (e) {
            onMessage(
              e.type == GalExceptionType.accessDenied
                  ? "Allow photo access in Settings to save to gallery"
                  : "Couldn't save to gallery. Please try again.",
            );
          }
        },
        onRemove: () {
          Navigator.of(sheetContext).pop();
          onRemove(index);
          onMessage("Item successfully removed");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CarouselView.weighted(
        enableSplash: true,
        onTap: (index) => _showActions(context, index),
        consumeMaxWeight: true,
        itemSnapping: true,
        shrinkExtent: 50,
        flexWeights: const [1, 5, 1],
        children: attachments.map((attachment) {
          return _AttachmentThumbnail(
            future: _thumbnail(attachment),
            isVideo: attachment.path.endsWith('mp4'),
          );
        }).toList(),
      ),
    );
  }
}

class _AttachmentThumbnail extends StatelessWidget {
  const _AttachmentThumbnail({required this.future, required this.isVideo});
  final Future<Uint8List?> future;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(snapshot.data!, fit: BoxFit.cover),
              ),
              if (isVideo)
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_rounded,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Icon(
              Icons.broken_image_rounded,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _AttachmentActionsSheet extends StatelessWidget {
  const _AttachmentActionsSheet({
    required this.showCrop,
    required this.onCrop,
    required this.onSaveToGallery,
    required this.onRemove,
  });
  final bool showCrop;
  final VoidCallback onCrop;
  final VoidCallback onSaveToGallery;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showCrop)
            SheetActionTile(
              icon: Icons.crop_rounded,
              label: "Crop",
              containerColor: colorScheme.secondaryContainer,
              onContainerColor: colorScheme.onSecondaryContainer,
              onTap: onCrop,
            ),
          SheetActionTile(
            icon: Icons.save_rounded,
            label: "Save to gallery",
            containerColor: colorScheme.secondaryContainer,
            onContainerColor: colorScheme.onSecondaryContainer,
            onTap: onSaveToGallery,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Divider(height: 1),
          ),
          SheetActionTile(
            icon: Icons.delete_rounded,
            label: "Remove",
            containerColor: colorScheme.errorContainer,
            onContainerColor: colorScheme.onErrorContainer,
            textColor: colorScheme.error,
            onTap: onRemove,
          ),
        ],
      ),
    );
  }
}
