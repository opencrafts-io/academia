// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_completion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActivityCompletion {

 String get id; String get activityId; int get pointsEarned; DateTime? get createdAt; bool get alreadyProcessed; UserStreak? get streak; List<RewardMilestone> get milestones;
/// Create a copy of ActivityCompletion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityCompletionCopyWith<ActivityCompletion> get copyWith => _$ActivityCompletionCopyWithImpl<ActivityCompletion>(this as ActivityCompletion, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ActivityCompletion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityCompletion&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.pointsEarned, _this.pointsEarned) || other.pointsEarned == _this.pointsEarned)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.alreadyProcessed, _this.alreadyProcessed) || other.alreadyProcessed == _this.alreadyProcessed)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&const DeepCollectionEquality().equals(other.milestones, _this.milestones));
}


@override
int get hashCode {
  final _this = this as ActivityCompletion;
  return Object.hash(runtimeType,_this.id,_this.activityId,_this.pointsEarned,_this.createdAt,_this.alreadyProcessed,_this.streak,const DeepCollectionEquality().hash(_this.milestones));
}

@override
String toString() {
  final _this = this as ActivityCompletion;
  return 'ActivityCompletion(id: ${_this.id}, activityId: ${_this.activityId}, pointsEarned: ${_this.pointsEarned}, createdAt: ${_this.createdAt}, alreadyProcessed: ${_this.alreadyProcessed}, streak: ${_this.streak}, milestones: ${_this.milestones})';
}


}

/// @nodoc
abstract mixin class $ActivityCompletionCopyWith<$Res>  {
  factory $ActivityCompletionCopyWith(ActivityCompletion value, $Res Function(ActivityCompletion) _then) = _$ActivityCompletionCopyWithImpl;
@useResult
$Res call({
 String id, String activityId, int pointsEarned, DateTime? createdAt, bool alreadyProcessed, UserStreak? streak, List<RewardMilestone> milestones
});


$UserStreakCopyWith<$Res>? get streak;

}
/// @nodoc
class _$ActivityCompletionCopyWithImpl<$Res>
    implements $ActivityCompletionCopyWith<$Res> {
  _$ActivityCompletionCopyWithImpl(this._self, this._then);

  final ActivityCompletion _self;
  final $Res Function(ActivityCompletion) _then;

/// Create a copy of ActivityCompletion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? activityId = null,Object? pointsEarned = null,Object? createdAt = freezed,Object? alreadyProcessed = null,Object? streak = freezed,Object? milestones = null,}) {
  return _then(ActivityCompletion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,pointsEarned: null == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,alreadyProcessed: null == alreadyProcessed ? _self.alreadyProcessed : alreadyProcessed // ignore: cast_nullable_to_non_nullable
as bool,streak: freezed == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as UserStreak?,milestones: null == milestones ? _self.milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<RewardMilestone>,
  ));
}
/// Create a copy of ActivityCompletion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserStreakCopyWith<$Res>? get streak {
    if (_self.streak == null) {
    return null;
  }

  return $UserStreakCopyWith<$Res>(_self.streak!, (value) {
    return _then(_self.copyWith(streak: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActivityCompletion].
extension ActivityCompletionPatterns on ActivityCompletion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityCompletion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityCompletion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityCompletion value)  $default,){
final _that = this;
switch (_that) {
case _ActivityCompletion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityCompletion value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityCompletion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String activityId,  int pointsEarned,  DateTime? createdAt,  bool alreadyProcessed,  UserStreak? streak,  List<RewardMilestone> milestones)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityCompletion() when $default != null:
return $default(_that.id,_that.activityId,_that.pointsEarned,_that.createdAt,_that.alreadyProcessed,_that.streak,_that.milestones);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String activityId,  int pointsEarned,  DateTime? createdAt,  bool alreadyProcessed,  UserStreak? streak,  List<RewardMilestone> milestones)  $default,) {final _that = this;
switch (_that) {
case _ActivityCompletion():
return $default(_that.id,_that.activityId,_that.pointsEarned,_that.createdAt,_that.alreadyProcessed,_that.streak,_that.milestones);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String activityId,  int pointsEarned,  DateTime? createdAt,  bool alreadyProcessed,  UserStreak? streak,  List<RewardMilestone> milestones)?  $default,) {final _that = this;
switch (_that) {
case _ActivityCompletion() when $default != null:
return $default(_that.id,_that.activityId,_that.pointsEarned,_that.createdAt,_that.alreadyProcessed,_that.streak,_that.milestones);case _:
  return null;

}
}

}

/// @nodoc


class _ActivityCompletion implements ActivityCompletion {
  const _ActivityCompletion({required this.id, required this.activityId, required this.pointsEarned, this.createdAt, required this.alreadyProcessed, this.streak,  List<RewardMilestone> milestones = const <RewardMilestone>[]}): _milestones = milestones;


@override final  String id;
@override final  String activityId;
@override final  int pointsEarned;
@override final  DateTime? createdAt;
@override final  bool alreadyProcessed;
@override final  UserStreak? streak;
 final  List<RewardMilestone> _milestones;
@override@JsonKey() List<RewardMilestone> get milestones {
  if (_milestones is EqualUnmodifiableListView) return _milestones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_milestones);
}


/// Create a copy of ActivityCompletion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityCompletionCopyWith<_ActivityCompletion> get copyWith => __$ActivityCompletionCopyWithImpl<_ActivityCompletion>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityCompletion&&(identical(other.id, id) || other.id == id)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.pointsEarned, pointsEarned) || other.pointsEarned == pointsEarned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.alreadyProcessed, alreadyProcessed) || other.alreadyProcessed == alreadyProcessed)&&(identical(other.streak, streak) || other.streak == streak)&&const DeepCollectionEquality().equals(other.milestones, _milestones));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,activityId,pointsEarned,createdAt,alreadyProcessed,streak,const DeepCollectionEquality().hash(_milestones));
}

@override
String toString() {
    return 'ActivityCompletion(id: $id, activityId: $activityId, pointsEarned: $pointsEarned, createdAt: $createdAt, alreadyProcessed: $alreadyProcessed, streak: $streak, milestones: $milestones)';
}


}

/// @nodoc
abstract mixin class _$ActivityCompletionCopyWith<$Res> implements $ActivityCompletionCopyWith<$Res> {
  factory _$ActivityCompletionCopyWith(_ActivityCompletion value, $Res Function(_ActivityCompletion) _then) = __$ActivityCompletionCopyWithImpl;
@override @useResult
$Res call({
 String id, String activityId, int pointsEarned, DateTime? createdAt, bool alreadyProcessed, UserStreak? streak, List<RewardMilestone> milestones
});


@override $UserStreakCopyWith<$Res>? get streak;

}
/// @nodoc
class __$ActivityCompletionCopyWithImpl<$Res>
    implements _$ActivityCompletionCopyWith<$Res> {
  __$ActivityCompletionCopyWithImpl(this._self, this._then);

  final _ActivityCompletion _self;
  final $Res Function(_ActivityCompletion) _then;

/// Create a copy of ActivityCompletion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? activityId = null,Object? pointsEarned = null,Object? createdAt = freezed,Object? alreadyProcessed = null,Object? streak = freezed,Object? milestones = null,}) {
  return _then(_ActivityCompletion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,pointsEarned: null == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,alreadyProcessed: null == alreadyProcessed ? _self.alreadyProcessed : alreadyProcessed // ignore: cast_nullable_to_non_nullable
as bool,streak: freezed == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as UserStreak?,milestones: null == milestones ? _self._milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<RewardMilestone>,
  ));
}

/// Create a copy of ActivityCompletion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserStreakCopyWith<$Res>? get streak {
    if (_self.streak == null) {
    return null;
  }

  return $UserStreakCopyWith<$Res>(_self.streak!, (value) {
    return _then(_self.copyWith(streak: value));
  });
}
}

// dart format on
