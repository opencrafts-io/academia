import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magnet/src/models/scrapping_instruction.dart';

part 'scrapping_command.g.dart';
part 'scrapping_command.freezed.dart';

@freezed
abstract class ScrappingCommand with _$ScrappingCommand {
  const factory ScrappingCommand({
    String? commandID,
    required String url,
    @JsonKey(name: "requires_interaction")
    @Default(false)
    bool? requiresInteraction,
    required List<ScrapingInstruction> instructions,
  }) = _ScrappingCommand;

  factory ScrappingCommand.fromJson(Map<String, dynamic> json) =>
      _$ScrappingCommandFromJson(json);
}
