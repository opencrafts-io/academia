import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portal_sync/portal_sync.dart';

/// Wraps the app's existing `image_picker`/`file_picker` dependencies behind
/// [PortalMediaPickerSource] so `packages/portal_sync` never needs to depend
/// on a device media plugin directly. Every call here is the direct result
/// of an explicit student tap — nothing here runs automatically.
class AcademiaPortalMediaPicker implements PortalMediaPickerSource {
  AcademiaPortalMediaPicker({ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;

  @override
  Future<PortalMediaSelection?> pickImage() async {
    final file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    return PortalMediaSelection.validated(
      bytes: bytes,
      mimeType: _imageMimeType(file.name),
      kind: PortalMediaKind.image,
      fileName: file.name,
    );
  }

  @override
  Future<PortalMediaSelection?> pickDocument() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'png', 'jpg', 'jpeg'],
      withData: true,
    );
    final files = result?.files ?? const [];
    final file = files.isEmpty ? null : files.first;
    final bytes = file?.bytes;
    if (file == null || bytes == null) return null;
    return PortalMediaSelection.validated(
      bytes: bytes,
      mimeType: _documentMimeType(file.name),
      kind: PortalMediaKind.document,
      fileName: file.name,
    );
  }

  String _imageMimeType(String fileName) {
    final lower = fileName.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }

  String _documentMimeType(String fileName) {
    final lower = fileName.toLowerCase();
    if (lower.endsWith('.pdf')) return 'application/pdf';
    if (lower.endsWith('.png')) return 'image/png';
    return 'image/jpeg';
  }
}
