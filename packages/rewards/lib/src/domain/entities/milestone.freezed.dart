// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'milestone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RewardMilestone {

 String get id; String get activityId; int get daysRequired; int get bonusPoints; String get title; String get description;
/// Create a copy of RewardMilestone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardMilestoneCopyWith<RewardMilestone> get copyWith => _$RewardMilestoneCopyWithImpl<RewardMilestone>(this as RewardMilestone, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RewardMilestone;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardMilestone&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.daysRequired, _this.daysRequired) || other.daysRequired == _this.daysRequired)&&(identical(other.bonusPoints, _this.bonusPoints) || other.bonusPoints == _this.bonusPoints)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as RewardMilestone;
  return Object.hash(runtimeType,_this.id,_this.activityId,_this.daysRequired,_this.bonusPoints,_this.title,_this.description);
}

@override
String toString() {
  final _this = this as RewardMilestone;
  return 'RewardMilestone(id: ${_this.id}, activityId: ${_this.activityId}, daysRequired: ${_this.daysRequired}, bonusPoints: ${_this.bonusPoints}, title: ${_this.title}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $RewardMilestoneCopyWith<$Res>  {
  factory $RewardMilestoneCopyWith(RewardMilestone value, $Res Function(RewardMilestone) _then) = _$RewardMilestoneCopyWithImpl;
@useResult
$Res call({
 String id, String activityId, int daysRequired, int bonusPoints, String title, String description
});




}
/// @nodoc
class _$RewardMilestoneCopyWithImpl<$Res>
    implements $RewardMilestoneCopyWith<$Res> {
  _$RewardMilestoneCopyWithImpl(this._self, this._then);

  final RewardMilestone _self;
  final $Res Function(RewardMilestone) _then;

/// Create a copy of RewardMilestone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? activityId = null,Object? daysRequired = null,Object? bonusPoints = null,Object? title = null,Object? description = null,}) {
  return _then(RewardMilestone(
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


/// Adds pattern-matching-related methods to [RewardMilestone].
extension RewardMilestonePatterns on RewardMilestone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardMilestone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardMilestone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardMilestone value)  $default,){
final _that = this;
switch (_that) {
case _RewardMilestone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardMilestone value)?  $default,){
final _that = this;
switch (_that) {
case _RewardMilestone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String activityId,  int daysRequired,  int bonusPoints,  String title,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardMilestone() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String activityId,  int daysRequired,  int bonusPoints,  String title,  String description)  $default,) {final _that = this;
switch (_that) {
case _RewardMilestone():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String activityId,  int daysRequired,  int bonusPoints,  String title,  String description)?  $default,) {final _that = this;
switch (_that) {
case _RewardMilestone() when $default != null:
return $default(_that.id,_that.activityId,_that.daysRequired,_that.bonusPoints,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _RewardMilestone implements RewardMilestone {
  const _RewardMilestone({required this.id, required this.activityId, required this.daysRequired, required this.bonusPoints, required this.title, required this.description});


@override final  String id;
@override final  String activityId;
@override final  int daysRequired;
@override final  int bonusPoints;
@override final  String title;
@override final  String description;

/// Create a copy of RewardMilestone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardMilestoneCopyWith<_RewardMilestone> get copyWith => __$RewardMilestoneCopyWithImpl<_RewardMilestone>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardMilestone&&(identical(other.id, id) || other.id == id)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.daysRequired, daysRequired) || other.daysRequired == daysRequired)&&(identical(other.bonusPoints, bonusPoints) || other.bonusPoints == bonusPoints)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,activityId,daysRequired,bonusPoints,title,description);
}

@override
String toString() {
    return 'RewardMilestone(id: $id, activityId: $activityId, daysRequired: $daysRequired, bonusPoints: $bonusPoints, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$RewardMilestoneCopyWith<$Res> implements $RewardMilestoneCopyWith<$Res> {
  factory _$RewardMilestoneCopyWith(_RewardMilestone value, $Res Function(_RewardMilestone) _then) = __$RewardMilestoneCopyWithImpl;
@override @useResult
$Res call({
 String id, String activityId, int daysRequired, int bonusPoints, String title, String description
});




}
/// @nodoc
class __$RewardMilestoneCopyWithImpl<$Res>
    implements _$RewardMilestoneCopyWith<$Res> {
  __$RewardMilestoneCopyWithImpl(this._self, this._then);

  final _RewardMilestone _self;
  final $Res Function(_RewardMilestone) _then;

/// Create a copy of RewardMilestone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? activityId = null,Object? daysRequired = null,Object? bonusPoints = null,Object? title = null,Object? description = null,}) {
  return _then(_RewardMilestone(
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
