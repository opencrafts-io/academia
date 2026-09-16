// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'block_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BlockStatus {

 bool get isBlocked; String get entityType; String get entityId;
/// Create a copy of BlockStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockStatusCopyWith<BlockStatus> get copyWith => _$BlockStatusCopyWithImpl<BlockStatus>(this as BlockStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockStatus&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId));
}


@override
int get hashCode => Object.hash(runtimeType,isBlocked,entityType,entityId);

@override
String toString() {
  return 'BlockStatus(isBlocked: $isBlocked, entityType: $entityType, entityId: $entityId)';
}


}

/// @nodoc
abstract mixin class $BlockStatusCopyWith<$Res>  {
  factory $BlockStatusCopyWith(BlockStatus value, $Res Function(BlockStatus) _then) = _$BlockStatusCopyWithImpl;
@useResult
$Res call({
 bool isBlocked, String entityType, String entityId
});




}
/// @nodoc
class _$BlockStatusCopyWithImpl<$Res>
    implements $BlockStatusCopyWith<$Res> {
  _$BlockStatusCopyWithImpl(this._self, this._then);

  final BlockStatus _self;
  final $Res Function(BlockStatus) _then;

/// Create a copy of BlockStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isBlocked = null,Object? entityType = null,Object? entityId = null,}) {
  return _then(_self.copyWith(
isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockStatus].
extension BlockStatusPatterns on BlockStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockStatus value)  $default,){
final _that = this;
switch (_that) {
case _BlockStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockStatus value)?  $default,){
final _that = this;
switch (_that) {
case _BlockStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isBlocked,  String entityType,  String entityId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockStatus() when $default != null:
return $default(_that.isBlocked,_that.entityType,_that.entityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isBlocked,  String entityType,  String entityId)  $default,) {final _that = this;
switch (_that) {
case _BlockStatus():
return $default(_that.isBlocked,_that.entityType,_that.entityId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isBlocked,  String entityType,  String entityId)?  $default,) {final _that = this;
switch (_that) {
case _BlockStatus() when $default != null:
return $default(_that.isBlocked,_that.entityType,_that.entityId);case _:
  return null;

}
}

}

/// @nodoc


class _BlockStatus implements BlockStatus {
  const _BlockStatus({required this.isBlocked, required this.entityType, required this.entityId});
  

@override final  bool isBlocked;
@override final  String entityType;
@override final  String entityId;

/// Create a copy of BlockStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockStatusCopyWith<_BlockStatus> get copyWith => __$BlockStatusCopyWithImpl<_BlockStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockStatus&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId));
}


@override
int get hashCode => Object.hash(runtimeType,isBlocked,entityType,entityId);

@override
String toString() {
  return 'BlockStatus(isBlocked: $isBlocked, entityType: $entityType, entityId: $entityId)';
}


}

/// @nodoc
abstract mixin class _$BlockStatusCopyWith<$Res> implements $BlockStatusCopyWith<$Res> {
  factory _$BlockStatusCopyWith(_BlockStatus value, $Res Function(_BlockStatus) _then) = __$BlockStatusCopyWithImpl;
@override @useResult
$Res call({
 bool isBlocked, String entityType, String entityId
});




}
/// @nodoc
class __$BlockStatusCopyWithImpl<$Res>
    implements _$BlockStatusCopyWith<$Res> {
  __$BlockStatusCopyWithImpl(this._self, this._then);

  final _BlockStatus _self;
  final $Res Function(_BlockStatus) _then;

/// Create a copy of BlockStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isBlocked = null,Object? entityType = null,Object? entityId = null,}) {
  return _then(_BlockStatus(
isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
