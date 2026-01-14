import 'dart:io';

import 'package:academia/features/sherehe/presentation/widgets/event_image_picker_widget.dart';
import 'package:flutter/material.dart';

class ImageUploadPage extends StatelessWidget {
  final File? selectedCardImage;
  final VoidCallback onPickCardImage;
  final File? selectedBannerImage;
  final VoidCallback onPickBannerImage;
  final File? selectedPosterImage;
  final VoidCallback onPickPosterImage;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final BuildContext context;
  final ScrollController controller;

  const ImageUploadPage({
    super.key,
    required this.selectedCardImage,
    required this.onPickCardImage,
    required this.selectedBannerImage,
    required this.onPickBannerImage,
    required this.selectedPosterImage,
    required this.onPickPosterImage,
    required this.onPrevious,
    required this.onNext,
    required this.context,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Event Images",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 32),
          EventImagePickerWidget(
            selectedImage: selectedCardImage,
            onTap: onPickCardImage,
            label: 'Card Image (1:1) *',
            height: 350,
          ),
          const SizedBox(height: 20),
          EventImagePickerWidget(
            selectedImage: selectedBannerImage,
            onTap: onPickBannerImage,
            label: 'Banner Image (16:9) *',
          ),
          const SizedBox(height: 20),
          EventImagePickerWidget(
            selectedImage: selectedPosterImage,
            onTap: onPickPosterImage,
            label: 'Poster Image *',
            height: 500,
          ),
          const SizedBox(height: 40),
          if (selectedCardImage == null ||
              selectedBannerImage == null ||
              selectedPosterImage == null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Please note that for any image not uploaded, a default color palette will be used instead.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onPrevious,
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton.icon(
                  onPressed: onNext,
                  label: const Text('Next'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
