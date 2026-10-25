import 'package:flutter/material.dart';

/// Attachment actions pinned under the composer, riding above the keyboard.
class ComposerToolbar extends StatelessWidget {
  final VoidCallback onTakePhoto;
  final VoidCallback onPickPhoto;
  final VoidCallback onTakeVideo;
  final VoidCallback onPickVideo;

  /// Adds a poll, or edits the attached one.
  final VoidCallback onPoll;
  final bool hasPoll;

  const ComposerToolbar({
    super.key,
    required this.onTakePhoto,
    required this.onPickPhoto,
    required this.onTakeVideo,
    required this.onPickVideo,
    required this.onPoll,
    this.hasPoll = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              IconButton(
                tooltip: 'Photo library',
                icon: const Icon(Icons.image_outlined),
                onPressed: onPickPhoto,
              ),
              IconButton(
                tooltip: 'Take photo',
                icon: const Icon(Icons.photo_camera_outlined),
                onPressed: onTakePhoto,
              ),
              IconButton(
                tooltip: 'Video library',
                icon: const Icon(Icons.video_library_outlined),
                onPressed: onPickVideo,
              ),
              IconButton(
                tooltip: 'Record video',
                icon: const Icon(Icons.videocam_outlined),
                onPressed: onTakeVideo,
              ),
              IconButton(
                tooltip: hasPoll ? 'Edit poll' : 'Add poll',
                isSelected: hasPoll,
                icon: const Icon(Icons.poll_outlined),
                selectedIcon: const Icon(Icons.poll_rounded),
                onPressed: onPoll,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
