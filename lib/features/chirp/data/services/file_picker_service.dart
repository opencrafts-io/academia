import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:academia/features/chirp/domain/entities/post.dart';

class FilePickerService {
  static Future<List<Attachment>> pickFiles({
    bool allowMultiple = true,
    List<String> allowedExtensions = const [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'bmp',
      'webp',
      'mp4',
      'mov',
      'avi',
      'mkv',
      'wmv',
      'flv',
      'webm',
      'mp3',
      'wav',
      'aac',
      'm4a',
      'ogg',
      'pdf',
      'doc',
      'docx',
      'txt',
      'rtf',
      'xls',
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

  static Future<List<Attachment>> pickImages({
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

  static Future<List<Attachment>> pickVideos({
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

  static Future<List<Attachment>> pickDocuments({
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

  static Attachment _createAttachmentFromFile(PlatformFile file) {
    final extension = path.extension(file.path ?? '').toLowerCase();
    String attachmentType = 'document'; // default

    // Determine attachment type based on file extension
    if ([
      '.jpg',
      '.jpeg',
      '.png',
      '.gif',
      '.bmp',
      '.webp',
    ].contains(extension)) {
      attachmentType = 'image';
    } else if ([
      '.mp4',
      '.mov',
      '.avi',
      '.mkv',
      '.wmv',
      '.flv',
      '.webm',
    ].contains(extension)) {
      attachmentType = 'video';
    } else if (['.pdf'].contains(extension)) {
      attachmentType = 'pdf';
    } else if ([
      '.doc',
      '.docx',
      '.txt',
      '.rtf',
      '.xls',
      '.xlsx',
      '.ppt',
      '.pptx',
    ].contains(extension)) {
      attachmentType = 'document';
    } else if (['.mp3', '.wav', '.aac', '.m4a', '.ogg'].contains(extension)) {
      attachmentType = 'audio';
    }

    return Attachment(
      attachmentType: attachmentType,
      file: file.path ?? '', // For local files, this will be the file path
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
