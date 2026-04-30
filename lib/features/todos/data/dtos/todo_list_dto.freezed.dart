// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_list_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoListDto {

 String get id; String get title; String? get color;@JsonKey(name: 'is_default') bool get isDefault;@JsonKey(name: 'sync_status') String get syncStatus;@JsonKey(name: 'sync_status_display') String? get syncStatusDisplay;@JsonKey(name: 'last_synced_at') String? get lastSyncedAt;@JsonKey(name: 'task_count') int get taskCount;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;
/// Create a copy of TodoListDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoListDtoCopyWith<TodoListDto> get copyWith => _$TodoListDtoCopyWithImpl<TodoListDto>(this as TodoListDto, _$identity);

  /// Serializes this TodoListDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoListDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.color, color) || other.color == color)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.syncStatusDisplay, syncStatusDisplay) || other.syncStatusDisplay == syncStatusDisplay)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.taskCount, taskCount) || other.taskCount == taskCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,color,isDefault,syncStatus,syncStatusDisplay,lastSyncedAt,taskCount,createdAt,updatedAt);

@override
String toString() {
  return 'TodoListDto(id: $id, title: $title, color: $color, isDefault: $isDefault, syncStatus: $syncStatus, syncStatusDisplay: $syncStatusDisplay, lastSyncedAt: $lastSyncedAt, taskCount: $taskCount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TodoListDtoCopyWith<$Res>  {
  factory $TodoListDtoCopyWith(TodoListDto value, $Res Function(TodoListDto) _then) = _$TodoListDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? color,@JsonKey(name: 'is_default') bool isDefault,@JsonKey(name: 'sync_status') String syncStatus,@JsonKey(name: 'sync_status_display') String? syncStatusDisplay,@JsonKey(name: 'last_synced_at') String? lastSyncedAt,@JsonKey(name: 'task_count') int taskCount,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class _$TodoListDtoCopyWithImpl<$Res>
    implements $TodoListDtoCopyWith<$Res> {
  _$TodoListDtoCopyWithImpl(this._self, this._then);

  final TodoListDto _self;
  final $Res Function(TodoListDto) _then;

/// Create a copy of TodoListDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? color = freezed,Object? isDefault = null,Object? syncStatus = null,Object? syncStatusDisplay = freezed,Object? lastSyncedAt = freezed,Object? taskCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as String,syncStatusDisplay: freezed == syncStatusDisplay ? _self.syncStatusDisplay : syncStatusDisplay // ignore: cast_nullable_to_non_nullable
as String?,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as String?,taskCount: null == taskCount ? _self.taskCount : taskCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoListDto].
extension TodoListDtoPatterns on TodoListDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoListDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoListDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoListDto value)  $default,){
final _that = this;
switch (_that) {
case _TodoListDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoListDto value)?  $default,){
final _that = this;
switch (_that) {
case _TodoListDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? color, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'sync_status')  String syncStatus, @JsonKey(name: 'sync_status_display')  String? syncStatusDisplay, @JsonKey(name: 'last_synced_at')  String? lastSyncedAt, @JsonKey(name: 'task_count')  int taskCount, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoListDto() when $default != null:
return $default(_that.id,_that.title,_that.color,_that.isDefault,_that.syncStatus,_that.syncStatusDisplay,_that.lastSyncedAt,_that.taskCount,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? color, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'sync_status')  String syncStatus, @JsonKey(name: 'sync_status_display')  String? syncStatusDisplay, @JsonKey(name: 'last_synced_at')  String? lastSyncedAt, @JsonKey(name: 'task_count')  int taskCount, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TodoListDto():
return $default(_that.id,_that.title,_that.color,_that.isDefault,_that.syncStatus,_that.syncStatusDisplay,_that.lastSyncedAt,_that.taskCount,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? color, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'sync_status')  String syncStatus, @JsonKey(name: 'sync_status_display')  String? syncStatusDisplay, @JsonKey(name: 'last_synced_at')  String? lastSyncedAt, @JsonKey(name: 'task_count')  int taskCount, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TodoListDto() when $default != null:
return $default(_that.id,_that.title,_that.color,_that.isDefault,_that.syncStatus,_that.syncStatusDisplay,_that.lastSyncedAt,_that.taskCount,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodoListDto implements TodoListDto {
  const _TodoListDto({required this.id, required this.title, required this.color, @JsonKey(name: 'is_default') required this.isDefault, @JsonKey(name: 'sync_status') required this.syncStatus, @JsonKey(name: 'sync_status_display') required this.syncStatusDisplay, @JsonKey(name: 'last_synced_at') required this.lastSyncedAt, @JsonKey(name: 'task_count') required this.taskCount, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _TodoListDto.fromJson(Map<String, dynamic> json) => _$TodoListDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? color;
@override@JsonKey(name: 'is_default') final  bool isDefault;
@override@JsonKey(name: 'sync_status') final  String syncStatus;
@override@JsonKey(name: 'sync_status_display') final  String? syncStatusDisplay;
@override@JsonKey(name: 'last_synced_at') final  String? lastSyncedAt;
@override@JsonKey(name: 'task_count') final  int taskCount;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;

/// Create a copy of TodoListDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoListDtoCopyWith<_TodoListDto> get copyWith => __$TodoListDtoCopyWithImpl<_TodoListDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoListDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoListDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.color, color) || other.color == color)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.syncStatusDisplay, syncStatusDisplay) || other.syncStatusDisplay == syncStatusDisplay)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.taskCount, taskCount) || other.taskCount == taskCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,color,isDefault,syncStatus,syncStatusDisplay,lastSyncedAt,taskCount,createdAt,updatedAt);

@override
String toString() {
  return 'TodoListDto(id: $id, title: $title, color: $color, isDefault: $isDefault, syncStatus: $syncStatus, syncStatusDisplay: $syncStatusDisplay, lastSyncedAt: $lastSyncedAt, taskCount: $taskCount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TodoListDtoCopyWith<$Res> implements $TodoListDtoCopyWith<$Res> {
  factory _$TodoListDtoCopyWith(_TodoListDto value, $Res Function(_TodoListDto) _then) = __$TodoListDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? color,@JsonKey(name: 'is_default') bool isDefault,@JsonKey(name: 'sync_status') String syncStatus,@JsonKey(name: 'sync_status_display') String? syncStatusDisplay,@JsonKey(name: 'last_synced_at') String? lastSyncedAt,@JsonKey(name: 'task_count') int taskCount,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class __$TodoListDtoCopyWithImpl<$Res>
    implements _$TodoListDtoCopyWith<$Res> {
  __$TodoListDtoCopyWithImpl(this._self, this._then);

  final _TodoListDto _self;
  final $Res Function(_TodoListDto) _then;

/// Create a copy of TodoListDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? color = freezed,Object? isDefault = null,Object? syncStatus = null,Object? syncStatusDisplay = freezed,Object? lastSyncedAt = freezed,Object? taskCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TodoListDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as String,syncStatusDisplay: freezed == syncStatusDisplay ? _self.syncStatusDisplay : syncStatusDisplay // ignore: cast_nullable_to_non_nullable
as String?,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as String?,taskCount: null == taskCount ? _self.taskCount : taskCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
