import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';
import 'package:magnet/src/executor/scrapping_executor.dart';
import 'package:magnet/src/models/scrapping_command.dart';
import 'package:magnet/src/models/scrapping_result.dart';
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

  Future<ScrappingResult> execute(ScrappingCommand command) async {
    if (!_isInitialized) throw Exception("Initialize Magnet first");

    final stopwatch = Stopwatch()..start();

    try {
      // For interactive commands, use on-screen browser
      if (command.requiresInteraction ?? false) {
        return await _executeInteractive(command, stopwatch);
      }

      // Otherwise use headless pool
      return await _executeHeadless(command, stopwatch);
    } catch (e) {
      stopwatch.stop();
      return ScrappingResult(
        commandID: command.commandID,
        success: false,
        data: {},
        error: e.toString(),
        timestamp: DateTime.now(),
        executionTime: stopwatch.elapsed,
      );
    }
  }

  Future<ScrappingResult> _executeHeadless(
    ScrappingCommand command,
    Stopwatch stopwatch,
  ) async {
    // Wait for available session slot
    // while (_activeSessions >= config.maxConcurrentSessions) {
    //   await Future.delayed(const Duration(milliseconds: 100));
    // }
    //
    // _activeSessions++;

    try {
      final loadCompleter = Completer<void>();
      HeadlessInAppWebView? headlessWebView;

      headlessWebView = HeadlessInAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(command.url)),
        onLoadStop: (controller, url) {
          _logger.i("Headless page loaded: $url");
          loadCompleter.complete();
        },
        onReceivedError: (controller, request, error) {
          _logger.e("WebView error: ${error.description}");
          if (!loadCompleter.isCompleted) {
            loadCompleter.completeError(error);
          }
        },
        onConsoleMessage: (controller, msg) {
          if (config.debugMode) {
            _logger.d("Console [${msg.messageLevel}]: ${msg.message}");
          }
        },
      );

      await headlessWebView.run();

      // Wait for page load with timeout
      await loadCompleter.future.timeout(
        config.timeout,
        onTimeout: () => _logger.w("Page load timeout for ${command.url}"),
      );

      // Execute instructions
      final executor = ScrappingExecutor(
        controller: headlessWebView.webViewController!,
        logger: _logger,
      );

      for (final instruction in command.instructions) {
        await executor.execute(instruction);
      }

      stopwatch.stop();

      await headlessWebView.dispose();

      return ScrappingResult(
        commandID: command.commandID,
        success: true,
        data: executor.extractedData,
        timestamp: DateTime.now(),
        executionTime: stopwatch.elapsed,
      );
    } finally {
      // _activeSessions--;
    }
  }

  Future<ScrappingResult> _executeInteractive(
    ScrappingCommand command,
    Stopwatch stopwatch,
  ) async {
    // Placeholder for on-screen interactive scraping
    // Would integrate with your widget layer
    _logger.w("Interactive scraping not yet implemented");
    stopwatch.stop();
    return ScrappingResult(
      commandID: command.commandID,
      success: false,
      data: {},
      error: 'Interactive scraping not implemented',
      timestamp: DateTime.now(),
      executionTime: stopwatch.elapsed,
    );
  }
}
