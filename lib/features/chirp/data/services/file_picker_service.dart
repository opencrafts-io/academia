import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:academia/features/chirp/domain/entities/attachments.dart';

class FilePickerService {
  static Future<List<Attachments>> pickFiles({
    bool allowMultiple = true,
    List<String> allowedExtensions = const [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'mp4',
      'pdf',
      'doc',
      'docx',
      'txt',
      'xlsx',
      'ppt',
      'pptx',
    ],
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
        type: FileType.custom,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.map((file) {
          return _createAttachmentFromFile(file);
        }).toList();
      }
    } catch (e) {
      // Handle error
      print('Error picking files: $e');
    }

    return [];
  }

  static Future<List<Attachments>> pickImages({
    bool allowMultiple = true,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.map((file) {
          return _createAttachmentFromFile(file);
        }).toList();
      }
    } catch (e) {
      print('Error picking images: $e');
    }

    return [];
  }

  static Future<List<Attachments>> pickVideos({
    bool allowMultiple = true,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        type: FileType.video,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.map((file) {
          return _createAttachmentFromFile(file);
        }).toList();
      }
    } catch (e) {
      print('Error picking videos: $e');
    }

    return [];
  }

  static Future<List<Attachments>> pickDocuments({
    bool allowMultiple = true,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'rtf'],
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.map((file) {
          return _createAttachmentFromFile(file);
        }).toList();
      }
    } catch (e) {
      print('Error picking documents: $e');
    }

    return [];
  }

  static Attachments _createAttachmentFromFile(PlatformFile file) {
    final extension = path.extension(file.path ?? '').toLowerCase();
    String attachmentType = 'document'; // default

    // Determine attachment type based on file extension
    if (['.jpg', '.jpeg', '.png', '.gif'].contains(extension)) {
      attachmentType = 'image';
    } else if (['.mp4'].contains(extension)) {
      attachmentType = 'video';
    } else if (['.pdf'].contains(extension)) {
      attachmentType = 'pdf';
    } else if ([
      '.doc',
      '.docx',
      '.txt',
      '.xlsx',
      '.ppt',
      '.pptx',
    ].contains(extension)) {
      attachmentType = 'document';
    } else if (['.mp3', '.wav', '.aac', '.m4a', '.ogg'].contains(extension)) {
      attachmentType = 'audio';
    }

    return Attachments(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: '', // This will be set when the attachment is associated with a post
      attachmentType: attachmentType,
      file: file.path ?? '', // For local files, this will be the file path
      name: file.name,
      size: file.size.toDouble(),
      createdAt: DateTime.now(),
    );
  }

  static String getFileSizeString(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  static String getFileExtension(String filePath) {
    return path.extension(filePath).toLowerCase().replaceAll('.', '');
  }

  static String getFileName(String filePath) {
    return path.basename(filePath);
  }
}
