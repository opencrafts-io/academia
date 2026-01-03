import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';
import 'package:magnet/src/executor/instruction_callback_manager.dart';
import 'package:magnet/src/executor/scrapping_executor.dart';
import 'package:magnet/src/models/scrapping_command.dart';
import 'package:magnet/src/models/scrapping_result.dart';
import 'package:path_provider/path_provider.dart';

import './magnet_config.dart';

// ============================================================================
// HEADLESS SESSION WRAPPER
// ============================================================================

class HeadlessSession {
  final String sessionId;
  final String commandId;
  final String initialUrl;

  late HeadlessInAppWebView webView;
  late InAppWebViewController controller;

  /// Completes when initial page load finishes
  final Completer<void> initialLoadCompleter = Completer<void>();

  /// Tracks if initial load has completed
  bool _initialLoadDone = false;
  bool get initialLoadDone => _initialLoadDone;

  HeadlessSession({
    required this.sessionId,
    required this.commandId,
    required this.initialUrl,
  });

  /// Mark initial load as complete (safe to call multiple times)
  void markInitialLoadComplete() {
    if (!_initialLoadDone && !initialLoadCompleter.isCompleted) {
      _initialLoadDone = true;
      initialLoadCompleter.complete();
    }
  }

  /// Mark initial load as failed
  void markInitialLoadFailed(Object error) {
    if (!initialLoadCompleter.isCompleted) {
      initialLoadCompleter.completeError(error);
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await webView.dispose();
  }
}

// ============================================================================
// MAGNET ENGINE
// ============================================================================

class Magnet {
  final Logger _logger = Logger();
  // Config holds user-defined settings (UserAgent, timeouts, etc.)
  late MagnetConfig config;

  /// The environment that shares cookies/cache between headless and on-screen
  WebViewEnvironment? _environment;

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

  /// Executes a command and its resulting instructions
  ///
  /// For commands which require interactivity please pass the
  /// BuildContext to ensure that the browser can be pushed to the foreground
  /// Otherwise the function will throw an exception.
  Future<ScrappingResult> execute(
    ScrappingCommand command, {
    BuildContext? context,
    InstructionCallbackManager? callbackManager,
  }) async {
    if (!_isInitialized) throw Exception("Initialize Magnet first");

    final stopwatch = Stopwatch()..start();

    try {
      // For interactive commands, use on-screen browser
      if (command.requiresInteraction ?? false) {
        assert(context != null);
        return await _executeInteractive(
          command: command,
          stopwatch: stopwatch,
          context: context!,
        );
      }

      // Otherwise use headless pool
      return await _executeHeadless(
        command,
        stopwatch,
        callbackManager: callbackManager,
      );
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

  /// Execute headless scraping with proper redirect handling
  Future<ScrappingResult> _executeHeadless(
    ScrappingCommand command,
    Stopwatch stopwatch, {
    InstructionCallbackManager? callbackManager,
  }) async {
    final sessionId =
        '${command.commandID}-${DateTime.now().millisecondsSinceEpoch}';
    HeadlessSession? session;

    try {
      // Create session
      session = HeadlessSession(
        sessionId: sessionId,
        commandId: command.commandID ?? sessionId,
        initialUrl: command.url,
      );

      _logger.i('Starting headless session: $sessionId');

      // Create headless WebView with proper redirect handling
      session.webView = HeadlessInAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(command.url)),
        onWebViewCreated: (controller) {
          session!.controller = controller;
          _logger.d('WebView controller created for session: $sessionId');
        },
        onLoadStart: (controller, url) {
          _logger.d('Load start: $url');
        },
        onLoadStop: (controller, url) {
          _logger.i('Page loaded: $url');
          // Mark initial load as done - safe for multiple calls (handles redirects)
          session!.markInitialLoadComplete();
        },
        onReceivedError: (controller, request, error) {
          _logger.e("WebView error: ${error.description}");
          session!.markInitialLoadFailed(error);
        },
        onConsoleMessage: (controller, msg) {
          if (config.debugMode) {
            _logger.d("Console [${msg.messageLevel}]: ${msg.message}");
          }
        },
      );

      await session.webView.run();

      // Wait for initial page load with timeout
      try {
        await session.initialLoadCompleter.future.timeout(
          config.timeout,
          onTimeout: () {
            _logger.w("Page load timeout for: ${command.url}");
          },
        );
      } catch (e) {
        _logger.w('Initial load failed: $e');
        // Continue anyway - page might still be usable
      }

      _logger.i('Initial load complete, executing instructions');

      // Execute instructions
      final executor = ScrappingExecutor(
        controller: session.controller,
        logger: _logger,
      );

      executor.setExecutionContext(
        commandId: command.commandID ?? sessionId,
        totalInstructions: command.instructions.length,
      );

      for (final (index, instruction) in command.instructions.indexed) {
        _logger.d('Executing instruction $index: ${instruction.type}');
        await executor.execute(instruction, instructionIndex: index);
      }

      stopwatch.stop();

      _logger.i('✓ Headless execution completed: $sessionId');

      return ScrappingResult(
        commandID: command.commandID,
        success: true,
        data: executor.extractedData,
        timestamp: DateTime.now(),
        executionTime: stopwatch.elapsed,
      );
    } catch (e) {
      stopwatch.stop();
      _logger.e('✗ Headless execution failed: $e');
      return ScrappingResult(
        commandID: command.commandID,
        success: false,
        data: {},
        error: 'Headless execution failed: $e',
        timestamp: DateTime.now(),
        executionTime: stopwatch.elapsed,
      );
    } finally {
      // Cleanup
      try {
        if (session != null) {
          await session.dispose();
        }
      } catch (e) {
        _logger.w('Error disposing session: $e');
      }
    }
  }

  Future<ScrappingResult> _executeInteractive({
    required ScrappingCommand command,
    required Stopwatch stopwatch,
    required BuildContext context,
  }) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text("Wait")),
          body: InAppWebView(
            webViewEnvironment: _environment,
            initialUrlRequest: URLRequest(url: WebUri(command.url)),
          ),
        ),
      ),
    );
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
