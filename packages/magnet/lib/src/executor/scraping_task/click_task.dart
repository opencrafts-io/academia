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

/// A task that handles a 'click' instruction
class ClickTask extends ScrapingTask {
  @override
  Future<Map<String, dynamic>?> run(
    InAppWebViewController controller,
    ScrapingInstruction instruction,
  ) async {
    final selector = instruction.selectorToUse;
    final js = instruction.isXPath
        ? "document.evaluate('$selector', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();"
        : "document.querySelector('$selector').click();";

    await controller.evaluateJavascript(source: js);
    return null;
  }
}
