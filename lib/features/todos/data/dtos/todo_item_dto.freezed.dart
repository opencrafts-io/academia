// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoItemDto {

 String? get id;@JsonKey(name: 'task_list') String? get taskList; String get title; String? get notes; String? get status;@JsonKey(name: 'status_display') String? get statusDisplay; String? get priority;@JsonKey(name: 'priority_display') String? get priorityDisplay; String? get due; String? get completed;@JsonKey(name: 'subtask_count') int get subtaskCount; String? get position; bool get hidden;// List of tag UUIDs — resolve to local IDs at mapping time
 List<String> get tags;@JsonKey(name: 'sync_status') String? get syncStatus;@JsonKey(name: 'sync_status_display') String? get syncStatusDisplay;@JsonKey(name: 'last_synced_at') String? get lastSyncedAt;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;
/// Create a copy of TodoItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoItemDtoCopyWith<TodoItemDto> get copyWith => _$TodoItemDtoCopyWithImpl<TodoItemDto>(this as TodoItemDto, _$identity);

  /// Serializes this TodoItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.taskList, taskList) || other.taskList == taskList)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusDisplay, statusDisplay) || other.statusDisplay == statusDisplay)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.priorityDisplay, priorityDisplay) || other.priorityDisplay == priorityDisplay)&&(identical(other.due, due) || other.due == due)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.subtaskCount, subtaskCount) || other.subtaskCount == subtaskCount)&&(identical(other.position, position) || other.position == position)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.syncStatusDisplay, syncStatusDisplay) || other.syncStatusDisplay == syncStatusDisplay)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,taskList,title,notes,status,statusDisplay,priority,priorityDisplay,due,completed,subtaskCount,position,hidden,const DeepCollectionEquality().hash(tags),syncStatus,syncStatusDisplay,lastSyncedAt,createdAt,updatedAt]);

@override
String toString() {
  return 'TodoItemDto(id: $id, taskList: $taskList, title: $title, notes: $notes, status: $status, statusDisplay: $statusDisplay, priority: $priority, priorityDisplay: $priorityDisplay, due: $due, completed: $completed, subtaskCount: $subtaskCount, position: $position, hidden: $hidden, tags: $tags, syncStatus: $syncStatus, syncStatusDisplay: $syncStatusDisplay, lastSyncedAt: $lastSyncedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TodoItemDtoCopyWith<$Res>  {
  factory $TodoItemDtoCopyWith(TodoItemDto value, $Res Function(TodoItemDto) _then) = _$TodoItemDtoCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'task_list') String? taskList, String title, String? notes, String? status,@JsonKey(name: 'status_display') String? statusDisplay, String? priority,@JsonKey(name: 'priority_display') String? priorityDisplay, String? due, String? completed,@JsonKey(name: 'subtask_count') int subtaskCount, String? position, bool hidden, List<String> tags,@JsonKey(name: 'sync_status') String? syncStatus,@JsonKey(name: 'sync_status_display') String? syncStatusDisplay,@JsonKey(name: 'last_synced_at') String? lastSyncedAt,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class _$TodoItemDtoCopyWithImpl<$Res>
    implements $TodoItemDtoCopyWith<$Res> {
  _$TodoItemDtoCopyWithImpl(this._self, this._then);

  final TodoItemDto _self;
  final $Res Function(TodoItemDto) _then;

/// Create a copy of TodoItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? taskList = freezed,Object? title = null,Object? notes = freezed,Object? status = freezed,Object? statusDisplay = freezed,Object? priority = freezed,Object? priorityDisplay = freezed,Object? due = freezed,Object? completed = freezed,Object? subtaskCount = null,Object? position = freezed,Object? hidden = null,Object? tags = null,Object? syncStatus = freezed,Object? syncStatusDisplay = freezed,Object? lastSyncedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,taskList: freezed == taskList ? _self.taskList : taskList // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,statusDisplay: freezed == statusDisplay ? _self.statusDisplay : statusDisplay // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,priorityDisplay: freezed == priorityDisplay ? _self.priorityDisplay : priorityDisplay // ignore: cast_nullable_to_non_nullable
as String?,due: freezed == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as String?,completed: freezed == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as String?,subtaskCount: null == subtaskCount ? _self.subtaskCount : subtaskCount // ignore: cast_nullable_to_non_nullable
as int,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,syncStatus: freezed == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as String?,syncStatusDisplay: freezed == syncStatusDisplay ? _self.syncStatusDisplay : syncStatusDisplay // ignore: cast_nullable_to_non_nullable
as String?,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoItemDto].
extension TodoItemDtoPatterns on TodoItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoItemDto value)  $default,){
final _that = this;
switch (_that) {
case _TodoItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _TodoItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'task_list')  String? taskList,  String title,  String? notes,  String? status, @JsonKey(name: 'status_display')  String? statusDisplay,  String? priority, @JsonKey(name: 'priority_display')  String? priorityDisplay,  String? due,  String? completed, @JsonKey(name: 'subtask_count')  int subtaskCount,  String? position,  bool hidden,  List<String> tags, @JsonKey(name: 'sync_status')  String? syncStatus, @JsonKey(name: 'sync_status_display')  String? syncStatusDisplay, @JsonKey(name: 'last_synced_at')  String? lastSyncedAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoItemDto() when $default != null:
return $default(_that.id,_that.taskList,_that.title,_that.notes,_that.status,_that.statusDisplay,_that.priority,_that.priorityDisplay,_that.due,_that.completed,_that.subtaskCount,_that.position,_that.hidden,_that.tags,_that.syncStatus,_that.syncStatusDisplay,_that.lastSyncedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'task_list')  String? taskList,  String title,  String? notes,  String? status, @JsonKey(name: 'status_display')  String? statusDisplay,  String? priority, @JsonKey(name: 'priority_display')  String? priorityDisplay,  String? due,  String? completed, @JsonKey(name: 'subtask_count')  int subtaskCount,  String? position,  bool hidden,  List<String> tags, @JsonKey(name: 'sync_status')  String? syncStatus, @JsonKey(name: 'sync_status_display')  String? syncStatusDisplay, @JsonKey(name: 'last_synced_at')  String? lastSyncedAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TodoItemDto():
return $default(_that.id,_that.taskList,_that.title,_that.notes,_that.status,_that.statusDisplay,_that.priority,_that.priorityDisplay,_that.due,_that.completed,_that.subtaskCount,_that.position,_that.hidden,_that.tags,_that.syncStatus,_that.syncStatusDisplay,_that.lastSyncedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'task_list')  String? taskList,  String title,  String? notes,  String? status, @JsonKey(name: 'status_display')  String? statusDisplay,  String? priority, @JsonKey(name: 'priority_display')  String? priorityDisplay,  String? due,  String? completed, @JsonKey(name: 'subtask_count')  int subtaskCount,  String? position,  bool hidden,  List<String> tags, @JsonKey(name: 'sync_status')  String? syncStatus, @JsonKey(name: 'sync_status_display')  String? syncStatusDisplay, @JsonKey(name: 'last_synced_at')  String? lastSyncedAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TodoItemDto() when $default != null:
return $default(_that.id,_that.taskList,_that.title,_that.notes,_that.status,_that.statusDisplay,_that.priority,_that.priorityDisplay,_that.due,_that.completed,_that.subtaskCount,_that.position,_that.hidden,_that.tags,_that.syncStatus,_that.syncStatusDisplay,_that.lastSyncedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodoItemDto implements TodoItemDto {
  const _TodoItemDto({required this.id, @JsonKey(name: 'task_list') required this.taskList, required this.title, required this.notes, required this.status, @JsonKey(name: 'status_display') required this.statusDisplay, required this.priority, @JsonKey(name: 'priority_display') required this.priorityDisplay, required this.due, required this.completed, @JsonKey(name: 'subtask_count') required this.subtaskCount, required this.position, required this.hidden, required final  List<String> tags, @JsonKey(name: 'sync_status') required this.syncStatus, @JsonKey(name: 'sync_status_display') required this.syncStatusDisplay, @JsonKey(name: 'last_synced_at') required this.lastSyncedAt, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): _tags = tags;
  factory _TodoItemDto.fromJson(Map<String, dynamic> json) => _$TodoItemDtoFromJson(json);

@override final  String? id;
@override@JsonKey(name: 'task_list') final  String? taskList;
@override final  String title;
@override final  String? notes;
@override final  String? status;
@override@JsonKey(name: 'status_display') final  String? statusDisplay;
@override final  String? priority;
@override@JsonKey(name: 'priority_display') final  String? priorityDisplay;
@override final  String? due;
@override final  String? completed;
@override@JsonKey(name: 'subtask_count') final  int subtaskCount;
@override final  String? position;
@override final  bool hidden;
// List of tag UUIDs — resolve to local IDs at mapping time
 final  List<String> _tags;
// List of tag UUIDs — resolve to local IDs at mapping time
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey(name: 'sync_status') final  String? syncStatus;
@override@JsonKey(name: 'sync_status_display') final  String? syncStatusDisplay;
@override@JsonKey(name: 'last_synced_at') final  String? lastSyncedAt;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;

/// Create a copy of TodoItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoItemDtoCopyWith<_TodoItemDto> get copyWith => __$TodoItemDtoCopyWithImpl<_TodoItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.taskList, taskList) || other.taskList == taskList)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusDisplay, statusDisplay) || other.statusDisplay == statusDisplay)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.priorityDisplay, priorityDisplay) || other.priorityDisplay == priorityDisplay)&&(identical(other.due, due) || other.due == due)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.subtaskCount, subtaskCount) || other.subtaskCount == subtaskCount)&&(identical(other.position, position) || other.position == position)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.syncStatusDisplay, syncStatusDisplay) || other.syncStatusDisplay == syncStatusDisplay)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,taskList,title,notes,status,statusDisplay,priority,priorityDisplay,due,completed,subtaskCount,position,hidden,const DeepCollectionEquality().hash(_tags),syncStatus,syncStatusDisplay,lastSyncedAt,createdAt,updatedAt]);

@override
String toString() {
  return 'TodoItemDto(id: $id, taskList: $taskList, title: $title, notes: $notes, status: $status, statusDisplay: $statusDisplay, priority: $priority, priorityDisplay: $priorityDisplay, due: $due, completed: $completed, subtaskCount: $subtaskCount, position: $position, hidden: $hidden, tags: $tags, syncStatus: $syncStatus, syncStatusDisplay: $syncStatusDisplay, lastSyncedAt: $lastSyncedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TodoItemDtoCopyWith<$Res> implements $TodoItemDtoCopyWith<$Res> {
  factory _$TodoItemDtoCopyWith(_TodoItemDto value, $Res Function(_TodoItemDto) _then) = __$TodoItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'task_list') String? taskList, String title, String? notes, String? status,@JsonKey(name: 'status_display') String? statusDisplay, String? priority,@JsonKey(name: 'priority_display') String? priorityDisplay, String? due, String? completed,@JsonKey(name: 'subtask_count') int subtaskCount, String? position, bool hidden, List<String> tags,@JsonKey(name: 'sync_status') String? syncStatus,@JsonKey(name: 'sync_status_display') String? syncStatusDisplay,@JsonKey(name: 'last_synced_at') String? lastSyncedAt,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class __$TodoItemDtoCopyWithImpl<$Res>
    implements _$TodoItemDtoCopyWith<$Res> {
  __$TodoItemDtoCopyWithImpl(this._self, this._then);

  final _TodoItemDto _self;
  final $Res Function(_TodoItemDto) _then;

/// Create a copy of TodoItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? taskList = freezed,Object? title = null,Object? notes = freezed,Object? status = freezed,Object? statusDisplay = freezed,Object? priority = freezed,Object? priorityDisplay = freezed,Object? due = freezed,Object? completed = freezed,Object? subtaskCount = null,Object? position = freezed,Object? hidden = null,Object? tags = null,Object? syncStatus = freezed,Object? syncStatusDisplay = freezed,Object? lastSyncedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TodoItemDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,taskList: freezed == taskList ? _self.taskList : taskList // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,statusDisplay: freezed == statusDisplay ? _self.statusDisplay : statusDisplay // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,priorityDisplay: freezed == priorityDisplay ? _self.priorityDisplay : priorityDisplay // ignore: cast_nullable_to_non_nullable
as String?,due: freezed == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as String?,completed: freezed == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as String?,subtaskCount: null == subtaskCount ? _self.subtaskCount : subtaskCount // ignore: cast_nullable_to_non_nullable
as int,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,syncStatus: freezed == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as String?,syncStatusDisplay: freezed == syncStatusDisplay ? _self.syncStatusDisplay : syncStatusDisplay // ignore: cast_nullable_to_non_nullable
as String?,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
