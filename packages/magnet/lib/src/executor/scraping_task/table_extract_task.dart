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

class TableExtractTask implements ScrapingTask {
  @override
  Future<Map<String, dynamic>?> run(
    InAppWebViewController controller,
    ScrapingInstruction instruction,
  ) async {
    final selector = instruction.selectorToUse;

    // JS to map table headers to row cells
    final String tableParserJs =
        """
      (function(tableSelector) {
        const table = document.querySelector(tableSelector);
        if (!table) return null;

        const headers = Array.from(table.querySelectorAll('thead th, tr:first-child th'))
                             .map(th => th.innerText.trim());
        
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        
        // If no tbody, get all rows except the first (header) row
        const dataRows = rows.length > 0 ? rows : Array.from(table.querySelectorAll('tr')).slice(1);

        return dataRows.map(row => {
          const cells = Array.from(row.querySelectorAll('td'));
          const rowData = {};
          headers.forEach((header, index) => {
            if (cells[index]) {
              rowData[header] = cells[index].innerText.trim();
            }
          });
          return rowData;
        });
      })('$selector')
    """;

    final result = await controller.evaluateJavascript(source: tableParserJs);

    if (instruction.outputKey != null && result != null) {
      return {instruction.outputKey!: result};
    }

    return null;
  }
}
