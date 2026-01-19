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

import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrapping_instruction.freezed.dart';
part 'scrapping_instruction.g.dart';

/// Defines logic for the engine to pause execution until a specific condition is met.
///
/// Wait strategies are essential for handling Single Page Applications (SPAs)
/// and slow network conditions in Kenya or other regions with varying connectivity.
@freezed
abstract class WaitStrategy with _$WaitStrategy {
  const WaitStrategy._();

  /// Pauses execution until the browser's current URL matches the [pattern].
  ///
  /// [pattern] can be a partial string or a regex-style match.
  /// Throws a timeout error after [timeoutMs] has elapsed.
  const factory WaitStrategy.waitForUrl({
    required String pattern,
    @Default(30000) int timeoutMs,
  }) = _WaitForUrl;

  /// Pauses execution until a DOM element matching the [selector] is present and visible.
  ///
  /// This is the most common strategy for ensuring a page has loaded before clicking.
  const factory WaitStrategy.waitForElement({
    required String selector,
    @Default(30000) int timeoutMs,
  }) = _WaitForElement;

  /// Pauses execution until a DOM element matching the [selector] is removed from the DOM.
  ///
  /// Useful for waiting for "Loading" spinners or overlays to disappear.
  const factory WaitStrategy.waitForElementDisappear({
    required String selector,
    @Default(30000) int timeoutMs,
  }) = _WaitForElementDisappear;

  /// Pauses execution until there are no active network requests for [quietDurationMs].
  ///
  /// This is a "heavy" strategy used for sites that load data dynamically
  /// without changing the URL or DOM immediately.
  const factory WaitStrategy.waitForNetworkIdle({
    @Default(30000) int timeoutMs,
    @Default(500) int quietDurationMs,
  }) = _WaitForNetworkIdle;

  /// A logical OR operation for waiting.
  ///
  /// Succeeds as soon as **any** of the provided [strategies] complete.
  /// Useful for handling "either the dashboard loads OR an error message appears."
  const factory WaitStrategy.waitForAny({
    required List<WaitStrategy> strategies,
    @Default(30000) int timeoutMs,
  }) = _WaitForAny;

  /// A logical AND operation for waiting.
  ///
  /// Succeeds only when **all** provided [strategies] have completed.
  /// Use this for complex page states where multiple elements must load.
  const factory WaitStrategy.waitForAll({
    required List<WaitStrategy> strategies,
    @Default(30000) int timeoutMs,
  }) = _WaitForAll;

  /// Creates a [WaitStrategy] from a JSON map.
  factory WaitStrategy.fromJson(Map<String, dynamic> json) =>
      _$WaitStrategyFromJson(json);

  /// Helper to extract the timeout value regardless of the strategy type.
  @override
  int get timeoutMs => maybeMap(
    waitForUrl: (v) => v.timeoutMs,
    waitForElement: (v) => v.timeoutMs,
    waitForElementDisappear: (v) => v.timeoutMs,
    waitForNetworkIdle: (v) => v.timeoutMs,
    waitForAny: (v) => v.timeoutMs,
    waitForAll: (v) => v.timeoutMs,
    orElse: () => 30000,
  );

  /// Converts the [timeoutMs] into a standard Dart [Duration].
  Duration get timeout => Duration(milliseconds: timeoutMs);
}

/// Defines the behavior when an instruction fails to execute.
enum FaultStrategy {
  /// Stops the entire scraping process and returns an error.
  @JsonValue('abort')
  abort,

  /// Logs the error but continues to the next instruction in the sequence.
  @JsonValue('ignore')
  ignore,

  /// Re-attempts the instruction until [maxRetries] is reached before failing.
  @JsonValue('retry')
  retry,
}

/// Represents a single unit of work for the Magnet scraping engine.
///
/// Instructions are typically received as JSON from a remote server, allowing
/// for dynamic updates to scraping logic without app redeployment.
@freezed
abstract class ScrapingInstruction with _$ScrapingInstruction {
  const ScrapingInstruction._();

  const factory ScrapingInstruction({
    /// The action type to perform (e.g., 'extract', 'click', 'fill-form').
    required String type,

    /// Determines how the engine handles errors for this specific step.
    /// Defaults to [FaultStrategy.abort].
    @Default(FaultStrategy.abort) FaultStrategy faultStrategy,

    /// Number of times to re-attempt the task if it fails.
    /// Only applicable if [faultStrategy] is set to [FaultStrategy.retry].
    @Default(0) int maxRetries,

    /// The duration to wait between retry attempts.
    @Default(Duration(seconds: 1)) Duration retryDelay,

    /// A CSS selector used to target a DOM element.
    String? selector,

    /// An XPath expression used to target a DOM element.
    /// If both [selector] and [xpath] are provided, [selector] usually takes priority.
    String? xpath,

    /// The HTML attribute to target (e.g., 'href', 'src', 'value').
    String? attribute,

    /// The literal value to be used (e.g., text to input into a form).
    String? value,

    /// A fixed delay in milliseconds to wait before executing this instruction.
    int? waitMilliseconds,

    /// A complex waiting condition (e.g., wait for network idle) to satisfy
    /// before or during execution.
    WaitStrategy? waitStrategy,

    /// Custom JavaScript code to be injected and executed within the page context.
    String? jsCode,

    /// The key name used to store the result in the final output map.
    String? outputKey,

    /// Internal key used to reference values across different instructions.
    String? valueKey,

    /// The keyboard/input type for form fields (e.g., 'text', 'password', 'number').
    String? inputType,

    /// A human-readable label for the input field, useful for logging or UI mirroring.
    String? inputLabel,

    /// If true, the engine will trigger the [waitStrategy] *after* the action
    /// is performed (e.g., click a button then wait for a new element).
    @Default(false) bool waitAfterExecution,
  }) = _ScrapingInstruction;

  /// Creates a [ScrapingInstruction] from a JSON map provided by the remote server.
  factory ScrapingInstruction.fromJson(Map<String, dynamic> json) =>
      _$ScrapingInstructionFromJson(json);

  /// Returns the available targeting string, prioritizing [selector] over [xpath].
  String get selectorToUse => selector ?? xpath ?? '';

  /// Returns true if the instruction is using XPath for targeting.
  bool get isXPath => xpath != null && selector == null;
}

/// Extension to help with Duration conversion if needed by the Engine
extension ScrapingInstructionX on ScrapingInstruction {
  Duration? get waitDuration => waitMilliseconds != null
      ? Duration(milliseconds: waitMilliseconds!)
      : null;

  /// Check if instruction has any form of waiting
  bool get hasWaitStrategy => waitStrategy != null;

  /// Check if instruction should wait after execution
  bool get shouldWaitAfterExecution =>
      waitAfterExecution && waitStrategy != null;
}

/// Custom deserializer for WaitStrategy from JSON
extension WaitStrategyParsing on Map<String, dynamic> {
  WaitStrategy? parseWaitStrategy() {
    if (isEmpty) return null;

    final type = this['type'] as String?;
    final timeout = (this['timeout'] ?? this['timeoutMs'] as int?) ?? 30000;

    switch (type) {
      case 'url':
        return WaitStrategy.waitForUrl(
          pattern: this['pattern'] as String? ?? '',
          timeoutMs: timeout,
        );
      case 'element':
        return WaitStrategy.waitForElement(
          selector: this['selector'] as String? ?? '',
          timeoutMs: timeout,
        );
      case 'elementDisappear':
        return WaitStrategy.waitForElementDisappear(
          selector: this['selector'] as String? ?? '',
          timeoutMs: timeout,
        );
      case 'networkIdle':
        return WaitStrategy.waitForNetworkIdle(
          timeoutMs: timeout,
          quietDurationMs:
              (this['quietDuration'] ?? this['quietDurationMs'] as int?) ?? 500,
        );
      case 'any':
        final strategies =
            (this['strategies'] as List?)
                ?.cast<Map<String, dynamic>>()
                .map((s) => s.parseWaitStrategy())
                .whereType<WaitStrategy>()
                .toList() ??
            [];
        return WaitStrategy.waitForAny(
          strategies: strategies,
          timeoutMs: timeout,
        );
      case 'all':
        final strategies =
            (this['strategies'] as List?)
                ?.cast<Map<String, dynamic>>()
                .map((s) => s.parseWaitStrategy())
                .whereType<WaitStrategy>()
                .toList() ??
            [];
        return WaitStrategy.waitForAll(
          strategies: strategies,
          timeoutMs: timeout,
        );
      default:
        return null;
    }
  }
}
