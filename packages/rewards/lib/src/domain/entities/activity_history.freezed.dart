// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActivityHistory {

 String get id; String get activityId; String? get activityName; int get pointsEarned; DateTime? get createdAt;
/// Create a copy of ActivityHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityHistoryCopyWith<ActivityHistory> get copyWith => _$ActivityHistoryCopyWithImpl<ActivityHistory>(this as ActivityHistory, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ActivityHistory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityHistory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.activityName, _this.activityName) || other.activityName == _this.activityName)&&(identical(other.pointsEarned, _this.pointsEarned) || other.pointsEarned == _this.pointsEarned)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as ActivityHistory;
  return Object.hash(runtimeType,_this.id,_this.activityId,_this.activityName,_this.pointsEarned,_this.createdAt);
}

@override
String toString() {
  final _this = this as ActivityHistory;
  return 'ActivityHistory(id: ${_this.id}, activityId: ${_this.activityId}, activityName: ${_this.activityName}, pointsEarned: ${_this.pointsEarned}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ActivityHistoryCopyWith<$Res>  {
  factory $ActivityHistoryCopyWith(ActivityHistory value, $Res Function(ActivityHistory) _then) = _$ActivityHistoryCopyWithImpl;
@useResult
$Res call({
 String id, String activityId, String? activityName, int pointsEarned, DateTime? createdAt
});




}
/// @nodoc
class _$ActivityHistoryCopyWithImpl<$Res>
    implements $ActivityHistoryCopyWith<$Res> {
  _$ActivityHistoryCopyWithImpl(this._self, this._then);

  final ActivityHistory _self;
  final $Res Function(ActivityHistory) _then;

/// Create a copy of ActivityHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? activityId = null,Object? activityName = freezed,Object? pointsEarned = null,Object? createdAt = freezed,}) {
  return _then(ActivityHistory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,activityName: freezed == activityName ? _self.activityName : activityName // ignore: cast_nullable_to_non_nullable
as String?,pointsEarned: null == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityHistory].
extension ActivityHistoryPatterns on ActivityHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityHistory value)  $default,){
final _that = this;
switch (_that) {
case _ActivityHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityHistory value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String activityId,  String? activityName,  int pointsEarned,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityHistory() when $default != null:
return $default(_that.id,_that.activityId,_that.activityName,_that.pointsEarned,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String activityId,  String? activityName,  int pointsEarned,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ActivityHistory():
return $default(_that.id,_that.activityId,_that.activityName,_that.pointsEarned,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String activityId,  String? activityName,  int pointsEarned,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ActivityHistory() when $default != null:
return $default(_that.id,_that.activityId,_that.activityName,_that.pointsEarned,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _ActivityHistory implements ActivityHistory {
  const _ActivityHistory({required this.id, required this.activityId, this.activityName, required this.pointsEarned, this.createdAt});


@override final  String id;
@override final  String activityId;
@override final  String? activityName;
@override final  int pointsEarned;
@override final  DateTime? createdAt;

/// Create a copy of ActivityHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityHistoryCopyWith<_ActivityHistory> get copyWith => __$ActivityHistoryCopyWithImpl<_ActivityHistory>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityHistory&&(identical(other.id, id) || other.id == id)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.activityName, activityName) || other.activityName == activityName)&&(identical(other.pointsEarned, pointsEarned) || other.pointsEarned == pointsEarned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,activityId,activityName,pointsEarned,createdAt);
}

@override
String toString() {
    return 'ActivityHistory(id: $id, activityId: $activityId, activityName: $activityName, pointsEarned: $pointsEarned, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ActivityHistoryCopyWith<$Res> implements $ActivityHistoryCopyWith<$Res> {
  factory _$ActivityHistoryCopyWith(_ActivityHistory value, $Res Function(_ActivityHistory) _then) = __$ActivityHistoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String activityId, String? activityName, int pointsEarned, DateTime? createdAt
});




}
/// @nodoc
class __$ActivityHistoryCopyWithImpl<$Res>
    implements _$ActivityHistoryCopyWith<$Res> {
  __$ActivityHistoryCopyWithImpl(this._self, this._then);

  final _ActivityHistory _self;
  final $Res Function(_ActivityHistory) _then;

/// Create a copy of ActivityHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? activityId = null,Object? activityName = freezed,Object? pointsEarned = null,Object? createdAt = freezed,}) {
  return _then(_ActivityHistory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,activityName: freezed == activityName ? _self.activityName : activityName // ignore: cast_nullable_to_non_nullable
as String?,pointsEarned: null == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
