import '../config/config.dart';
import '../providers/web_view_provider.dart';

class Magnet {
  final MagnetConfig config;
  final WebViewProvider webViewProvider;

  Magnet({required this.config, required this.webViewProvider});
}
