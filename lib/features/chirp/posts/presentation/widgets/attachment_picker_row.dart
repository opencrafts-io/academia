import 'package:flutter/material.dart';

class AttachmentPickerRow extends StatelessWidget {
  final VoidCallback onTakePhoto;
  final VoidCallback onTakeVideo;
  final VoidCallback onPickPhoto;
  final VoidCallback onPickVideo;

  const AttachmentPickerRow({
    super.key,
    required this.onTakePhoto,
    required this.onTakeVideo,
    required this.onPickPhoto,
    required this.onPickVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _AttachmentAction(
          icon: Icons.photo_camera_rounded,
          label: "Take photo",
          onPressed: onTakePhoto,
        ),
        _AttachmentAction(
          icon: Icons.videocam_rounded,
          label: "Take video",
          onPressed: onTakeVideo,
        ),
        _AttachmentAction(
          icon: Icons.add_photo_alternate_rounded,
          label: "Photo gallery",
          onPressed: onPickPhoto,
        ),
        _AttachmentAction(
          icon: Icons.video_library_rounded,
          label: "Video gallery",
          onPressed: onPickVideo,
        ),
      ],
    );
  }
}

class _AttachmentAction extends StatelessWidget {
  const _AttachmentAction({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.filledTonal(onPressed: onPressed, icon: Icon(icon)),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
