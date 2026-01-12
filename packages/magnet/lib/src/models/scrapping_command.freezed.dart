// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scrapping_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScrappingCommand {

 String? get commandID; String get url;@JsonKey(name: "requires_interaction") bool? get requiresInteraction; List<ScrapingInstruction> get instructions;
/// Create a copy of ScrappingCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrappingCommandCopyWith<ScrappingCommand> get copyWith => _$ScrappingCommandCopyWithImpl<ScrappingCommand>(this as ScrappingCommand, _$identity);

  /// Serializes this ScrappingCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScrappingCommand&&(identical(other.commandID, commandID) || other.commandID == commandID)&&(identical(other.url, url) || other.url == url)&&(identical(other.requiresInteraction, requiresInteraction) || other.requiresInteraction == requiresInteraction)&&const DeepCollectionEquality().equals(other.instructions, instructions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,commandID,url,requiresInteraction,const DeepCollectionEquality().hash(instructions));

@override
String toString() {
  return 'ScrappingCommand(commandID: $commandID, url: $url, requiresInteraction: $requiresInteraction, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class $ScrappingCommandCopyWith<$Res>  {
  factory $ScrappingCommandCopyWith(ScrappingCommand value, $Res Function(ScrappingCommand) _then) = _$ScrappingCommandCopyWithImpl;
@useResult
$Res call({
 String? commandID, String url,@JsonKey(name: "requires_interaction") bool? requiresInteraction, List<ScrapingInstruction> instructions
});




}
/// @nodoc
class _$ScrappingCommandCopyWithImpl<$Res>
    implements $ScrappingCommandCopyWith<$Res> {
  _$ScrappingCommandCopyWithImpl(this._self, this._then);

  final ScrappingCommand _self;
  final $Res Function(ScrappingCommand) _then;

/// Create a copy of ScrappingCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? commandID = freezed,Object? url = null,Object? requiresInteraction = freezed,Object? instructions = null,}) {
  return _then(_self.copyWith(
commandID: freezed == commandID ? _self.commandID : commandID // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,requiresInteraction: freezed == requiresInteraction ? _self.requiresInteraction : requiresInteraction // ignore: cast_nullable_to_non_nullable
as bool?,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<ScrapingInstruction>,
  ));
}

}


/// Adds pattern-matching-related methods to [ScrappingCommand].
extension ScrappingCommandPatterns on ScrappingCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScrappingCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScrappingCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScrappingCommand value)  $default,){
final _that = this;
switch (_that) {
case _ScrappingCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScrappingCommand value)?  $default,){
final _that = this;
switch (_that) {
case _ScrappingCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? commandID,  String url, @JsonKey(name: "requires_interaction")  bool? requiresInteraction,  List<ScrapingInstruction> instructions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScrappingCommand() when $default != null:
return $default(_that.commandID,_that.url,_that.requiresInteraction,_that.instructions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? commandID,  String url, @JsonKey(name: "requires_interaction")  bool? requiresInteraction,  List<ScrapingInstruction> instructions)  $default,) {final _that = this;
switch (_that) {
case _ScrappingCommand():
return $default(_that.commandID,_that.url,_that.requiresInteraction,_that.instructions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? commandID,  String url, @JsonKey(name: "requires_interaction")  bool? requiresInteraction,  List<ScrapingInstruction> instructions)?  $default,) {final _that = this;
switch (_that) {
case _ScrappingCommand() when $default != null:
return $default(_that.commandID,_that.url,_that.requiresInteraction,_that.instructions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScrappingCommand implements ScrappingCommand {
  const _ScrappingCommand({this.commandID, required this.url, @JsonKey(name: "requires_interaction") this.requiresInteraction = false, required final  List<ScrapingInstruction> instructions}): _instructions = instructions;
  factory _ScrappingCommand.fromJson(Map<String, dynamic> json) => _$ScrappingCommandFromJson(json);

@override final  String? commandID;
@override final  String url;
@override@JsonKey(name: "requires_interaction") final  bool? requiresInteraction;
 final  List<ScrapingInstruction> _instructions;
@override List<ScrapingInstruction> get instructions {
  if (_instructions is EqualUnmodifiableListView) return _instructions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_instructions);
}


/// Create a copy of ScrappingCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScrappingCommandCopyWith<_ScrappingCommand> get copyWith => __$ScrappingCommandCopyWithImpl<_ScrappingCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScrappingCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrappingCommand&&(identical(other.commandID, commandID) || other.commandID == commandID)&&(identical(other.url, url) || other.url == url)&&(identical(other.requiresInteraction, requiresInteraction) || other.requiresInteraction == requiresInteraction)&&const DeepCollectionEquality().equals(other._instructions, _instructions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,commandID,url,requiresInteraction,const DeepCollectionEquality().hash(_instructions));

@override
String toString() {
  return 'ScrappingCommand(commandID: $commandID, url: $url, requiresInteraction: $requiresInteraction, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class _$ScrappingCommandCopyWith<$Res> implements $ScrappingCommandCopyWith<$Res> {
  factory _$ScrappingCommandCopyWith(_ScrappingCommand value, $Res Function(_ScrappingCommand) _then) = __$ScrappingCommandCopyWithImpl;
@override @useResult
$Res call({
 String? commandID, String url,@JsonKey(name: "requires_interaction") bool? requiresInteraction, List<ScrapingInstruction> instructions
});




}
/// @nodoc
class __$ScrappingCommandCopyWithImpl<$Res>
    implements _$ScrappingCommandCopyWith<$Res> {
  __$ScrappingCommandCopyWithImpl(this._self, this._then);

  final _ScrappingCommand _self;
  final $Res Function(_ScrappingCommand) _then;

/// Create a copy of ScrappingCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? commandID = freezed,Object? url = null,Object? requiresInteraction = freezed,Object? instructions = null,}) {
  return _then(_ScrappingCommand(
commandID: freezed == commandID ? _self.commandID : commandID // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,requiresInteraction: freezed == requiresInteraction ? _self.requiresInteraction : requiresInteraction // ignore: cast_nullable_to_non_nullable
as bool?,instructions: null == instructions ? _self._instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<ScrapingInstruction>,
  ));
}


}

// dart format on
