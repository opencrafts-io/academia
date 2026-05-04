// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_list_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoListEntity {

 int get localId; String? get id; String get title; int? get color; bool get isDefault; SyncStatus get syncStatus; int get taskCount; DateTime? get lastSyncedAt; DateTime? get createdAt; DateTime? get updatedAt; bool get isPendingDeletion;
/// Create a copy of TodoListEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoListEntityCopyWith<TodoListEntity> get copyWith => _$TodoListEntityCopyWithImpl<TodoListEntity>(this as TodoListEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoListEntity&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.color, color) || other.color == color)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.taskCount, taskCount) || other.taskCount == taskCount)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isPendingDeletion, isPendingDeletion) || other.isPendingDeletion == isPendingDeletion));
}


@override
int get hashCode => Object.hash(runtimeType,localId,id,title,color,isDefault,syncStatus,taskCount,lastSyncedAt,createdAt,updatedAt,isPendingDeletion);

@override
String toString() {
  return 'TodoListEntity(localId: $localId, id: $id, title: $title, color: $color, isDefault: $isDefault, syncStatus: $syncStatus, taskCount: $taskCount, lastSyncedAt: $lastSyncedAt, createdAt: $createdAt, updatedAt: $updatedAt, isPendingDeletion: $isPendingDeletion)';
}


}

/// @nodoc
abstract mixin class $TodoListEntityCopyWith<$Res>  {
  factory $TodoListEntityCopyWith(TodoListEntity value, $Res Function(TodoListEntity) _then) = _$TodoListEntityCopyWithImpl;
@useResult
$Res call({
 int localId, String? id, String title, int? color, bool isDefault, SyncStatus syncStatus, int taskCount, DateTime? lastSyncedAt, DateTime? createdAt, DateTime? updatedAt, bool isPendingDeletion
});




}
/// @nodoc
class _$TodoListEntityCopyWithImpl<$Res>
    implements $TodoListEntityCopyWith<$Res> {
  _$TodoListEntityCopyWithImpl(this._self, this._then);

  final TodoListEntity _self;
  final $Res Function(TodoListEntity) _then;

/// Create a copy of TodoListEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localId = null,Object? id = freezed,Object? title = null,Object? color = freezed,Object? isDefault = null,Object? syncStatus = null,Object? taskCount = null,Object? lastSyncedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isPendingDeletion = null,}) {
  return _then(_self.copyWith(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,taskCount: null == taskCount ? _self.taskCount : taskCount // ignore: cast_nullable_to_non_nullable
as int,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPendingDeletion: null == isPendingDeletion ? _self.isPendingDeletion : isPendingDeletion // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoListEntity].
extension TodoListEntityPatterns on TodoListEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoListEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoListEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoListEntity value)  $default,){
final _that = this;
switch (_that) {
case _TodoListEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoListEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TodoListEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int localId,  String? id,  String title,  int? color,  bool isDefault,  SyncStatus syncStatus,  int taskCount,  DateTime? lastSyncedAt,  DateTime? createdAt,  DateTime? updatedAt,  bool isPendingDeletion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoListEntity() when $default != null:
return $default(_that.localId,_that.id,_that.title,_that.color,_that.isDefault,_that.syncStatus,_that.taskCount,_that.lastSyncedAt,_that.createdAt,_that.updatedAt,_that.isPendingDeletion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int localId,  String? id,  String title,  int? color,  bool isDefault,  SyncStatus syncStatus,  int taskCount,  DateTime? lastSyncedAt,  DateTime? createdAt,  DateTime? updatedAt,  bool isPendingDeletion)  $default,) {final _that = this;
switch (_that) {
case _TodoListEntity():
return $default(_that.localId,_that.id,_that.title,_that.color,_that.isDefault,_that.syncStatus,_that.taskCount,_that.lastSyncedAt,_that.createdAt,_that.updatedAt,_that.isPendingDeletion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int localId,  String? id,  String title,  int? color,  bool isDefault,  SyncStatus syncStatus,  int taskCount,  DateTime? lastSyncedAt,  DateTime? createdAt,  DateTime? updatedAt,  bool isPendingDeletion)?  $default,) {final _that = this;
switch (_that) {
case _TodoListEntity() when $default != null:
return $default(_that.localId,_that.id,_that.title,_that.color,_that.isDefault,_that.syncStatus,_that.taskCount,_that.lastSyncedAt,_that.createdAt,_that.updatedAt,_that.isPendingDeletion);case _:
  return null;

}
}

}

/// @nodoc


class _TodoListEntity implements TodoListEntity {
  const _TodoListEntity({required this.localId, this.id, required this.title, this.color, required this.isDefault, required this.syncStatus, required this.taskCount, this.lastSyncedAt, this.createdAt, this.updatedAt, required this.isPendingDeletion});
  

@override final  int localId;
@override final  String? id;
@override final  String title;
@override final  int? color;
@override final  bool isDefault;
@override final  SyncStatus syncStatus;
@override final  int taskCount;
@override final  DateTime? lastSyncedAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  bool isPendingDeletion;

/// Create a copy of TodoListEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoListEntityCopyWith<_TodoListEntity> get copyWith => __$TodoListEntityCopyWithImpl<_TodoListEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoListEntity&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.color, color) || other.color == color)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.taskCount, taskCount) || other.taskCount == taskCount)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isPendingDeletion, isPendingDeletion) || other.isPendingDeletion == isPendingDeletion));
}


@override
int get hashCode => Object.hash(runtimeType,localId,id,title,color,isDefault,syncStatus,taskCount,lastSyncedAt,createdAt,updatedAt,isPendingDeletion);

@override
String toString() {
  return 'TodoListEntity(localId: $localId, id: $id, title: $title, color: $color, isDefault: $isDefault, syncStatus: $syncStatus, taskCount: $taskCount, lastSyncedAt: $lastSyncedAt, createdAt: $createdAt, updatedAt: $updatedAt, isPendingDeletion: $isPendingDeletion)';
}


}

/// @nodoc
abstract mixin class _$TodoListEntityCopyWith<$Res> implements $TodoListEntityCopyWith<$Res> {
  factory _$TodoListEntityCopyWith(_TodoListEntity value, $Res Function(_TodoListEntity) _then) = __$TodoListEntityCopyWithImpl;
@override @useResult
$Res call({
 int localId, String? id, String title, int? color, bool isDefault, SyncStatus syncStatus, int taskCount, DateTime? lastSyncedAt, DateTime? createdAt, DateTime? updatedAt, bool isPendingDeletion
});




}
/// @nodoc
class __$TodoListEntityCopyWithImpl<$Res>
    implements _$TodoListEntityCopyWith<$Res> {
  __$TodoListEntityCopyWithImpl(this._self, this._then);

  final _TodoListEntity _self;
  final $Res Function(_TodoListEntity) _then;

/// Create a copy of TodoListEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localId = null,Object? id = freezed,Object? title = null,Object? color = freezed,Object? isDefault = null,Object? syncStatus = null,Object? taskCount = null,Object? lastSyncedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isPendingDeletion = null,}) {
  return _then(_TodoListEntity(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,taskCount: null == taskCount ? _self.taskCount : taskCount // ignore: cast_nullable_to_non_nullable
as int,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPendingDeletion: null == isPendingDeletion ? _self.isPendingDeletion : isPendingDeletion // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
