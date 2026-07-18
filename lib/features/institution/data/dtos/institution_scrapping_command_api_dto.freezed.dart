// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution_scrapping_command_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InstitutionScrappingCommandApiDto {

 int get institution;@JsonKey(name: 'command_id') String get commandId; String get name; String? get url; String? get description;@JsonKey(name: 'requires_interaction') bool get requiresInteraction;@JsonKey(name: 'created_at') DateTime? get createdAt; List<dynamic> get instructions;
/// Create a copy of InstitutionScrappingCommandApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstitutionScrappingCommandApiDtoCopyWith<InstitutionScrappingCommandApiDto> get copyWith => _$InstitutionScrappingCommandApiDtoCopyWithImpl<InstitutionScrappingCommandApiDto>(this as InstitutionScrappingCommandApiDto, _$identity);

  /// Serializes this InstitutionScrappingCommandApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstitutionScrappingCommandApiDto&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.commandId, commandId) || other.commandId == commandId)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description)&&(identical(other.requiresInteraction, requiresInteraction) || other.requiresInteraction == requiresInteraction)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.instructions, instructions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,institution,commandId,name,url,description,requiresInteraction,createdAt,const DeepCollectionEquality().hash(instructions));

@override
String toString() {
  return 'InstitutionScrappingCommandApiDto(institution: $institution, commandId: $commandId, name: $name, url: $url, description: $description, requiresInteraction: $requiresInteraction, createdAt: $createdAt, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class $InstitutionScrappingCommandApiDtoCopyWith<$Res>  {
  factory $InstitutionScrappingCommandApiDtoCopyWith(InstitutionScrappingCommandApiDto value, $Res Function(InstitutionScrappingCommandApiDto) _then) = _$InstitutionScrappingCommandApiDtoCopyWithImpl;
@useResult
$Res call({
 int institution,@JsonKey(name: 'command_id') String commandId, String name, String? url, String? description,@JsonKey(name: 'requires_interaction') bool requiresInteraction,@JsonKey(name: 'created_at') DateTime? createdAt, List<dynamic> instructions
});




}
/// @nodoc
class _$InstitutionScrappingCommandApiDtoCopyWithImpl<$Res>
    implements $InstitutionScrappingCommandApiDtoCopyWith<$Res> {
  _$InstitutionScrappingCommandApiDtoCopyWithImpl(this._self, this._then);

  final InstitutionScrappingCommandApiDto _self;
  final $Res Function(InstitutionScrappingCommandApiDto) _then;

/// Create a copy of InstitutionScrappingCommandApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? institution = null,Object? commandId = null,Object? name = null,Object? url = freezed,Object? description = freezed,Object? requiresInteraction = null,Object? createdAt = freezed,Object? instructions = null,}) {
  return _then(_self.copyWith(
institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,commandId: null == commandId ? _self.commandId : commandId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,requiresInteraction: null == requiresInteraction ? _self.requiresInteraction : requiresInteraction // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [InstitutionScrappingCommandApiDto].
extension InstitutionScrappingCommandApiDtoPatterns on InstitutionScrappingCommandApiDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstitutionScrappingCommandApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstitutionScrappingCommandApiDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstitutionScrappingCommandApiDto value)  $default,){
final _that = this;
switch (_that) {
case _InstitutionScrappingCommandApiDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstitutionScrappingCommandApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _InstitutionScrappingCommandApiDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int institution, @JsonKey(name: 'command_id')  String commandId,  String name,  String? url,  String? description, @JsonKey(name: 'requires_interaction')  bool requiresInteraction, @JsonKey(name: 'created_at')  DateTime? createdAt,  List<dynamic> instructions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstitutionScrappingCommandApiDto() when $default != null:
return $default(_that.institution,_that.commandId,_that.name,_that.url,_that.description,_that.requiresInteraction,_that.createdAt,_that.instructions);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int institution, @JsonKey(name: 'command_id')  String commandId,  String name,  String? url,  String? description, @JsonKey(name: 'requires_interaction')  bool requiresInteraction, @JsonKey(name: 'created_at')  DateTime? createdAt,  List<dynamic> instructions)  $default,) {final _that = this;
switch (_that) {
case _InstitutionScrappingCommandApiDto():
return $default(_that.institution,_that.commandId,_that.name,_that.url,_that.description,_that.requiresInteraction,_that.createdAt,_that.instructions);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int institution, @JsonKey(name: 'command_id')  String commandId,  String name,  String? url,  String? description, @JsonKey(name: 'requires_interaction')  bool requiresInteraction, @JsonKey(name: 'created_at')  DateTime? createdAt,  List<dynamic> instructions)?  $default,) {final _that = this;
switch (_that) {
case _InstitutionScrappingCommandApiDto() when $default != null:
return $default(_that.institution,_that.commandId,_that.name,_that.url,_that.description,_that.requiresInteraction,_that.createdAt,_that.instructions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InstitutionScrappingCommandApiDto implements InstitutionScrappingCommandApiDto {
  const _InstitutionScrappingCommandApiDto({required this.institution, @JsonKey(name: 'command_id') required this.commandId, required this.name, this.url, this.description, @JsonKey(name: 'requires_interaction') this.requiresInteraction = false, @JsonKey(name: 'created_at') this.createdAt, required final  List<dynamic> instructions}): _instructions = instructions;
  factory _InstitutionScrappingCommandApiDto.fromJson(Map<String, dynamic> json) => _$InstitutionScrappingCommandApiDtoFromJson(json);

@override final  int institution;
@override@JsonKey(name: 'command_id') final  String commandId;
@override final  String name;
@override final  String? url;
@override final  String? description;
@override@JsonKey(name: 'requires_interaction') final  bool requiresInteraction;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
 final  List<dynamic> _instructions;
@override List<dynamic> get instructions {
  if (_instructions is EqualUnmodifiableListView) return _instructions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_instructions);
}


/// Create a copy of InstitutionScrappingCommandApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstitutionScrappingCommandApiDtoCopyWith<_InstitutionScrappingCommandApiDto> get copyWith => __$InstitutionScrappingCommandApiDtoCopyWithImpl<_InstitutionScrappingCommandApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InstitutionScrappingCommandApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstitutionScrappingCommandApiDto&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.commandId, commandId) || other.commandId == commandId)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description)&&(identical(other.requiresInteraction, requiresInteraction) || other.requiresInteraction == requiresInteraction)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._instructions, _instructions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,institution,commandId,name,url,description,requiresInteraction,createdAt,const DeepCollectionEquality().hash(_instructions));

@override
String toString() {
  return 'InstitutionScrappingCommandApiDto(institution: $institution, commandId: $commandId, name: $name, url: $url, description: $description, requiresInteraction: $requiresInteraction, createdAt: $createdAt, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class _$InstitutionScrappingCommandApiDtoCopyWith<$Res> implements $InstitutionScrappingCommandApiDtoCopyWith<$Res> {
  factory _$InstitutionScrappingCommandApiDtoCopyWith(_InstitutionScrappingCommandApiDto value, $Res Function(_InstitutionScrappingCommandApiDto) _then) = __$InstitutionScrappingCommandApiDtoCopyWithImpl;
@override @useResult
$Res call({
 int institution,@JsonKey(name: 'command_id') String commandId, String name, String? url, String? description,@JsonKey(name: 'requires_interaction') bool requiresInteraction,@JsonKey(name: 'created_at') DateTime? createdAt, List<dynamic> instructions
});




}
/// @nodoc
class __$InstitutionScrappingCommandApiDtoCopyWithImpl<$Res>
    implements _$InstitutionScrappingCommandApiDtoCopyWith<$Res> {
  __$InstitutionScrappingCommandApiDtoCopyWithImpl(this._self, this._then);

  final _InstitutionScrappingCommandApiDto _self;
  final $Res Function(_InstitutionScrappingCommandApiDto) _then;

/// Create a copy of InstitutionScrappingCommandApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? institution = null,Object? commandId = null,Object? name = null,Object? url = freezed,Object? description = freezed,Object? requiresInteraction = null,Object? createdAt = freezed,Object? instructions = null,}) {
  return _then(_InstitutionScrappingCommandApiDto(
institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,commandId: null == commandId ? _self.commandId : commandId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,requiresInteraction: null == requiresInteraction ? _self.requiresInteraction : requiresInteraction // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,instructions: null == instructions ? _self._instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

// dart format on
