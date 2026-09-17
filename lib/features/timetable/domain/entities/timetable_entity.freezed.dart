// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimetableEntity {

/// Local unique identifier (UUID) for offline-first tracking
 String? get id;/// Remote database identifier, null if not yet synced
 int? get serverId; String get name; String get userId; int? get institutionId; bool get isSynced; bool get isDeleted; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of TimetableEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimetableEntityCopyWith<TimetableEntity> get copyWith => _$TimetableEntityCopyWithImpl<TimetableEntity>(this as TimetableEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TimetableEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.serverId, _this.serverId) || other.serverId == _this.serverId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.institutionId, _this.institutionId) || other.institutionId == _this.institutionId)&&(identical(other.isSynced, _this.isSynced) || other.isSynced == _this.isSynced)&&(identical(other.isDeleted, _this.isDeleted) || other.isDeleted == _this.isDeleted)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as TimetableEntity;
  return Object.hash(runtimeType,_this.id,_this.serverId,_this.name,_this.userId,_this.institutionId,_this.isSynced,_this.isDeleted,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as TimetableEntity;
  return 'TimetableEntity(id: ${_this.id}, serverId: ${_this.serverId}, name: ${_this.name}, userId: ${_this.userId}, institutionId: ${_this.institutionId}, isSynced: ${_this.isSynced}, isDeleted: ${_this.isDeleted}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $TimetableEntityCopyWith<$Res>  {
  factory $TimetableEntityCopyWith(TimetableEntity value, $Res Function(TimetableEntity) _then) = _$TimetableEntityCopyWithImpl;
@useResult
$Res call({
 String? id, int? serverId, String name, String userId, int? institutionId, bool isSynced, bool isDeleted, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$TimetableEntityCopyWithImpl<$Res>
    implements $TimetableEntityCopyWith<$Res> {
  _$TimetableEntityCopyWithImpl(this._self, this._then);

  final TimetableEntity _self;
  final $Res Function(TimetableEntity) _then;

/// Create a copy of TimetableEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? serverId = freezed,Object? name = null,Object? userId = null,Object? institutionId = freezed,Object? isSynced = null,Object? isDeleted = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(TimetableEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,institutionId: freezed == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimetableEntity].
extension TimetableEntityPatterns on TimetableEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimetableEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimetableEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimetableEntity value)  $default,){
final _that = this;
switch (_that) {
case _TimetableEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimetableEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TimetableEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  int? serverId,  String name,  String userId,  int? institutionId,  bool isSynced,  bool isDeleted,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimetableEntity() when $default != null:
return $default(_that.id,_that.serverId,_that.name,_that.userId,_that.institutionId,_that.isSynced,_that.isDeleted,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  int? serverId,  String name,  String userId,  int? institutionId,  bool isSynced,  bool isDeleted,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TimetableEntity():
return $default(_that.id,_that.serverId,_that.name,_that.userId,_that.institutionId,_that.isSynced,_that.isDeleted,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  int? serverId,  String name,  String userId,  int? institutionId,  bool isSynced,  bool isDeleted,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TimetableEntity() when $default != null:
return $default(_that.id,_that.serverId,_that.name,_that.userId,_that.institutionId,_that.isSynced,_that.isDeleted,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _TimetableEntity implements TimetableEntity {
  const _TimetableEntity({this.id, this.serverId, required this.name, required this.userId, this.institutionId, this.isSynced = false, this.isDeleted = false, this.createdAt, this.updatedAt});
  

/// Local unique identifier (UUID) for offline-first tracking
@override final  String? id;
/// Remote database identifier, null if not yet synced
@override final  int? serverId;
@override final  String name;
@override final  String userId;
@override final  int? institutionId;
@override@JsonKey() final  bool isSynced;
@override@JsonKey() final  bool isDeleted;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of TimetableEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimetableEntityCopyWith<_TimetableEntity> get copyWith => __$TimetableEntityCopyWithImpl<_TimetableEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimetableEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.name, name) || other.name == name)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,serverId,name,userId,institutionId,isSynced,isDeleted,createdAt,updatedAt);
}

@override
String toString() {
    return 'TimetableEntity(id: $id, serverId: $serverId, name: $name, userId: $userId, institutionId: $institutionId, isSynced: $isSynced, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TimetableEntityCopyWith<$Res> implements $TimetableEntityCopyWith<$Res> {
  factory _$TimetableEntityCopyWith(_TimetableEntity value, $Res Function(_TimetableEntity) _then) = __$TimetableEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, int? serverId, String name, String userId, int? institutionId, bool isSynced, bool isDeleted, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$TimetableEntityCopyWithImpl<$Res>
    implements _$TimetableEntityCopyWith<$Res> {
  __$TimetableEntityCopyWithImpl(this._self, this._then);

  final _TimetableEntity _self;
  final $Res Function(_TimetableEntity) _then;

/// Create a copy of TimetableEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? serverId = freezed,Object? name = null,Object? userId = null,Object? institutionId = freezed,Object? isSynced = null,Object? isDeleted = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TimetableEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,institutionId: freezed == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
