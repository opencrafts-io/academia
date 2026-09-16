// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoItemEntity {

 int get localId; String? get id;// Local FK to the parent TodoList
 int get taskListLocalId; String get title; String? get notes; TodoStatus get status; TodoPriority get priority; DateTime? get due; DateTime? get completed; int get subtaskCount; String? get position; bool get hidden;// Resolved tag entities — populated at query time via the junction table
 List<TodoTagEntity> get tags; SyncStatus get syncStatus; DateTime? get lastSyncedAt; DateTime? get createdAt; DateTime? get updatedAt; bool get isPendingDeletion; bool get isDirty;
/// Create a copy of TodoItemEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoItemEntityCopyWith<TodoItemEntity> get copyWith => _$TodoItemEntityCopyWithImpl<TodoItemEntity>(this as TodoItemEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoItemEntity&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.id, id) || other.id == id)&&(identical(other.taskListLocalId, taskListLocalId) || other.taskListLocalId == taskListLocalId)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.due, due) || other.due == due)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.subtaskCount, subtaskCount) || other.subtaskCount == subtaskCount)&&(identical(other.position, position) || other.position == position)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isPendingDeletion, isPendingDeletion) || other.isPendingDeletion == isPendingDeletion)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty));
}


@override
int get hashCode => Object.hashAll([runtimeType,localId,id,taskListLocalId,title,notes,status,priority,due,completed,subtaskCount,position,hidden,const DeepCollectionEquality().hash(tags),syncStatus,lastSyncedAt,createdAt,updatedAt,isPendingDeletion,isDirty]);

@override
String toString() {
  return 'TodoItemEntity(localId: $localId, id: $id, taskListLocalId: $taskListLocalId, title: $title, notes: $notes, status: $status, priority: $priority, due: $due, completed: $completed, subtaskCount: $subtaskCount, position: $position, hidden: $hidden, tags: $tags, syncStatus: $syncStatus, lastSyncedAt: $lastSyncedAt, createdAt: $createdAt, updatedAt: $updatedAt, isPendingDeletion: $isPendingDeletion, isDirty: $isDirty)';
}


}

/// @nodoc
abstract mixin class $TodoItemEntityCopyWith<$Res>  {
  factory $TodoItemEntityCopyWith(TodoItemEntity value, $Res Function(TodoItemEntity) _then) = _$TodoItemEntityCopyWithImpl;
@useResult
$Res call({
 int localId, String? id, int taskListLocalId, String title, String? notes, TodoStatus status, TodoPriority priority, DateTime? due, DateTime? completed, int subtaskCount, String? position, bool hidden, List<TodoTagEntity> tags, SyncStatus syncStatus, DateTime? lastSyncedAt, DateTime? createdAt, DateTime? updatedAt, bool isPendingDeletion, bool isDirty
});




}
/// @nodoc
class _$TodoItemEntityCopyWithImpl<$Res>
    implements $TodoItemEntityCopyWith<$Res> {
  _$TodoItemEntityCopyWithImpl(this._self, this._then);

  final TodoItemEntity _self;
  final $Res Function(TodoItemEntity) _then;

/// Create a copy of TodoItemEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localId = null,Object? id = freezed,Object? taskListLocalId = null,Object? title = null,Object? notes = freezed,Object? status = null,Object? priority = null,Object? due = freezed,Object? completed = freezed,Object? subtaskCount = null,Object? position = freezed,Object? hidden = null,Object? tags = null,Object? syncStatus = null,Object? lastSyncedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isPendingDeletion = null,Object? isDirty = null,}) {
  return _then(_self.copyWith(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,taskListLocalId: null == taskListLocalId ? _self.taskListLocalId : taskListLocalId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodoStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TodoPriority,due: freezed == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as DateTime?,completed: freezed == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as DateTime?,subtaskCount: null == subtaskCount ? _self.subtaskCount : subtaskCount // ignore: cast_nullable_to_non_nullable
as int,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TodoTagEntity>,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPendingDeletion: null == isPendingDeletion ? _self.isPendingDeletion : isPendingDeletion // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoItemEntity].
extension TodoItemEntityPatterns on TodoItemEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoItemEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoItemEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoItemEntity value)  $default,){
final _that = this;
switch (_that) {
case _TodoItemEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoItemEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TodoItemEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int localId,  String? id,  int taskListLocalId,  String title,  String? notes,  TodoStatus status,  TodoPriority priority,  DateTime? due,  DateTime? completed,  int subtaskCount,  String? position,  bool hidden,  List<TodoTagEntity> tags,  SyncStatus syncStatus,  DateTime? lastSyncedAt,  DateTime? createdAt,  DateTime? updatedAt,  bool isPendingDeletion,  bool isDirty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoItemEntity() when $default != null:
return $default(_that.localId,_that.id,_that.taskListLocalId,_that.title,_that.notes,_that.status,_that.priority,_that.due,_that.completed,_that.subtaskCount,_that.position,_that.hidden,_that.tags,_that.syncStatus,_that.lastSyncedAt,_that.createdAt,_that.updatedAt,_that.isPendingDeletion,_that.isDirty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int localId,  String? id,  int taskListLocalId,  String title,  String? notes,  TodoStatus status,  TodoPriority priority,  DateTime? due,  DateTime? completed,  int subtaskCount,  String? position,  bool hidden,  List<TodoTagEntity> tags,  SyncStatus syncStatus,  DateTime? lastSyncedAt,  DateTime? createdAt,  DateTime? updatedAt,  bool isPendingDeletion,  bool isDirty)  $default,) {final _that = this;
switch (_that) {
case _TodoItemEntity():
return $default(_that.localId,_that.id,_that.taskListLocalId,_that.title,_that.notes,_that.status,_that.priority,_that.due,_that.completed,_that.subtaskCount,_that.position,_that.hidden,_that.tags,_that.syncStatus,_that.lastSyncedAt,_that.createdAt,_that.updatedAt,_that.isPendingDeletion,_that.isDirty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int localId,  String? id,  int taskListLocalId,  String title,  String? notes,  TodoStatus status,  TodoPriority priority,  DateTime? due,  DateTime? completed,  int subtaskCount,  String? position,  bool hidden,  List<TodoTagEntity> tags,  SyncStatus syncStatus,  DateTime? lastSyncedAt,  DateTime? createdAt,  DateTime? updatedAt,  bool isPendingDeletion,  bool isDirty)?  $default,) {final _that = this;
switch (_that) {
case _TodoItemEntity() when $default != null:
return $default(_that.localId,_that.id,_that.taskListLocalId,_that.title,_that.notes,_that.status,_that.priority,_that.due,_that.completed,_that.subtaskCount,_that.position,_that.hidden,_that.tags,_that.syncStatus,_that.lastSyncedAt,_that.createdAt,_that.updatedAt,_that.isPendingDeletion,_that.isDirty);case _:
  return null;

}
}

}

/// @nodoc


class _TodoItemEntity implements TodoItemEntity {
  const _TodoItemEntity({required this.localId, this.id, required this.taskListLocalId, required this.title, this.notes, required this.status, required this.priority, this.due, this.completed, required this.subtaskCount, this.position, required this.hidden, final  List<TodoTagEntity> tags = const [], required this.syncStatus, this.lastSyncedAt, this.createdAt, this.updatedAt, required this.isPendingDeletion, required this.isDirty}): _tags = tags;
  

@override final  int localId;
@override final  String? id;
// Local FK to the parent TodoList
@override final  int taskListLocalId;
@override final  String title;
@override final  String? notes;
@override final  TodoStatus status;
@override final  TodoPriority priority;
@override final  DateTime? due;
@override final  DateTime? completed;
@override final  int subtaskCount;
@override final  String? position;
@override final  bool hidden;
// Resolved tag entities — populated at query time via the junction table
 final  List<TodoTagEntity> _tags;
// Resolved tag entities — populated at query time via the junction table
@override@JsonKey() List<TodoTagEntity> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  SyncStatus syncStatus;
@override final  DateTime? lastSyncedAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  bool isPendingDeletion;
@override final  bool isDirty;

/// Create a copy of TodoItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoItemEntityCopyWith<_TodoItemEntity> get copyWith => __$TodoItemEntityCopyWithImpl<_TodoItemEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoItemEntity&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.id, id) || other.id == id)&&(identical(other.taskListLocalId, taskListLocalId) || other.taskListLocalId == taskListLocalId)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.due, due) || other.due == due)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.subtaskCount, subtaskCount) || other.subtaskCount == subtaskCount)&&(identical(other.position, position) || other.position == position)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isPendingDeletion, isPendingDeletion) || other.isPendingDeletion == isPendingDeletion)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty));
}


@override
int get hashCode => Object.hashAll([runtimeType,localId,id,taskListLocalId,title,notes,status,priority,due,completed,subtaskCount,position,hidden,const DeepCollectionEquality().hash(_tags),syncStatus,lastSyncedAt,createdAt,updatedAt,isPendingDeletion,isDirty]);

@override
String toString() {
  return 'TodoItemEntity(localId: $localId, id: $id, taskListLocalId: $taskListLocalId, title: $title, notes: $notes, status: $status, priority: $priority, due: $due, completed: $completed, subtaskCount: $subtaskCount, position: $position, hidden: $hidden, tags: $tags, syncStatus: $syncStatus, lastSyncedAt: $lastSyncedAt, createdAt: $createdAt, updatedAt: $updatedAt, isPendingDeletion: $isPendingDeletion, isDirty: $isDirty)';
}


}

/// @nodoc
abstract mixin class _$TodoItemEntityCopyWith<$Res> implements $TodoItemEntityCopyWith<$Res> {
  factory _$TodoItemEntityCopyWith(_TodoItemEntity value, $Res Function(_TodoItemEntity) _then) = __$TodoItemEntityCopyWithImpl;
@override @useResult
$Res call({
 int localId, String? id, int taskListLocalId, String title, String? notes, TodoStatus status, TodoPriority priority, DateTime? due, DateTime? completed, int subtaskCount, String? position, bool hidden, List<TodoTagEntity> tags, SyncStatus syncStatus, DateTime? lastSyncedAt, DateTime? createdAt, DateTime? updatedAt, bool isPendingDeletion, bool isDirty
});




}
/// @nodoc
class __$TodoItemEntityCopyWithImpl<$Res>
    implements _$TodoItemEntityCopyWith<$Res> {
  __$TodoItemEntityCopyWithImpl(this._self, this._then);

  final _TodoItemEntity _self;
  final $Res Function(_TodoItemEntity) _then;

/// Create a copy of TodoItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localId = null,Object? id = freezed,Object? taskListLocalId = null,Object? title = null,Object? notes = freezed,Object? status = null,Object? priority = null,Object? due = freezed,Object? completed = freezed,Object? subtaskCount = null,Object? position = freezed,Object? hidden = null,Object? tags = null,Object? syncStatus = null,Object? lastSyncedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isPendingDeletion = null,Object? isDirty = null,}) {
  return _then(_TodoItemEntity(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,taskListLocalId: null == taskListLocalId ? _self.taskListLocalId : taskListLocalId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodoStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TodoPriority,due: freezed == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as DateTime?,completed: freezed == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as DateTime?,subtaskCount: null == subtaskCount ? _self.subtaskCount : subtaskCount // ignore: cast_nullable_to_non_nullable
as int,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<TodoTagEntity>,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPendingDeletion: null == isPendingDeletion ? _self.isPendingDeletion : isPendingDeletion // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
