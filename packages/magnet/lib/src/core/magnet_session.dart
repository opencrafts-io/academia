import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:magnet/magnet.dart';
import 'package:logger/logger.dart';

/// Manages the lifecycle and state of a single browser instance.
///
/// The [MagnetSession] acts as a wrapper around the WebView implementation,
/// handling the complexities of headless initialization, page load
/// synchronization, and resource cleanup.
///
/// By encapsulating the [HeadlessInAppWebView], it ensures that the
/// main engine doesn't have to deal with low-level browser events.
class MagnetSession {
  /// Unique identifier for this session, used for logging and tracking.
  final String sessionId;

  /// Configuration containing global timeouts and user agents.
  final MagnetConfig config;

  /// Logger instance for session-specific diagnostic output.
  final Logger logger;

  /// The underlying headless browser instance.
  late HeadlessInAppWebView _headlessWebView;

  /// Internal completer to capture the controller once the WebView is ready.
  final Completer<InAppWebViewController> _controllerCompleter = Completer();

  /// Internal completer to signal when the initial page load has finished or failed.
  final Completer<void> _loadCompleter = Completer();

  final WebViewEnvironment? environment;

  MagnetSession({
    required this.sessionId,
    required this.config,
    required this.logger,
    required this.environment,
  });

  /// Prepares the browser and navigates to the [url].
  ///
  /// This method:
  /// 1. Boots the headless engine.
  /// 2. Navigates to the target URL.
  /// 3. Waits for the `onLoadStop` event.
  ///
  /// Throws a [TimeoutException] if the page fails to load within
  /// the [MagnetConfig.timeout] duration.
  ///
  /// Returns the [InAppWebViewController] ready for instruction execution.
  Future<InAppWebViewController> prepare(String url) async {
    _headlessWebView = HeadlessInAppWebView(
      webViewEnvironment: environment,
      initialUrlRequest: URLRequest(url: WebUri(url)),
      onWebViewCreated: (controller) =>
          _controllerCompleter.complete(controller),
      onLoadStop: (controller, url) {
        logger.i('[$sessionId] Page synchronization complete: $url');
        if (!_loadCompleter.isCompleted) _loadCompleter.complete();
      },
      onReceivedError: (controller, request, error) {
        logger.e('[$sessionId] Navigation Error: ${error.description}');
        if (!_loadCompleter.isCompleted) _loadCompleter.completeError(error);
      },
    );

    await _headlessWebView.run();
    final controller = await _controllerCompleter.future;

    // Synchronize with page load
    await _loadCompleter.future.timeout(config.timeout);
    return controller;
  }

  /// Disposes of the headless WebView and frees up system memory.
  ///
  /// This should always be called in a `finally` block to prevent
  /// memory leaks, especially on mobile devices with limited RAM.
  Future<void> dispose() async {
    if (_headlessWebView.isRunning()) {
      await _headlessWebView.dispose();
      logger.d('[$sessionId] Headless session terminated and disposed.');
    }
  }
}
