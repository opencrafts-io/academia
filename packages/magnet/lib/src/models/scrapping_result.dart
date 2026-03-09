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

part 'scrapping_result.g.dart';
part 'scrapping_result.freezed.dart';

@freezed
@JsonSerializable()
class ScrappingResult with _$ScrappingResult {
  const ScrappingResult({
    this.commandID,
    required this.success,
    required this.data,
    required this.executionTime,
    this.timestamp,
    this.error,
  });

  @override
  @JsonKey(name: "command_id")
  final String? commandID;

  @override
  final String? error;

  @override
  final bool success;

  @override
  final Map<String, dynamic> data;

  @override
  @JsonKey(name: "execution_time")
  final Duration executionTime;

  @override
  final DateTime? timestamp;

  factory ScrappingResult.fromJson(Map<String, dynamic> json) =>
      _$ScrappingResultFromJson(json);

  Map<String, dynamic> toJson() => _$ScrappingResultToJson(this);
}
