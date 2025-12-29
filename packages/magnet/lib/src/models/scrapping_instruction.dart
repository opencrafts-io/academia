import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrapping_instruction.freezed.dart';
part 'scrapping_instruction.g.dart';

@freezed
abstract class WaitStrategy with _$WaitStrategy {
  const WaitStrategy._();

  /// Wait for URL to match a pattern
  const factory WaitStrategy.waitForUrl({
    required String pattern,
    @Default(30000) int timeoutMs,
  }) = _WaitForUrl;

  /// Wait for DOM element to appear
  const factory WaitStrategy.waitForElement({
    required String selector,
    @Default(30000) int timeoutMs,
  }) = _WaitForElement;

  /// Wait for DOM element to disappear
  const factory WaitStrategy.waitForElementDisappear({
    required String selector,
    @Default(30000) int timeoutMs,
  }) = _WaitForElementDisappear;

  /// Wait for network to be idle
  const factory WaitStrategy.waitForNetworkIdle({
    @Default(30000) int timeoutMs,
    @Default(500) int quietDurationMs,
  }) = _WaitForNetworkIdle;

  /// Wait for any strategy to succeed
  const factory WaitStrategy.waitForAny({
    required List<WaitStrategy> strategies,
    @Default(30000) int timeoutMs,
  }) = _WaitForAny;

  /// Wait for all strategies to succeed
  const factory WaitStrategy.waitForAll({
    required List<WaitStrategy> strategies,
    @Default(30000) int timeoutMs,
  }) = _WaitForAll;

  factory WaitStrategy.fromJson(Map<String, dynamic> json) =>
      _$WaitStrategyFromJson(json);

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

  Duration get timeout => Duration(milliseconds: timeoutMs);
}

@freezed
abstract class ScrapingInstruction with _$ScrapingInstruction {
  const ScrapingInstruction._();

  const factory ScrapingInstruction({
    /// 'extract', 'click', 'fillForm', 'wait', 'executeJs', 'screenshot'
    required String type,

    /// CSS selector to be used
    String? selector,

    /// The xpath of the element - used instead of the css selector
    String? xpath,
    String? attribute,
    String? value,

    int? waitMilliseconds,

    WaitStrategy? waitStrategy,

    String? jsCode,

    String? outputKey,

    /// Whether to wait after execution completes
    @Default(false) bool waitAfterExecution,

    /// For conditional/nested operations
    // List<ScrapingInstruction>? steps,
  }) = _ScrapingInstruction;

  factory ScrapingInstruction.fromJson(Map<String, dynamic> json) =>
      _$ScrapingInstructionFromJson(json);

  String get selectorToUse => selector ?? xpath ?? '';
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
