// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_tag_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoTagEntity {

 int get localId; String? get id; String get name; String? get color; SyncStatus get syncStatus; DateTime? get createdAt; bool get isPendingDeletion; bool get isDirty;
/// Create a copy of TodoTagEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoTagEntityCopyWith<TodoTagEntity> get copyWith => _$TodoTagEntityCopyWithImpl<TodoTagEntity>(this as TodoTagEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoTagEntity&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isPendingDeletion, isPendingDeletion) || other.isPendingDeletion == isPendingDeletion)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty));
}


@override
int get hashCode => Object.hash(runtimeType,localId,id,name,color,syncStatus,createdAt,isPendingDeletion,isDirty);

@override
String toString() {
  return 'TodoTagEntity(localId: $localId, id: $id, name: $name, color: $color, syncStatus: $syncStatus, createdAt: $createdAt, isPendingDeletion: $isPendingDeletion, isDirty: $isDirty)';
}


}

/// @nodoc
abstract mixin class $TodoTagEntityCopyWith<$Res>  {
  factory $TodoTagEntityCopyWith(TodoTagEntity value, $Res Function(TodoTagEntity) _then) = _$TodoTagEntityCopyWithImpl;
@useResult
$Res call({
 int localId, String? id, String name, String? color, SyncStatus syncStatus, DateTime? createdAt, bool isPendingDeletion, bool isDirty
});




}
/// @nodoc
class _$TodoTagEntityCopyWithImpl<$Res>
    implements $TodoTagEntityCopyWith<$Res> {
  _$TodoTagEntityCopyWithImpl(this._self, this._then);

  final TodoTagEntity _self;
  final $Res Function(TodoTagEntity) _then;

/// Create a copy of TodoTagEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localId = null,Object? id = freezed,Object? name = null,Object? color = freezed,Object? syncStatus = null,Object? createdAt = freezed,Object? isPendingDeletion = null,Object? isDirty = null,}) {
  return _then(_self.copyWith(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPendingDeletion: null == isPendingDeletion ? _self.isPendingDeletion : isPendingDeletion // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoTagEntity].
extension TodoTagEntityPatterns on TodoTagEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoTagEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoTagEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoTagEntity value)  $default,){
final _that = this;
switch (_that) {
case _TodoTagEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoTagEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TodoTagEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int localId,  String? id,  String name,  String? color,  SyncStatus syncStatus,  DateTime? createdAt,  bool isPendingDeletion,  bool isDirty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoTagEntity() when $default != null:
return $default(_that.localId,_that.id,_that.name,_that.color,_that.syncStatus,_that.createdAt,_that.isPendingDeletion,_that.isDirty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int localId,  String? id,  String name,  String? color,  SyncStatus syncStatus,  DateTime? createdAt,  bool isPendingDeletion,  bool isDirty)  $default,) {final _that = this;
switch (_that) {
case _TodoTagEntity():
return $default(_that.localId,_that.id,_that.name,_that.color,_that.syncStatus,_that.createdAt,_that.isPendingDeletion,_that.isDirty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int localId,  String? id,  String name,  String? color,  SyncStatus syncStatus,  DateTime? createdAt,  bool isPendingDeletion,  bool isDirty)?  $default,) {final _that = this;
switch (_that) {
case _TodoTagEntity() when $default != null:
return $default(_that.localId,_that.id,_that.name,_that.color,_that.syncStatus,_that.createdAt,_that.isPendingDeletion,_that.isDirty);case _:
  return null;

}
}

}

/// @nodoc


class _TodoTagEntity implements TodoTagEntity {
  const _TodoTagEntity({required this.localId, this.id, required this.name, this.color, required this.syncStatus, this.createdAt, required this.isPendingDeletion, required this.isDirty});
  

@override final  int localId;
@override final  String? id;
@override final  String name;
@override final  String? color;
@override final  SyncStatus syncStatus;
@override final  DateTime? createdAt;
@override final  bool isPendingDeletion;
@override final  bool isDirty;

/// Create a copy of TodoTagEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoTagEntityCopyWith<_TodoTagEntity> get copyWith => __$TodoTagEntityCopyWithImpl<_TodoTagEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoTagEntity&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isPendingDeletion, isPendingDeletion) || other.isPendingDeletion == isPendingDeletion)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty));
}


@override
int get hashCode => Object.hash(runtimeType,localId,id,name,color,syncStatus,createdAt,isPendingDeletion,isDirty);

@override
String toString() {
  return 'TodoTagEntity(localId: $localId, id: $id, name: $name, color: $color, syncStatus: $syncStatus, createdAt: $createdAt, isPendingDeletion: $isPendingDeletion, isDirty: $isDirty)';
}


}

/// @nodoc
abstract mixin class _$TodoTagEntityCopyWith<$Res> implements $TodoTagEntityCopyWith<$Res> {
  factory _$TodoTagEntityCopyWith(_TodoTagEntity value, $Res Function(_TodoTagEntity) _then) = __$TodoTagEntityCopyWithImpl;
@override @useResult
$Res call({
 int localId, String? id, String name, String? color, SyncStatus syncStatus, DateTime? createdAt, bool isPendingDeletion, bool isDirty
});




}
/// @nodoc
class __$TodoTagEntityCopyWithImpl<$Res>
    implements _$TodoTagEntityCopyWith<$Res> {
  __$TodoTagEntityCopyWithImpl(this._self, this._then);

  final _TodoTagEntity _self;
  final $Res Function(_TodoTagEntity) _then;

/// Create a copy of TodoTagEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localId = null,Object? id = freezed,Object? name = null,Object? color = freezed,Object? syncStatus = null,Object? createdAt = freezed,Object? isPendingDeletion = null,Object? isDirty = null,}) {
  return _then(_TodoTagEntity(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPendingDeletion: null == isPendingDeletion ? _self.isPendingDeletion : isPendingDeletion // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
