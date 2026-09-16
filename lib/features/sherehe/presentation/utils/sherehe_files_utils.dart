import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShereheFilesUtils {
  static Future<XFile?> downloadImage(String url) async {
    try {
      final dio = Dio();

      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/event_share.jpg';

      await dio.download(
        url,
        filePath,
        options: Options(
          responseType: ResponseType.bytes, // ensures raw bytes
        ),
      );

      return XFile(filePath);
    } catch (e) {
      return null;
    }
  }
}
