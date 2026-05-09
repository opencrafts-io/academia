import 'dart:io';
import 'package:academia/features/sherehe/presentation/presentation.dart';
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
          const SizedBox(height: 8),

          Text(
            "Upload images to make your event more engaging. Each image is used in different parts of the app.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          EventImagePickerWidget(
            selectedImage: selectedCardImage,
            onTap: onPickCardImage,
            label: 'Card Image (1:1)',
            height: 350,
          ),
          EventImageHelperTextWidget(
            text:
                "Used in event listings and when sharing on the event on Chirp. This is the main image people will see first.",
          ),
          const SizedBox(height: 20),
          EventImagePickerWidget(
            selectedImage: selectedBannerImage,
            onTap: onPickBannerImage,
            label: 'Banner Image (16:9)',
          ),
          EventImageHelperTextWidget(
            text:
                "Displayed on the event details page (event preview screen with date, description, and people attending the event).",
          ),
          const SizedBox(height: 20),
          EventImagePickerWidget(
            selectedImage: selectedPosterImage,
            onTap: onPickPosterImage,
            label: 'Poster Image',
            height: 500,
          ),
          EventImageHelperTextWidget(
            text:
                "Used when sharing your event externally (e.g., WhatsApp and other social media platforms). Acts like a preview image for your event.",
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
