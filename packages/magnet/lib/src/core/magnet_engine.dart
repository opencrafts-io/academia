import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import './magnet_config.dart';

class Magnet {
  final Logger _logger = Logger();
  // Config holds user-defined settings (UserAgent, timeouts, etc.)
  late MagnetConfig config;

  /// The environment that shares cookies/cache between headless and on-screen
  late WebViewEnvironment _environment;

  /// Internal state to track if we are initialized
  bool _isInitialized = false;

  Magnet._(this.config);

  /// Initializes a magnet instance ready for use
  static Future<Magnet> init({required MagnetConfig config}) async {
    final instance = Magnet._(config);

    if (!kIsWeb) {
      final Directory supportDir = await getApplicationDocumentsDirectory();
      final String userDataPath = '${supportDir.path}/magnet_profile';

      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        if (Platform.isWindows) {
          final version = await WebViewEnvironment.getAvailableVersion();
          if (version == null) {
            throw Exception("WebView2 Runtime not found.");
          }
        }

        instance._environment = await WebViewEnvironment.create(
          settings: WebViewEnvironmentSettings(userDataFolder: userDataPath),
        );
      }

      // Enable debugging in dev mode
      if (kDebugMode && (Platform.isAndroid || Platform.isIOS)) {
        await InAppWebViewController.setWebContentsDebuggingEnabled(true);
      }
    }

    instance._isInitialized = true;
    if (config.debugMode) instance._logger.d("Magnet Engine: Initialized");
    return instance;
  }

  /// Accessor for the environment - used when the main app
  /// wants to show the WebView on screen.
  WebViewEnvironment? get environment => _environment;

  /// Accessor for the initialization flag.
  bool get initialized => _isInitialized;

  /// In your Magnet class
  Future<String> testScrape(String url) async {
    if (!_isInitialized) throw Exception("Initialize Magnet first");

    final loadCompleter = Completer<void>();

    // Create a headless webview
    final headlessWebView = HeadlessInAppWebView(
      webViewEnvironment: _environment,
      initialUrlRequest: URLRequest(url: WebUri(url)),
      onLoadStop: (controller, url) async {
        _logger.i("Page Loaded: $url");
        loadCompleter.complete();
      },
      onReceivedError: (controller, request, error) {
        _logger.e(error.toJson());
      },
    );

    await headlessWebView.run();
    await loadCompleter.future;

    // Give it a second to run JS
    final title = await headlessWebView.webViewController?.getTitle();
    _logger.i(await headlessWebView.webViewController?.getHtml());

    // Cleanup
    await headlessWebView.dispose();

    return title ?? "No Title Found";
  }
}
