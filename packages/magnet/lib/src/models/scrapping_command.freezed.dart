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

 String? get commandID; String get url; bool? get requiresInteraction; List<ScrapingInstruction> get instructions;
/// Create a copy of ScrappingCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrappingCommandCopyWith<ScrappingCommand> get copyWith => _$ScrappingCommandCopyWithImpl<ScrappingCommand>(this as ScrappingCommand, _$identity);



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
 String? commandID, List<ScrapingInstruction> instructions, bool? requiresInteraction, String url
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
@pragma('vm:prefer-inline') @override $Res call({Object? commandID = freezed,Object? instructions = null,Object? requiresInteraction = freezed,Object? url = null,}) {
  return _then(ScrappingCommand(
commandID: freezed == commandID ? _self.commandID : commandID // ignore: cast_nullable_to_non_nullable
as String?,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<ScrapingInstruction>,requiresInteraction: freezed == requiresInteraction ? _self.requiresInteraction : requiresInteraction // ignore: cast_nullable_to_non_nullable
as bool?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
