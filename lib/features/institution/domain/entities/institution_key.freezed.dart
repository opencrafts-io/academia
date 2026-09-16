// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstitutionKey {

 int get institutionId; String get commandId; Map<String, dynamic> get keySets; DateTime get createdAt;
/// Create a copy of InstitutionKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstitutionKeyCopyWith<InstitutionKey> get copyWith => _$InstitutionKeyCopyWithImpl<InstitutionKey>(this as InstitutionKey, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstitutionKey&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.commandId, commandId) || other.commandId == commandId)&&const DeepCollectionEquality().equals(other.keySets, keySets)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,institutionId,commandId,const DeepCollectionEquality().hash(keySets),createdAt);

@override
String toString() {
  return 'InstitutionKey(institutionId: $institutionId, commandId: $commandId, keySets: $keySets, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InstitutionKeyCopyWith<$Res>  {
  factory $InstitutionKeyCopyWith(InstitutionKey value, $Res Function(InstitutionKey) _then) = _$InstitutionKeyCopyWithImpl;
@useResult
$Res call({
 int institutionId, String commandId, Map<String, dynamic> keySets, DateTime createdAt
});




}
/// @nodoc
class _$InstitutionKeyCopyWithImpl<$Res>
    implements $InstitutionKeyCopyWith<$Res> {
  _$InstitutionKeyCopyWithImpl(this._self, this._then);

  final InstitutionKey _self;
  final $Res Function(InstitutionKey) _then;

/// Create a copy of InstitutionKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? institutionId = null,Object? commandId = null,Object? keySets = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
institutionId: null == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int,commandId: null == commandId ? _self.commandId : commandId // ignore: cast_nullable_to_non_nullable
as String,keySets: null == keySets ? _self.keySets : keySets // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [InstitutionKey].
extension InstitutionKeyPatterns on InstitutionKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstitutionKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstitutionKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstitutionKey value)  $default,){
final _that = this;
switch (_that) {
case _InstitutionKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstitutionKey value)?  $default,){
final _that = this;
switch (_that) {
case _InstitutionKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int institutionId,  String commandId,  Map<String, dynamic> keySets,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstitutionKey() when $default != null:
return $default(_that.institutionId,_that.commandId,_that.keySets,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int institutionId,  String commandId,  Map<String, dynamic> keySets,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _InstitutionKey():
return $default(_that.institutionId,_that.commandId,_that.keySets,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int institutionId,  String commandId,  Map<String, dynamic> keySets,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InstitutionKey() when $default != null:
return $default(_that.institutionId,_that.commandId,_that.keySets,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _InstitutionKey implements InstitutionKey {
  const _InstitutionKey({required this.institutionId, required this.commandId, required final  Map<String, dynamic> keySets, required this.createdAt}): _keySets = keySets;
  

@override final  int institutionId;
@override final  String commandId;
 final  Map<String, dynamic> _keySets;
@override Map<String, dynamic> get keySets {
  if (_keySets is EqualUnmodifiableMapView) return _keySets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_keySets);
}

@override final  DateTime createdAt;

/// Create a copy of InstitutionKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstitutionKeyCopyWith<_InstitutionKey> get copyWith => __$InstitutionKeyCopyWithImpl<_InstitutionKey>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstitutionKey&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.commandId, commandId) || other.commandId == commandId)&&const DeepCollectionEquality().equals(other._keySets, _keySets)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,institutionId,commandId,const DeepCollectionEquality().hash(_keySets),createdAt);

@override
String toString() {
  return 'InstitutionKey(institutionId: $institutionId, commandId: $commandId, keySets: $keySets, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InstitutionKeyCopyWith<$Res> implements $InstitutionKeyCopyWith<$Res> {
  factory _$InstitutionKeyCopyWith(_InstitutionKey value, $Res Function(_InstitutionKey) _then) = __$InstitutionKeyCopyWithImpl;
@override @useResult
$Res call({
 int institutionId, String commandId, Map<String, dynamic> keySets, DateTime createdAt
});




}
/// @nodoc
class __$InstitutionKeyCopyWithImpl<$Res>
    implements _$InstitutionKeyCopyWith<$Res> {
  __$InstitutionKeyCopyWithImpl(this._self, this._then);

  final _InstitutionKey _self;
  final $Res Function(_InstitutionKey) _then;

/// Create a copy of InstitutionKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? institutionId = null,Object? commandId = null,Object? keySets = null,Object? createdAt = null,}) {
  return _then(_InstitutionKey(
institutionId: null == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int,commandId: null == commandId ? _self.commandId : commandId // ignore: cast_nullable_to_non_nullable
as String,keySets: null == keySets ? _self._keySets : keySets // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
