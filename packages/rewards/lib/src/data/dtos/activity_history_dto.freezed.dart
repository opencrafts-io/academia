// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_history_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityHistoryDto {

 String get id;@JsonKey(name: 'activity_id') String get activityId;@JsonKey(name: 'activity_name') String? get activityName;@JsonKey(name: 'points_earned') int get pointsEarned;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of ActivityHistoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityHistoryDtoCopyWith<ActivityHistoryDto> get copyWith => _$ActivityHistoryDtoCopyWithImpl<ActivityHistoryDto>(this as ActivityHistoryDto, _$identity);

  /// Serializes this ActivityHistoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityHistoryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityHistoryDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.activityName, _this.activityName) || other.activityName == _this.activityName)&&(identical(other.pointsEarned, _this.pointsEarned) || other.pointsEarned == _this.pointsEarned)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityHistoryDto;
  return Object.hash(runtimeType,_this.id,_this.activityId,_this.activityName,_this.pointsEarned,_this.createdAt);
}

@override
String toString() {
  final _this = this as ActivityHistoryDto;
  return 'ActivityHistoryDto(id: ${_this.id}, activityId: ${_this.activityId}, activityName: ${_this.activityName}, pointsEarned: ${_this.pointsEarned}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ActivityHistoryDtoCopyWith<$Res>  {
  factory $ActivityHistoryDtoCopyWith(ActivityHistoryDto value, $Res Function(ActivityHistoryDto) _then) = _$ActivityHistoryDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'activity_id') String activityId,@JsonKey(name: 'activity_name') String? activityName,@JsonKey(name: 'points_earned') int pointsEarned,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$ActivityHistoryDtoCopyWithImpl<$Res>
    implements $ActivityHistoryDtoCopyWith<$Res> {
  _$ActivityHistoryDtoCopyWithImpl(this._self, this._then);

  final ActivityHistoryDto _self;
  final $Res Function(ActivityHistoryDto) _then;

/// Create a copy of ActivityHistoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? activityId = null,Object? activityName = freezed,Object? pointsEarned = null,Object? createdAt = freezed,}) {
  return _then(ActivityHistoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,activityName: freezed == activityName ? _self.activityName : activityName // ignore: cast_nullable_to_non_nullable
as String?,pointsEarned: null == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityHistoryDto].
extension ActivityHistoryDtoPatterns on ActivityHistoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityHistoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityHistoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityHistoryDto value)  $default,){
final _that = this;
switch (_that) {
case _ActivityHistoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityHistoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityHistoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'activity_name')  String? activityName, @JsonKey(name: 'points_earned')  int pointsEarned, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityHistoryDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'activity_name')  String? activityName, @JsonKey(name: 'points_earned')  int pointsEarned, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ActivityHistoryDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'activity_name')  String? activityName, @JsonKey(name: 'points_earned')  int pointsEarned, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ActivityHistoryDto() when $default != null:
return $default(_that.id,_that.activityId,_that.activityName,_that.pointsEarned,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityHistoryDto extends ActivityHistoryDto {
  const _ActivityHistoryDto({this.id = '', @JsonKey(name: 'activity_id') this.activityId = '', @JsonKey(name: 'activity_name') this.activityName, @JsonKey(name: 'points_earned') this.pointsEarned = 0, @JsonKey(name: 'created_at') this.createdAt}): super._();
  factory _ActivityHistoryDto.fromJson(Map<String, dynamic> json) => _$ActivityHistoryDtoFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey(name: 'activity_id') final  String activityId;
@override@JsonKey(name: 'activity_name') final  String? activityName;
@override@JsonKey(name: 'points_earned') final  int pointsEarned;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of ActivityHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityHistoryDtoCopyWith<_ActivityHistoryDto> get copyWith => __$ActivityHistoryDtoCopyWithImpl<_ActivityHistoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityHistoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityHistoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.activityName, activityName) || other.activityName == activityName)&&(identical(other.pointsEarned, pointsEarned) || other.pointsEarned == pointsEarned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,activityId,activityName,pointsEarned,createdAt);
}

@override
String toString() {
    return 'ActivityHistoryDto(id: $id, activityId: $activityId, activityName: $activityName, pointsEarned: $pointsEarned, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ActivityHistoryDtoCopyWith<$Res> implements $ActivityHistoryDtoCopyWith<$Res> {
  factory _$ActivityHistoryDtoCopyWith(_ActivityHistoryDto value, $Res Function(_ActivityHistoryDto) _then) = __$ActivityHistoryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'activity_id') String activityId,@JsonKey(name: 'activity_name') String? activityName,@JsonKey(name: 'points_earned') int pointsEarned,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$ActivityHistoryDtoCopyWithImpl<$Res>
    implements _$ActivityHistoryDtoCopyWith<$Res> {
  __$ActivityHistoryDtoCopyWithImpl(this._self, this._then);

  final _ActivityHistoryDto _self;
  final $Res Function(_ActivityHistoryDto) _then;

/// Create a copy of ActivityHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? activityId = null,Object? activityName = freezed,Object? pointsEarned = null,Object? createdAt = freezed,}) {
  return _then(_ActivityHistoryDto(
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
