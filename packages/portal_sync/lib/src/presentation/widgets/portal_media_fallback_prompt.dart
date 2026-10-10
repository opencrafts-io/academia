import 'package:flutter/material.dart';

import '../../diagnostics/portal_debug_log.dart';
import '../../domain/entities/portal_media_selection.dart';
import '../../domain/repositories/portal_sync_repositories.dart';
import '../portal_sync_controller.dart';

/// Non-developer-facing copy shown before a document/image capture ever
/// leaves the device, matching the plan doc's "Example copy" tone. This
/// must be shown at the point of use — never claim all AI processing stays
/// on device, because this path sends the selected image or document to
/// Gemini via Firebase AI Logic.
const String portalMediaFallbackDisclosureCopy =
    'We’ll send this image or document to our AI service to read your '
    'course or class time information. Only send a page you’re '
    'comfortable sharing, and check the result before saving.';

/// A compact control that lets the student explicitly pick a screenshot
/// crop or document when the portal page itself could not be read, shows
/// the data-leaves-the-device disclosure, and feeds the result into
/// [PortalSyncController.analyzeMediaFallback].
class PortalMediaFallbackPrompt extends StatelessWidget {
  const PortalMediaFallbackPrompt({
    required this.controller,
    required this.pickerSource,
    super.key,
  });

  final PortalSyncController controller;
  final PortalMediaPickerSource pickerSource;

  Future<void> _pick(
    BuildContext context,
    Future<PortalMediaSelection?> Function() pick,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send this to our AI service?'),
        content: const Text(portalMediaFallbackDisclosureCopy),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    PortalMediaSelection? selection;
    try {
      selection = await pick();
    } on Object catch (error, stack) {
      portalDebugLog('media_pick.failed', error: error, stackTrace: stack);
      return;
    }
    if (selection == null) return;
    await controller.analyzeMediaFallback(selection);
  }

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: state.isBusy
              ? null
              : () => _pick(context, pickerSource.pickImage),
          icon: const Icon(Icons.image_outlined),
          label: const Text('Use a screenshot'),
        ),
        OutlinedButton.icon(
          onPressed: state.isBusy
              ? null
              : () => _pick(context, pickerSource.pickDocument),
          icon: const Icon(Icons.description_outlined),
          label: const Text('Use a document'),
        ),
      ],
    );
  }
}
