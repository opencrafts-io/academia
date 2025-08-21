import 'dart:io';
import 'package:flutter/material.dart';

class EventImagePickerWidget extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onTap;
  final String label;

  const EventImagePickerWidget({
    super.key,
    required this.selectedImage,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: selectedImage == null
                    ? Theme.of(context).colorScheme.outlineVariant
                    : Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                width: 1.5,
              ),
              image: selectedImage != null
                  ? DecorationImage(
                image: FileImage(selectedImage!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: selectedImage == null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 40,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap to upload',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            )
                :
            Stack(
              children: [
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface.withValues(alpha:0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit_outlined, // Edit icon
                      size: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}