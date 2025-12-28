import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrapping_instruction.freezed.dart';
part 'scrapping_instruction.g.dart';

@freezed
abstract class ScrapingInstruction with _$ScrapingInstruction {
  const factory ScrapingInstruction({
    /// 'extract', 'click', 'fillForm', 'wait', 'executeJs', 'screenshot'
    required String type,

    String? selector,
    String? attribute,
    String? value,

    int? waitMilliseconds,

    String? jsCode,

    String? outputKey,

    /// For conditional/nested operations
    List<ScrapingInstruction>? steps,
  }) = _ScrapingInstruction;

  factory ScrapingInstruction.fromJson(Map<String, dynamic> json) =>
      _$ScrapingInstructionFromJson(json);
}

/// Extension to help with Duration conversion if needed by the Engine
extension ScrapingInstructionX on ScrapingInstruction {
  Duration? get waitDuration => waitMilliseconds != null
      ? Duration(milliseconds: waitMilliseconds!)
      : null;
}
