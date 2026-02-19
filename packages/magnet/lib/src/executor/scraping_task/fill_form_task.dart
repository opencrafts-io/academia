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
import "package:flutter_inappwebview/flutter_inappwebview.dart";
import "package:magnet/magnet.dart";

import "base_task.dart";

/// Handles 'fillForm' instructions by injecting values into input fields.
///
/// Supports various [inputType]s like text, password, and number.
class FillFormTask implements ScrapingTask {
  @override
  Future<Map<String, dynamic>?> run(
    InAppWebViewController controller,
    ScrapingInstruction instruction,
  ) async {
    final selector = instruction.selectorToUse;
    final value = instruction.value ?? '';

    // JS that focuses the element, clears it, and sets the value
    final js =
        """
      (function() {
        var el = ${instruction.isXPath ? "document.evaluate('$selector', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue" : "document.querySelector('$selector')"};
        if (el) {
          el.focus();
          el.value = '$value';
          el.dispatchEvent(new Event('input', { bubbles: true }));
          el.dispatchEvent(new Event('change', { bubbles: true }));
          return true;
        }
        return false;
      })()
    """;

    final success = await controller.evaluateJavascript(source: js);
    if (success == false) throw Exception("Could not find input: $selector");

    return null;
  }
}
