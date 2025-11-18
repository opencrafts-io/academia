// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_milestone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StreakMilestone {

 String get id; String get activityID; int get daysRequired; int get bonusPoints; String get title; String get description; bool get isActive; DateTime? get cachedAt;
/// Create a copy of StreakMilestone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreakMilestoneCopyWith<StreakMilestone> get copyWith => _$StreakMilestoneCopyWithImpl<StreakMilestone>(this as StreakMilestone, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreakMilestone&&(identical(other.id, id) || other.id == id)&&(identical(other.activityID, activityID) || other.activityID == activityID)&&(identical(other.daysRequired, daysRequired) || other.daysRequired == daysRequired)&&(identical(other.bonusPoints, bonusPoints) || other.bonusPoints == bonusPoints)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,activityID,daysRequired,bonusPoints,title,description,isActive,cachedAt);

@override
String toString() {
  return 'StreakMilestone(id: $id, activityID: $activityID, daysRequired: $daysRequired, bonusPoints: $bonusPoints, title: $title, description: $description, isActive: $isActive, cachedAt: $cachedAt)';
}


}

/// @nodoc
abstract mixin class $StreakMilestoneCopyWith<$Res>  {
  factory $StreakMilestoneCopyWith(StreakMilestone value, $Res Function(StreakMilestone) _then) = _$StreakMilestoneCopyWithImpl;
@useResult
$Res call({
 String id, String activityID, int daysRequired, int bonusPoints, String title, String description, bool isActive, DateTime? cachedAt
});




}
/// @nodoc
class _$StreakMilestoneCopyWithImpl<$Res>
    implements $StreakMilestoneCopyWith<$Res> {
  _$StreakMilestoneCopyWithImpl(this._self, this._then);

  final StreakMilestone _self;
  final $Res Function(StreakMilestone) _then;

/// Create a copy of StreakMilestone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? activityID = null,Object? daysRequired = null,Object? bonusPoints = null,Object? title = null,Object? description = null,Object? isActive = null,Object? cachedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityID: null == activityID ? _self.activityID : activityID // ignore: cast_nullable_to_non_nullable
as String,daysRequired: null == daysRequired ? _self.daysRequired : daysRequired // ignore: cast_nullable_to_non_nullable
as int,bonusPoints: null == bonusPoints ? _self.bonusPoints : bonusPoints // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,cachedAt: freezed == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StreakMilestone].
extension StreakMilestonePatterns on StreakMilestone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StreakMilestone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StreakMilestone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StreakMilestone value)  $default,){
final _that = this;
switch (_that) {
case _StreakMilestone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StreakMilestone value)?  $default,){
final _that = this;
switch (_that) {
case _StreakMilestone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String activityID,  int daysRequired,  int bonusPoints,  String title,  String description,  bool isActive,  DateTime? cachedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StreakMilestone() when $default != null:
return $default(_that.id,_that.activityID,_that.daysRequired,_that.bonusPoints,_that.title,_that.description,_that.isActive,_that.cachedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String activityID,  int daysRequired,  int bonusPoints,  String title,  String description,  bool isActive,  DateTime? cachedAt)  $default,) {final _that = this;
switch (_that) {
case _StreakMilestone():
return $default(_that.id,_that.activityID,_that.daysRequired,_that.bonusPoints,_that.title,_that.description,_that.isActive,_that.cachedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String activityID,  int daysRequired,  int bonusPoints,  String title,  String description,  bool isActive,  DateTime? cachedAt)?  $default,) {final _that = this;
switch (_that) {
case _StreakMilestone() when $default != null:
return $default(_that.id,_that.activityID,_that.daysRequired,_that.bonusPoints,_that.title,_that.description,_that.isActive,_that.cachedAt);case _:
  return null;

}
}

}

/// @nodoc


class _StreakMilestone extends StreakMilestone {
  const _StreakMilestone({required this.id, required this.activityID, required this.daysRequired, required this.bonusPoints, required this.title, required this.description, required this.isActive, this.cachedAt}): super._();
  

@override final  String id;
@override final  String activityID;
@override final  int daysRequired;
@override final  int bonusPoints;
@override final  String title;
@override final  String description;
@override final  bool isActive;
@override final  DateTime? cachedAt;

/// Create a copy of StreakMilestone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreakMilestoneCopyWith<_StreakMilestone> get copyWith => __$StreakMilestoneCopyWithImpl<_StreakMilestone>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreakMilestone&&(identical(other.id, id) || other.id == id)&&(identical(other.activityID, activityID) || other.activityID == activityID)&&(identical(other.daysRequired, daysRequired) || other.daysRequired == daysRequired)&&(identical(other.bonusPoints, bonusPoints) || other.bonusPoints == bonusPoints)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,activityID,daysRequired,bonusPoints,title,description,isActive,cachedAt);

@override
String toString() {
  return 'StreakMilestone(id: $id, activityID: $activityID, daysRequired: $daysRequired, bonusPoints: $bonusPoints, title: $title, description: $description, isActive: $isActive, cachedAt: $cachedAt)';
}


}

/// @nodoc
abstract mixin class _$StreakMilestoneCopyWith<$Res> implements $StreakMilestoneCopyWith<$Res> {
  factory _$StreakMilestoneCopyWith(_StreakMilestone value, $Res Function(_StreakMilestone) _then) = __$StreakMilestoneCopyWithImpl;
@override @useResult
$Res call({
 String id, String activityID, int daysRequired, int bonusPoints, String title, String description, bool isActive, DateTime? cachedAt
});




}
/// @nodoc
class __$StreakMilestoneCopyWithImpl<$Res>
    implements _$StreakMilestoneCopyWith<$Res> {
  __$StreakMilestoneCopyWithImpl(this._self, this._then);

  final _StreakMilestone _self;
  final $Res Function(_StreakMilestone) _then;

/// Create a copy of StreakMilestone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? activityID = null,Object? daysRequired = null,Object? bonusPoints = null,Object? title = null,Object? description = null,Object? isActive = null,Object? cachedAt = freezed,}) {
  return _then(_StreakMilestone(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,activityID: null == activityID ? _self.activityID : activityID // ignore: cast_nullable_to_non_nullable
as String,daysRequired: null == daysRequired ? _self.daysRequired : daysRequired // ignore: cast_nullable_to_non_nullable
as int,bonusPoints: null == bonusPoints ? _self.bonusPoints : bonusPoints // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,cachedAt: freezed == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
