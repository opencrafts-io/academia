/// [InstructionStatus]
///
/// Represents the current status of the instruction in question
/// and is emitted by the InstructionCallbackManager upon running
/// an instruction against the instruction executor.
enum InstructionStatus { pending, running, completed, failed }
