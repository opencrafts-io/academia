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

// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magnet/src/models/scrapping_instruction.dart';

part 'scrapping_command.g.dart';
part 'scrapping_command.freezed.dart';

@freezed
abstract class ScrappingCommand with _$ScrappingCommand {
  const factory ScrappingCommand({
    @JsonKey(name: "command_id") String? commandID,
    required String url,
    @JsonKey(name: "requires_interaction")
    @Default(false)
    bool? requiresInteraction,
    required List<ScrapingInstruction> instructions,
  }) = _ScrappingCommand;

  factory ScrappingCommand.fromJson(Map<String, dynamic> json) =>
      _$ScrappingCommandFromJson(json);

}
