import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrapping_instruction.freezed.dart';
part 'scrapping_instruction.g.dart';

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

    String? jsCode,

    String? outputKey,

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
}
