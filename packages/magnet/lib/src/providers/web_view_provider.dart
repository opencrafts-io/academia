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

abstract class WebViewProvider {
  /// Create and configure a WebView for scraping
  Future<InAppWebViewController> createWebView({
    required InAppWebViewSettings settings,
    required String initialUrl,
  });

  /// Sets the webview visibility by default
  /// it should be set to false to ensure headless scrapping.
  void setWebViewVisibility({bool visible = false});

  /// Dispose of the WebView
  Future<void> disposeWebView();
}
