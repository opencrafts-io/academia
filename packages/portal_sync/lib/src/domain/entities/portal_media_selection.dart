import 'dart:typed_data';

/// Whether an explicitly selected media capture is a photo/screenshot crop
/// or a document (PDF, or a photographed/scanned page). The design doc asks
/// for separate byte/page/pixel ceilings for each, since a multi-page PDF
/// is a much larger payload than a single cropped screenshot.
enum PortalMediaKind { image, document }

/// An explicitly, student-initiated capture that is about to be sent to
/// Gemini via Firebase AI Logic. Construction enforces hard byte and (for
/// PNG) pixel ceilings distinct from the ordinary text-analysis token
/// bounds; this never widens — only narrows — what `FirebasePortalAnalysisClient`
/// will accept.
class PortalMediaSelection {
  const PortalMediaSelection._({
    required this.bytes,
    required this.mimeType,
    required this.kind,
    this.fileName,
  });

  final Uint8List bytes;
  final String mimeType;
  final PortalMediaKind kind;
  final String? fileName;

  /// Images: redacted screenshot crops the student explicitly selected.
  static const int maxImageBytes = 6 * 1024 * 1024;

  /// Documents: a scanned page or a short PDF fee/timetable statement.
  static const int maxDocumentBytes = 15 * 1024 * 1024;

  /// Pixel ceiling enforced on either dimension when it can be read from
  /// the file header without fully decoding the image (currently PNG only;
  /// other formats fall back to the byte ceiling alone — documented, not
  /// silently assumed safe).
  static const int maxImageDimensionPx = 6000;

  static const Set<String> _allowedImageMimeTypes = {
    'image/png',
    'image/jpeg',
    'image/webp',
  };

  static const Set<String> _allowedDocumentMimeTypes = {
    'application/pdf',
    'image/png',
    'image/jpeg',
  };

  /// Validates [bytes]/[mimeType] for [kind] and returns a selection, or
  /// throws [FormatException] describing which ceiling or allowlist check
  /// failed. Never logs [bytes] or [fileName].
  factory PortalMediaSelection.validated({
    required Uint8List bytes,
    required String mimeType,
    required PortalMediaKind kind,
    String? fileName,
  }) {
    final normalizedMime = mimeType.trim().toLowerCase();
    final allowed = kind == PortalMediaKind.image
        ? _allowedImageMimeTypes
        : _allowedDocumentMimeTypes;
    if (!allowed.contains(normalizedMime)) {
      throw const FormatException('Unsupported media type for this capture.');
    }
    if (bytes.isEmpty) {
      throw const FormatException('The selected capture is empty.');
    }
    final maxBytes = kind == PortalMediaKind.image
        ? maxImageBytes
        : maxDocumentBytes;
    if (bytes.length > maxBytes) {
      throw const FormatException('The selected capture is too large.');
    }
    if (normalizedMime == 'image/png') {
      final dimensions = readPngDimensions(bytes);
      if (dimensions != null &&
          (dimensions.width > maxImageDimensionPx ||
              dimensions.height > maxImageDimensionPx)) {
        throw const FormatException(
          'The selected image exceeds the pixel limit.',
        );
      }
    }
    return PortalMediaSelection._(
      bytes: bytes,
      mimeType: normalizedMime,
      kind: kind,
      fileName: fileName,
    );
  }
}

/// Reads the width/height from a PNG's `IHDR` chunk without decoding the
/// image, or returns null when [bytes] is not a well-formed PNG header.
({int width, int height})? readPngDimensions(Uint8List bytes) {
  const signature = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];
  if (bytes.length < 24) return null;
  for (var i = 0; i < signature.length; i++) {
    if (bytes[i] != signature[i]) return null;
  }
  const ihdr = [0x49, 0x48, 0x44, 0x52];
  for (var i = 0; i < ihdr.length; i++) {
    if (bytes[12 + i] != ihdr[i]) return null;
  }
  final view = ByteData.sublistView(bytes, 16, 24);
  return (width: view.getUint32(0), height: view.getUint32(4));
}
