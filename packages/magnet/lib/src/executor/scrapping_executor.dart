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

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';
import 'package:magnet/src/executor/instruction_callback_manager.dart';
import 'package:magnet/src/executor/instruction_progress_event.dart';
import 'package:magnet/src/executor/instruction_status.dart';
import 'package:magnet/src/executor/task_registry.dart';
import 'package:magnet/src/models/scrapping_instruction.dart';

class ScrappingExecutor {
  final InAppWebViewController controller;
  final Logger logger;
  final Map<String, dynamic> extractedData = {};
  final InstructionCallbackManager? instructionCallbackManager;
  final TaskRegistry _taskRegistry = TaskRegistry();

  String? _currentCommandId;
  int _currentInstructionIndex = 0;
  int _totalInstructions = 0;

   void setExecutionContext({
    required String commandId,
    required int totalInstructions,
  }) {
    _currentCommandId = commandId;
    _totalInstructions = totalInstructions;
  }

  ScrappingExecutor({
    required this.controller,
    required this.logger,
    this.instructionCallbackManager,
  });

  Future<void> execute(
    ScrapingInstruction instruction, {
    required int instructionIndex,
  }) async {
    _currentInstructionIndex = instructionIndex;
    final task = _taskRegistry.getTask(instruction.type);

    if (task == null) throw Exception("Unknown task: ${instruction.type}");

    // EMIT RUNNING EVENT
    _emitProgress(
      status: InstructionStatus.running,
      instructionType: instruction.type,
    );

    int attempts = 0;
    while (attempts <= instruction.maxRetries) {
      try {
        final stopwatch = Stopwatch()..start();

        // EXECUTE THE TASK
        final result = await task.run(controller, instruction);

        // Handle post-execution wait if requested
        if (instruction.shouldWaitAfterExecution) {
          await _taskRegistry.getTask("wait")!.run(controller, instruction);
        }

        if (result != null) extractedData.addAll(result);

        _emitProgress(
          status: InstructionStatus.completed,
          instructionType: instruction.type,
          executionTime: stopwatch.elapsed,
          data: result,
        );
        return; // Success!
      } catch (e) {
        attempts++;
        if (attempts > instruction.maxRetries) {
          if (instruction.faultStrategy == FaultStrategy.ignore) {
            _emitProgress(
              status: InstructionStatus.failed,
              error: "Ignored: $e",
              instructionType: instruction.type,
            );
            return;
          }
          _emitProgress(
            status: InstructionStatus.failed,
            error: e.toString(),
            instructionType: instruction.type,
          );
          rethrow;
        }
        logger.w('Retrying task ${instruction.type} (Attempt $attempts)');
        await Future.delayed(instruction.retryDelay);
      }
    }
  }

  /// Broadcasts the current state of an instruction to the [instructionCallbackManager].
  ///
  /// This method bundles the execution context ([commandId], [index]) with the
  /// results or errors of the current task and notifies all listeners.
  void _emitProgress({
    required InstructionStatus status,
    required String instructionType,
    Map<String, dynamic>? data,
    String? error,
    Duration? executionTime,
  }) {
    // Guard: Ensure we have a context and a manager before emitting
    if (instructionCallbackManager == null || _currentCommandId == null) {
      logger.w(
        'Progress emission skipped: Missing commandId or CallbackManager',
      );
      return;
    }

    final event = InstructionProgressEvent(
      commandId: _currentCommandId!,
      // Adding 1 to index to make it 1-based for human-readable UI
      instructionIndex: _currentInstructionIndex + 1,
      totalInstructions: _totalInstructions,
      instructionType: instructionType,
      status: status,
      data: data,
      error: error,
      timestamp: DateTime.now(),
      executionTime: executionTime,
    );

    instructionCallbackManager!.emitProgress(event);

    // Log the event for local debugging
    if (status == InstructionStatus.failed) {
      logger.e('Instruction Failed: [$instructionType] -> $error');
    } else {
      logger.d('Instruction Update: [$instructionType] status is $status');
    }
  }
}
