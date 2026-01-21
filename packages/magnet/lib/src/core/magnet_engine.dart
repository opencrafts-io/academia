// Copyright (C) 2026 Erick Muuo & Open Crafts Interactive Limited
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
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
import './magnet_session.dart';

/// The primary entry point for the Magnet scraping framework.
///
/// This class handles environment initialization and coordinates the
/// execution of [ScrappingCommand]s through [MagnetSession].
class Magnet {
  final Logger _logger = Logger();

  /// Configuration for timeouts, user-agents, and debug settings.
  final MagnetConfig config;

  /// Environment for sharing cookies and cache across sessions.
  WebViewEnvironment? _environment;

  bool _isInitialized = false;

  bool get initialized => _isInitialized;

  /// Private constructor - use [Magnet.init]
  Magnet._(this.config);

  /// Initializes the Magnet engine and sets up platform-specific environments.
  static Future<Magnet> init({required MagnetConfig config}) async {
    final instance = Magnet._(config);

    if (!kIsWeb) {
      final Directory supportDir = await getApplicationDocumentsDirectory();
      final String userDataPath = '${supportDir.path}/magnet_profile';

      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        if (Platform.isWindows) {
          final version = await WebViewEnvironment.getAvailableVersion();
          if (version == null) throw Exception("WebView2 Runtime not found.");
        }

        instance._environment = await WebViewEnvironment.create(
          settings: WebViewEnvironmentSettings(userDataFolder: userDataPath),
        );
      }

      if (kDebugMode && (Platform.isAndroid || Platform.isIOS)) {
        await InAppWebViewController.setWebContentsDebuggingEnabled(true);
      }
    }

    instance._isInitialized = true;
    if (config.debugMode) instance._logger.d("Magnet Engine: Initialized");
    return instance;
  }

  /// Executes a command and returns the aggregated results.
  ///
  /// For headless commands, it manages the full "Prepare -> Execute -> Dispose" lifecycle.
  Future<ScrappingResult> execute(
    ScrappingCommand command, {
    BuildContext? context,
    InstructionCallbackManager? callbackManager,
  }) async {
    if (!_isInitialized) throw Exception("Initialize Magnet first");

    final stopwatch = Stopwatch()..start();

    try {
      // Future-proofing for Interactive Mode
      if (command.requiresInteraction ?? false) {
        return await _executeInteractive(command, stopwatch, context);
      }

      // Execute Headless flow
      return await _executeHeadless(
        command,
        stopwatch,
        callbackManager: callbackManager,
      );
    } catch (e) {
      stopwatch.stop();
      return ScrappingResult(
        success: false,
        data: {},
        commandID: command.commandID,
        error: e.toString(),
        executionTime: stopwatch.elapsed,
      );
    }
  }

  /// Manages the headless session and instruction execution.
  Future<ScrappingResult> _executeHeadless(
    ScrappingCommand command,
    Stopwatch stopwatch, {
    InstructionCallbackManager? callbackManager,
  }) async {
    final sessionId =
        '${command.commandID}-${DateTime.now().millisecondsSinceEpoch}';

    // Create the session wrapper
    final session = MagnetSession(
      environment: _environment,
      sessionId: sessionId,
      config: config,
      logger: _logger,
    );

    try {
      // 1. Setup the browser and navigate to the initial URL
      final controller = await session.prepare(command.url);

      // 2. Initialize the logic executor
      final executor = ScrappingExecutor(
        controller: controller,
        logger: _logger,
        instructionCallbackManager: callbackManager,
      );

      executor.setExecutionContext(
        commandId: command.commandID ?? sessionId,
        totalInstructions: command.instructions.length,
      );

      // 3. Process instructions sequentially
      for (final (index, instruction) in command.instructions.indexed) {
        await executor.execute(instruction, instructionIndex: index);
      }

      stopwatch.stop();
      return ScrappingResult(
        success: true,
        commandID: command.commandID,
        data: executor.extractedData,
        executionTime: stopwatch.elapsed,
      );
    } catch (e) {
      stopwatch.stop();
      _logger.e('Magnet Execution Error: $e');
      rethrow; // Caught by the parent 'execute' method
    } finally {
      // 4. Resource Cleanup: Crucial to prevent zombie WebView processes
      await session.dispose();
    }
  }

  Future<ScrappingResult> _executeInteractive(
    ScrappingCommand command,
    Stopwatch stopwatch,
    BuildContext? context,
  ) async {
    // Note: To be implemented in the future as per brainstorm
    throw UnimplementedError("Interactive mode is not yet implemented.");
  }
}
