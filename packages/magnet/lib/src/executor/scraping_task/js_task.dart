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

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:magnet/src/models/scrapping_instruction.dart';

import './base_task.dart';

/// Executes custom JavaScript code within the web page.
///
/// If [instruction.outputKey] is provided, the result of the JS execution
/// will be stored in the final output map under that key.
class JsTask implements ScrapingTask {
  @override
  Future<Map<String, dynamic>?> run(
    InAppWebViewController controller,
    ScrapingInstruction instruction,
  ) async {
    final code = instruction.jsCode;

    if (code == null || code.isEmpty) {
      throw Exception(
        "JS execution failed: No jsCode provided in instruction.",
      );
    }

    // Evaluate the JavaScript code
    final dynamic result = await controller.evaluateJavascript(source: code);

    // If an outputKey is provided, wrap the result in a map.
    // Otherwise, return null (meaning no data to be saved to the global state).
    if (instruction.outputKey != null && result != null) {
      return {instruction.outputKey!: result};
    }

    return null;
  }
}
