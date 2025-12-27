import 'package:flutter_inappwebview/flutter_inappwebview.dart';

abstract class WebViewProvider {
  /// Create and configure a WebView for scraping
  Future<InAppWebViewController> createWebView({
    required InAppWebViewSettings settings,
    required String initialUrl,
  });

  /// Sets the webview visibility by default
  /// it should be set to false to ensure headless scrapping.
  void setWebViewVisibility({bool visible = false});

  /// Dispose of the WebView
  Future<void> disposeWebView();
}
