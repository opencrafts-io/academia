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

import 'package:magnet/src/executor/instruction_status.dart';

/// [InstructionProgressEvent]
///
/// An event that is emitted when an instruction is executed.
final class InstructionProgressEvent {
  final String commandId;
  final int instructionIndex;
  final int totalInstructions;
  final String instructionType;
  final InstructionStatus status;
  final Map<String, dynamic>? data; // Extracted data if applicable
  final String? error;
  final DateTime timestamp;
  final Duration? executionTime;

  InstructionProgressEvent({
    required this.commandId,
    required this.instructionIndex,
    required this.totalInstructions,
    required this.instructionType,
    required this.status,
    this.data,
    this.error,
    required this.timestamp,
    this.executionTime,
  });

  /// Get progress percentage
  double get progressPercent => (instructionIndex / totalInstructions) * 100;

  /// Whether this is the last instruction
  bool get isLastInstruction => instructionIndex == totalInstructions;
}
