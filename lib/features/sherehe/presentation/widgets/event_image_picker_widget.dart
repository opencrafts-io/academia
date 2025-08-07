import 'dart:io';
import 'package:flutter/material.dart';

class EventImagePickerWidget extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onTap;

  const EventImagePickerWidget({
    super.key,
    required this.selectedImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha:0.1),
          borderRadius: BorderRadius.circular(12.0),
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
                      Icons.add_a_photo_outlined,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary.withValues(alpha:0.7),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tap to upload event image',
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
