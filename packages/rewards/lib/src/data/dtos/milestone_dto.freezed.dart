// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'milestone_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MilestoneDto {

 String get id;@JsonKey(name: 'activity_id') String get activityId;@JsonKey(name: 'days_required') int get daysRequired;@JsonKey(name: 'bonus_points') int get bonusPoints; String get title; String get description;
/// Create a copy of MilestoneDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MilestoneDtoCopyWith<MilestoneDto> get copyWith => _$MilestoneDtoCopyWithImpl<MilestoneDto>(this as MilestoneDto, _$identity);

  /// Serializes this MilestoneDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MilestoneDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MilestoneDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.daysRequired, _this.daysRequired) || other.daysRequired == _this.daysRequired)&&(identical(other.bonusPoints, _this.bonusPoints) || other.bonusPoints == _this.bonusPoints)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MilestoneDto;
  return Object.hash(runtimeType,_this.id,_this.activityId,_this.daysRequired,_this.bonusPoints,_this.title,_this.description);
}

@override
String toString() {
  final _this = this as MilestoneDto;
  return 'MilestoneDto(id: ${_this.id}, activityId: ${_this.activityId}, daysRequired: ${_this.daysRequired}, bonusPoints: ${_this.bonusPoints}, title: ${_this.title}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $MilestoneDtoCopyWith<$Res>  {
  factory $MilestoneDtoCopyWith(MilestoneDto value, $Res Function(MilestoneDto) _then) = _$MilestoneDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'activity_id') String activityId,@JsonKey(name: 'days_required') int daysRequired,@JsonKey(name: 'bonus_points') int bonusPoints, String title, String description
});




}
/// @nodoc
class _$MilestoneDtoCopyWithImpl<$Res>
    implements $MilestoneDtoCopyWith<$Res> {
  _$MilestoneDtoCopyWithImpl(this._self, this._then);

  final MilestoneDto _self;
  final $Res Function(MilestoneDto) _then;

/// Create a copy of MilestoneDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? activityId = null,Object? daysRequired = null,Object? bonusPoints = null,Object? title = null,Object? description = null,}) {
  return _then(MilestoneDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,daysRequired: null == daysRequired ? _self.daysRequired : daysRequired // ignore: cast_nullable_to_non_nullable
as int,bonusPoints: null == bonusPoints ? _self.bonusPoints : bonusPoints // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MilestoneDto].
extension MilestoneDtoPatterns on MilestoneDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MilestoneDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MilestoneDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MilestoneDto value)  $default,){
final _that = this;
switch (_that) {
case _MilestoneDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MilestoneDto value)?  $default,){
final _that = this;
switch (_that) {
case _MilestoneDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'days_required')  int daysRequired, @JsonKey(name: 'bonus_points')  int bonusPoints,  String title,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MilestoneDto() when $default != null:
return $default(_that.id,_that.activityId,_that.daysRequired,_that.bonusPoints,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'days_required')  int daysRequired, @JsonKey(name: 'bonus_points')  int bonusPoints,  String title,  String description)  $default,) {final _that = this;
switch (_that) {
case _MilestoneDto():
return $default(_that.id,_that.activityId,_that.daysRequired,_that.bonusPoints,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'days_required')  int daysRequired, @JsonKey(name: 'bonus_points')  int bonusPoints,  String title,  String description)?  $default,) {final _that = this;
switch (_that) {
case _MilestoneDto() when $default != null:
return $default(_that.id,_that.activityId,_that.daysRequired,_that.bonusPoints,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MilestoneDto extends MilestoneDto {
  const _MilestoneDto({this.id = '', @JsonKey(name: 'activity_id') this.activityId = '', @JsonKey(name: 'days_required') this.daysRequired = 0, @JsonKey(name: 'bonus_points') this.bonusPoints = 0, this.title = '', this.description = ''}): super._();
  factory _MilestoneDto.fromJson(Map<String, dynamic> json) => _$MilestoneDtoFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey(name: 'activity_id') final  String activityId;
@override@JsonKey(name: 'days_required') final  int daysRequired;
@override@JsonKey(name: 'bonus_points') final  int bonusPoints;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;

/// Create a copy of MilestoneDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MilestoneDtoCopyWith<_MilestoneDto> get copyWith => __$MilestoneDtoCopyWithImpl<_MilestoneDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MilestoneDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MilestoneDto&&(identical(other.id, id) || other.id == id)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.daysRequired, daysRequired) || other.daysRequired == daysRequired)&&(identical(other.bonusPoints, bonusPoints) || other.bonusPoints == bonusPoints)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,activityId,daysRequired,bonusPoints,title,description);
}

@override
String toString() {
    return 'MilestoneDto(id: $id, activityId: $activityId, daysRequired: $daysRequired, bonusPoints: $bonusPoints, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$MilestoneDtoCopyWith<$Res> implements $MilestoneDtoCopyWith<$Res> {
  factory _$MilestoneDtoCopyWith(_MilestoneDto value, $Res Function(_MilestoneDto) _then) = __$MilestoneDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'activity_id') String activityId,@JsonKey(name: 'days_required') int daysRequired,@JsonKey(name: 'bonus_points') int bonusPoints, String title, String description
});




}
/// @nodoc
class __$MilestoneDtoCopyWithImpl<$Res>
    implements _$MilestoneDtoCopyWith<$Res> {
  __$MilestoneDtoCopyWithImpl(this._self, this._then);

  final _MilestoneDto _self;
  final $Res Function(_MilestoneDto) _then;

/// Create a copy of MilestoneDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? activityId = null,Object? daysRequired = null,Object? bonusPoints = null,Object? title = null,Object? description = null,}) {
  return _then(_MilestoneDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,daysRequired: null == daysRequired ? _self.daysRequired : daysRequired // ignore: cast_nullable_to_non_nullable
as int,bonusPoints: null == bonusPoints ? _self.bonusPoints : bonusPoints // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
