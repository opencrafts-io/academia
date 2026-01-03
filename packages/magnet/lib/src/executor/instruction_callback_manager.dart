import 'dart:async';

import 'package:magnet/src/executor/instruction_progress_event.dart';

final class InstructionCallbackManager {
  final _progressController =
      StreamController<InstructionProgressEvent>.broadcast();

  /// Public stream that listeners can subscribe to.
  Stream<InstructionProgressEvent> get progressStream =>
      _progressController.stream;

  /// Emit a new progress event
  void emitProgress(InstructionProgressEvent event) {
    if (!_progressController.isClosed) {
      _progressController.add(event);
    }
  }

  /// Dispose the stream controller
  void dispose() {
    _progressController.close();
  }
}
