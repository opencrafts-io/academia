import 'portal_media_selection.dart';

/// A request to analyze one explicitly selected image/document via Gemini's
/// multimodal input. [selection] has already passed the byte/pixel
/// ceilings in [PortalMediaSelection.validated]; this type does not repeat
/// that validation, it only carries the already-validated payload plus the
/// model to use.
class PortalMediaAnalysisRequest {
  const PortalMediaAnalysisRequest({
    required this.selection,
    required this.modelVersion,
  });

  final PortalMediaSelection selection;
  final String modelVersion;
}
