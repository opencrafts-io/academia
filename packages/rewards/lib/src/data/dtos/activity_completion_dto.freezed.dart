// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_completion_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityCompletionDto {

 String get id;@JsonKey(name: 'activity_id') String get activityId;@JsonKey(name: 'points_earned') int get pointsEarned;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'already_processed') bool get alreadyProcessed; UserStreakDto? get streak;@JsonKey(name: 'streak_details') UserStreakDto? get streakDetails;@JsonKey(name: 'milestones') List<MilestoneDto> get milestones;@JsonKey(name: 'milestone_details') List<MilestoneDto> get milestoneDetails;
/// Create a copy of ActivityCompletionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityCompletionDtoCopyWith<ActivityCompletionDto> get copyWith => _$ActivityCompletionDtoCopyWithImpl<ActivityCompletionDto>(this as ActivityCompletionDto, _$identity);

  /// Serializes this ActivityCompletionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityCompletionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityCompletionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.pointsEarned, _this.pointsEarned) || other.pointsEarned == _this.pointsEarned)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.alreadyProcessed, _this.alreadyProcessed) || other.alreadyProcessed == _this.alreadyProcessed)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&(identical(other.streakDetails, _this.streakDetails) || other.streakDetails == _this.streakDetails)&&const DeepCollectionEquality().equals(other.milestones, _this.milestones)&&const DeepCollectionEquality().equals(other.milestoneDetails, _this.milestoneDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityCompletionDto;
  return Object.hash(runtimeType,_this.id,_this.activityId,_this.pointsEarned,_this.createdAt,_this.alreadyProcessed,_this.streak,_this.streakDetails,const DeepCollectionEquality().hash(_this.milestones),const DeepCollectionEquality().hash(_this.milestoneDetails));
}

@override
String toString() {
  final _this = this as ActivityCompletionDto;
  return 'ActivityCompletionDto(id: ${_this.id}, activityId: ${_this.activityId}, pointsEarned: ${_this.pointsEarned}, createdAt: ${_this.createdAt}, alreadyProcessed: ${_this.alreadyProcessed}, streak: ${_this.streak}, streakDetails: ${_this.streakDetails}, milestones: ${_this.milestones}, milestoneDetails: ${_this.milestoneDetails})';
}


}

/// @nodoc
abstract mixin class $ActivityCompletionDtoCopyWith<$Res>  {
  factory $ActivityCompletionDtoCopyWith(ActivityCompletionDto value, $Res Function(ActivityCompletionDto) _then) = _$ActivityCompletionDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'activity_id') String activityId,@JsonKey(name: 'points_earned') int pointsEarned,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'already_processed') bool alreadyProcessed, UserStreakDto? streak,@JsonKey(name: 'streak_details') UserStreakDto? streakDetails,@JsonKey(name: 'milestones') List<MilestoneDto> milestones,@JsonKey(name: 'milestone_details') List<MilestoneDto> milestoneDetails
});


$UserStreakDtoCopyWith<$Res>? get streak;$UserStreakDtoCopyWith<$Res>? get streakDetails;

}
/// @nodoc
class _$ActivityCompletionDtoCopyWithImpl<$Res>
    implements $ActivityCompletionDtoCopyWith<$Res> {
  _$ActivityCompletionDtoCopyWithImpl(this._self, this._then);

  final ActivityCompletionDto _self;
  final $Res Function(ActivityCompletionDto) _then;

/// Create a copy of ActivityCompletionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? activityId = null,Object? pointsEarned = null,Object? createdAt = freezed,Object? alreadyProcessed = null,Object? streak = freezed,Object? streakDetails = freezed,Object? milestones = null,Object? milestoneDetails = null,}) {
  return _then(ActivityCompletionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,pointsEarned: null == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,alreadyProcessed: null == alreadyProcessed ? _self.alreadyProcessed : alreadyProcessed // ignore: cast_nullable_to_non_nullable
as bool,streak: freezed == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as UserStreakDto?,streakDetails: freezed == streakDetails ? _self.streakDetails : streakDetails // ignore: cast_nullable_to_non_nullable
as UserStreakDto?,milestones: null == milestones ? _self.milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<MilestoneDto>,milestoneDetails: null == milestoneDetails ? _self.milestoneDetails : milestoneDetails // ignore: cast_nullable_to_non_nullable
as List<MilestoneDto>,
  ));
}
/// Create a copy of ActivityCompletionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserStreakDtoCopyWith<$Res>? get streak {
    if (_self.streak == null) {
    return null;
  }

  return $UserStreakDtoCopyWith<$Res>(_self.streak!, (value) {
    return _then(_self.copyWith(streak: value));
  });
}/// Create a copy of ActivityCompletionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserStreakDtoCopyWith<$Res>? get streakDetails {
    if (_self.streakDetails == null) {
    return null;
  }

  return $UserStreakDtoCopyWith<$Res>(_self.streakDetails!, (value) {
    return _then(_self.copyWith(streakDetails: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActivityCompletionDto].
extension ActivityCompletionDtoPatterns on ActivityCompletionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityCompletionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityCompletionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityCompletionDto value)  $default,){
final _that = this;
switch (_that) {
case _ActivityCompletionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityCompletionDto value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityCompletionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'points_earned')  int pointsEarned, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'already_processed')  bool alreadyProcessed,  UserStreakDto? streak, @JsonKey(name: 'streak_details')  UserStreakDto? streakDetails, @JsonKey(name: 'milestones')  List<MilestoneDto> milestones, @JsonKey(name: 'milestone_details')  List<MilestoneDto> milestoneDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityCompletionDto() when $default != null:
return $default(_that.id,_that.activityId,_that.pointsEarned,_that.createdAt,_that.alreadyProcessed,_that.streak,_that.streakDetails,_that.milestones,_that.milestoneDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'points_earned')  int pointsEarned, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'already_processed')  bool alreadyProcessed,  UserStreakDto? streak, @JsonKey(name: 'streak_details')  UserStreakDto? streakDetails, @JsonKey(name: 'milestones')  List<MilestoneDto> milestones, @JsonKey(name: 'milestone_details')  List<MilestoneDto> milestoneDetails)  $default,) {final _that = this;
switch (_that) {
case _ActivityCompletionDto():
return $default(_that.id,_that.activityId,_that.pointsEarned,_that.createdAt,_that.alreadyProcessed,_that.streak,_that.streakDetails,_that.milestones,_that.milestoneDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'points_earned')  int pointsEarned, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'already_processed')  bool alreadyProcessed,  UserStreakDto? streak, @JsonKey(name: 'streak_details')  UserStreakDto? streakDetails, @JsonKey(name: 'milestones')  List<MilestoneDto> milestones, @JsonKey(name: 'milestone_details')  List<MilestoneDto> milestoneDetails)?  $default,) {final _that = this;
switch (_that) {
case _ActivityCompletionDto() when $default != null:
return $default(_that.id,_that.activityId,_that.pointsEarned,_that.createdAt,_that.alreadyProcessed,_that.streak,_that.streakDetails,_that.milestones,_that.milestoneDetails);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityCompletionDto extends ActivityCompletionDto {
  const _ActivityCompletionDto({this.id = '', @JsonKey(name: 'activity_id') this.activityId = '', @JsonKey(name: 'points_earned') this.pointsEarned = 0, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'already_processed') this.alreadyProcessed = false, this.streak, @JsonKey(name: 'streak_details') this.streakDetails, @JsonKey(name: 'milestones')  List<MilestoneDto> milestones = const <MilestoneDto>[], @JsonKey(name: 'milestone_details')  List<MilestoneDto> milestoneDetails = const <MilestoneDto>[]}): _milestones = milestones,_milestoneDetails = milestoneDetails,super._();
  factory _ActivityCompletionDto.fromJson(Map<String, dynamic> json) => _$ActivityCompletionDtoFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey(name: 'activity_id') final  String activityId;
@override@JsonKey(name: 'points_earned') final  int pointsEarned;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'already_processed') final  bool alreadyProcessed;
@override final  UserStreakDto? streak;
@override@JsonKey(name: 'streak_details') final  UserStreakDto? streakDetails;
 final  List<MilestoneDto> _milestones;
@override@JsonKey(name: 'milestones') List<MilestoneDto> get milestones {
  if (_milestones is EqualUnmodifiableListView) return _milestones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_milestones);
}

 final  List<MilestoneDto> _milestoneDetails;
@override@JsonKey(name: 'milestone_details') List<MilestoneDto> get milestoneDetails {
  if (_milestoneDetails is EqualUnmodifiableListView) return _milestoneDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_milestoneDetails);
}


/// Create a copy of ActivityCompletionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityCompletionDtoCopyWith<_ActivityCompletionDto> get copyWith => __$ActivityCompletionDtoCopyWithImpl<_ActivityCompletionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityCompletionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityCompletionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.pointsEarned, pointsEarned) || other.pointsEarned == pointsEarned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.alreadyProcessed, alreadyProcessed) || other.alreadyProcessed == alreadyProcessed)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.streakDetails, streakDetails) || other.streakDetails == streakDetails)&&const DeepCollectionEquality().equals(other.milestones, _milestones)&&const DeepCollectionEquality().equals(other.milestoneDetails, _milestoneDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,activityId,pointsEarned,createdAt,alreadyProcessed,streak,streakDetails,const DeepCollectionEquality().hash(_milestones),const DeepCollectionEquality().hash(_milestoneDetails));
}

@override
String toString() {
    return 'ActivityCompletionDto(id: $id, activityId: $activityId, pointsEarned: $pointsEarned, createdAt: $createdAt, alreadyProcessed: $alreadyProcessed, streak: $streak, streakDetails: $streakDetails, milestones: $milestones, milestoneDetails: $milestoneDetails)';
}


}

/// @nodoc
abstract mixin class _$ActivityCompletionDtoCopyWith<$Res> implements $ActivityCompletionDtoCopyWith<$Res> {
  factory _$ActivityCompletionDtoCopyWith(_ActivityCompletionDto value, $Res Function(_ActivityCompletionDto) _then) = __$ActivityCompletionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'activity_id') String activityId,@JsonKey(name: 'points_earned') int pointsEarned,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'already_processed') bool alreadyProcessed, UserStreakDto? streak,@JsonKey(name: 'streak_details') UserStreakDto? streakDetails,@JsonKey(name: 'milestones') List<MilestoneDto> milestones,@JsonKey(name: 'milestone_details') List<MilestoneDto> milestoneDetails
});


@override $UserStreakDtoCopyWith<$Res>? get streak;@override $UserStreakDtoCopyWith<$Res>? get streakDetails;

}
/// @nodoc
class __$ActivityCompletionDtoCopyWithImpl<$Res>
    implements _$ActivityCompletionDtoCopyWith<$Res> {
  __$ActivityCompletionDtoCopyWithImpl(this._self, this._then);

  final _ActivityCompletionDto _self;
  final $Res Function(_ActivityCompletionDto) _then;

/// Create a copy of ActivityCompletionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? activityId = null,Object? pointsEarned = null,Object? createdAt = freezed,Object? alreadyProcessed = null,Object? streak = freezed,Object? streakDetails = freezed,Object? milestones = null,Object? milestoneDetails = null,}) {
  return _then(_ActivityCompletionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,pointsEarned: null == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,alreadyProcessed: null == alreadyProcessed ? _self.alreadyProcessed : alreadyProcessed // ignore: cast_nullable_to_non_nullable
as bool,streak: freezed == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as UserStreakDto?,streakDetails: freezed == streakDetails ? _self.streakDetails : streakDetails // ignore: cast_nullable_to_non_nullable
as UserStreakDto?,milestones: null == milestones ? _self._milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<MilestoneDto>,milestoneDetails: null == milestoneDetails ? _self._milestoneDetails : milestoneDetails // ignore: cast_nullable_to_non_nullable
as List<MilestoneDto>,
  ));
}

/// Create a copy of ActivityCompletionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserStreakDtoCopyWith<$Res>? get streak {
    if (_self.streak == null) {
    return null;
  }

  return $UserStreakDtoCopyWith<$Res>(_self.streak!, (value) {
    return _then(_self.copyWith(streak: value));
  });
}/// Create a copy of ActivityCompletionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserStreakDtoCopyWith<$Res>? get streakDetails {
    if (_self.streakDetails == null) {
    return null;
  }

  return $UserStreakDtoCopyWith<$Res>(_self.streakDetails!, (value) {
    return _then(_self.copyWith(streakDetails: value));
  });
}
}

// dart format on
