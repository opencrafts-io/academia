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
