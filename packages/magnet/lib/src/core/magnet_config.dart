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

/// Configuration for Magnet engine
class MagnetConfig {
  /// URL of the schema server
  final String schemaServerUrl;

  /// User agent string for WebView
  final String userAgent;

  /// Timeout for scraping operations
  final Duration timeout;

  /// Enable incognito mode for WebView
  final bool incognitoMode;

  /// Enable debug logging
  final bool debugMode;

  const MagnetConfig({
    required this.schemaServerUrl,
    this.userAgent =
        'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15',
    this.timeout = const Duration(minutes: 2),
    this.incognitoMode = false,
    this.debugMode = false,
  });

  /// Default configuration for production
  factory MagnetConfig.production({required String schemaServerUrl}) {
    return MagnetConfig(
      schemaServerUrl: schemaServerUrl,
      incognitoMode: true,
      debugMode: false,
    );
  }

  /// Default configuration for development
  factory MagnetConfig.development({required String schemaServerUrl}) {
    return MagnetConfig(
      schemaServerUrl: schemaServerUrl,
      timeout: const Duration(minutes: 5),
      debugMode: true,
    );
  }
}
