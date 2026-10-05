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

import './scraping_task/scraping_task.dart';

/// Registry that maps scraping instruction names to their corresponding
/// [ScrapingTask] implementations.
class TaskRegistry {
  final Map<String, ScrapingTask> _tasks = {
    'click': ClickTask(),
    'extract': ExtractTask(),
    'wait': WaitTask(),
    'fill-form': FillFormTask(),
    'screenshot': ScreenshotTask(),
    'js': JsTask(),
    'extract-table': TableExtractTask(),
  };

  /// Returns the [ScrapingTask] associated with the given instruction [type],
  /// or `null` if no matching task is registered.
  ScrapingTask? getTask(String type) => _tasks[type];
}
