import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magnet/src/models/scrapping_instruction.dart';

part 'scrapping_command.g.dart';
part 'scrapping_command.freezed.dart';

@freezed
@JsonSerializable()
class ScrappingCommand with _$ScrappingCommand {
  const ScrappingCommand({
    this.commandID,
    required this.instructions,
    this.requiresInteraction,
    required this.url,
  });

  @override
  final String? commandID;

  @override
  final String url;

  @override
  @Default(false)
  @JsonKey(name: "requires_interaction")
  final bool? requiresInteraction;

  @override
  final List<ScrapingInstruction> instructions;

  factory ScrappingCommand.fromJson(Map<String, dynamic> json) =>
      _$ScrappingCommandFromJson(json);

  Map<String, Object?> toJson() => _$ScrappingCommandToJson(this);
}
