import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class _CropRatio {
  final String label;
  final double? ratio;
  const _CropRatio(this.label, this.ratio);
}

const _cropRatios = [
  _CropRatio('Original', null),
  _CropRatio('1:1', 1),
  _CropRatio('4:5', 4 / 5),
  _CropRatio('16:9', 16 / 9),
];

/// Optional, on-demand crop screen for a single image attachment. Opened
/// from the attachment carousel's action sheet - never forced on capture.
///
/// Uses a dark ColorScheme seeded from the app's own primary color rather
/// than hardcoded black/white, so the AppBar/chips/icons pick up correct
/// M3 tonal contrast automatically instead of fighting the theme.
class ImageCropScreen extends StatefulWidget {
  final Uint8List image;

  const ImageCropScreen({super.key, required this.image});

  @override
  State<ImageCropScreen> createState() => _ImageCropScreenState();
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  final _controller = GlobalKey<ExtendedImageEditorState>();
  double? _ratio;
  bool _isCropping = false;

  Future<void> _confirm() async {
    final state = _controller.currentState;
    final cropRect = state?.getCropRect();
    if (state == null || cropRect == null) {
      Navigator.pop(context);
      return;
    }

    setState(() => _isCropping = true);

    final cropCommand = img.Command()
      ..decodeImage(state.rawImageData)
      ..copyCrop(
        x: cropRect.topLeft.dx.ceil(),
        y: cropRect.topLeft.dy.ceil(),
        width: cropRect.width.ceil(),
        height: cropRect.height.ceil(),
      );
    final encodeCommand = img.Command()
      ..subCommand = cropCommand
      ..encodeJpg();
    final cropped = await encodeCommand.getBytesThread();

    if (!mounted) return;
    Navigator.pop(context, cropped);
  }

  @override
  Widget build(BuildContext context) {
    final darkScheme = ColorScheme.fromSeed(
      seedColor: Theme.of(context).colorScheme.primary,
      brightness: Brightness.dark,
    );

    return Theme(
      data: ThemeData(colorScheme: darkScheme, useMaterial3: true),
      child: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          return Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: AppBar(
              backgroundColor: colorScheme.surface,
              foregroundColor: colorScheme.onSurface,
              leading: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Crop photo'),
              actions: [
                IconButton(
                  icon: _isCropping
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colorScheme.onSurface,
                          ),
                        )
                      : const Icon(Icons.check_rounded),
                  onPressed: _isCropping ? null : _confirm,
                ),
              ],
            ),
            body: Container(
              color: colorScheme.surface,
              child: ExtendedImage.memory(
                widget.image,
                cacheRawData: true,
                fit: BoxFit.contain,
                extendedImageEditorKey: _controller,
                mode: ExtendedImageMode.editor,
                initEditorConfigHandler: (state) =>
                    EditorConfig(cropAspectRatio: _ratio),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                height: 64,
                color: colorScheme.surfaceContainer,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _cropRatios.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final option = _cropRatios[index];
                    return ChoiceChip(
                      label: Text(option.label),
                      selected: option.ratio == _ratio,
                      onSelected: (_) =>
                          setState(() => _ratio = option.ratio),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
