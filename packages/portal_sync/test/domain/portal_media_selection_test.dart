import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/portal_sync.dart';

Uint8List _pngWithDimensions(int width, int height) {
  final bytes = Uint8List(33);
  bytes.setAll(0, const [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]);
  bytes.setAll(8, const [0, 0, 0, 13]);
  bytes.setAll(12, const [0x49, 0x48, 0x44, 0x52]); // "IHDR"
  final view = ByteData.sublistView(bytes);
  view.setUint32(16, width);
  view.setUint32(20, height);
  return bytes;
}

void main() {
  group('readPngDimensions', () {
    test('reads width and height from a well-formed IHDR chunk', () {
      final dimensions = readPngDimensions(_pngWithDimensions(1920, 1080));
      expect(dimensions, (width: 1920, height: 1080));
    });

    test('returns null for data too short to contain a header', () {
      expect(readPngDimensions(Uint8List(10)), isNull);
    });

    test('returns null when the PNG signature does not match', () {
      final bytes = _pngWithDimensions(100, 100);
      bytes[0] = 0x00;
      expect(readPngDimensions(bytes), isNull);
    });
  });

  group('PortalMediaSelection.validated', () {
    test('accepts an image within every ceiling', () {
      final selection = PortalMediaSelection.validated(
        bytes: _pngWithDimensions(800, 600),
        mimeType: 'image/png',
        kind: PortalMediaKind.image,
      );
      expect(selection.kind, PortalMediaKind.image);
      expect(selection.mimeType, 'image/png');
    });

    test('rejects an image over the byte ceiling', () {
      final bytes = Uint8List(PortalMediaSelection.maxImageBytes + 1);
      expect(
        () => PortalMediaSelection.validated(
          bytes: bytes,
          mimeType: 'image/jpeg',
          kind: PortalMediaKind.image,
        ),
        throwsFormatException,
      );
    });

    test('rejects a document over its (larger) byte ceiling', () {
      final bytes = Uint8List(PortalMediaSelection.maxDocumentBytes + 1);
      expect(
        () => PortalMediaSelection.validated(
          bytes: bytes,
          mimeType: 'application/pdf',
          kind: PortalMediaKind.document,
        ),
        throwsFormatException,
      );
    });

    test('image and document byte ceilings are distinct', () {
      expect(
        PortalMediaSelection.maxImageBytes,
        lessThan(PortalMediaSelection.maxDocumentBytes),
      );
    });

    test('rejects a PNG over the pixel ceiling on either dimension', () {
      final tooWide = _pngWithDimensions(
        PortalMediaSelection.maxImageDimensionPx + 1,
        100,
      );
      expect(
        () => PortalMediaSelection.validated(
          bytes: tooWide,
          mimeType: 'image/png',
          kind: PortalMediaKind.image,
        ),
        throwsFormatException,
      );
    });

    test('rejects a mime type not allowed for the given kind', () {
      expect(
        () => PortalMediaSelection.validated(
          bytes: _pngWithDimensions(10, 10),
          mimeType: 'application/pdf',
          kind: PortalMediaKind.image,
        ),
        throwsFormatException,
      );
    });

    test('rejects an empty capture', () {
      expect(
        () => PortalMediaSelection.validated(
          bytes: Uint8List(0),
          mimeType: 'image/png',
          kind: PortalMediaKind.image,
        ),
        throwsFormatException,
      );
    });

    test('allows a PDF document under the document ceiling', () {
      final selection = PortalMediaSelection.validated(
        bytes: Uint8List(1024),
        mimeType: 'application/pdf',
        kind: PortalMediaKind.document,
      );
      expect(selection.mimeType, 'application/pdf');
    });
  });
}
