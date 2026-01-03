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
