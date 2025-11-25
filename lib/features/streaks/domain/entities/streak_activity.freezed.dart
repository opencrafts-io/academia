// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StreakActivity {

 String get id; String get name; String get category; int get pointsAwarded; int get maxDailyCompletions; bool get streakEligible; bool get isActive; DateTime get createdAt; DateTime get updatedAt; DateTime? get cachedAt;
/// Create a copy of StreakActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreakActivityCopyWith<StreakActivity> get copyWith => _$StreakActivityCopyWithImpl<StreakActivity>(this as StreakActivity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreakActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.pointsAwarded, pointsAwarded) || other.pointsAwarded == pointsAwarded)&&(identical(other.maxDailyCompletions, maxDailyCompletions) || other.maxDailyCompletions == maxDailyCompletions)&&(identical(other.streakEligible, streakEligible) || other.streakEligible == streakEligible)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,category,pointsAwarded,maxDailyCompletions,streakEligible,isActive,createdAt,updatedAt,cachedAt);

@override
String toString() {
  return 'StreakActivity(id: $id, name: $name, category: $category, pointsAwarded: $pointsAwarded, maxDailyCompletions: $maxDailyCompletions, streakEligible: $streakEligible, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, cachedAt: $cachedAt)';
}


}

/// @nodoc
abstract mixin class $StreakActivityCopyWith<$Res>  {
  factory $StreakActivityCopyWith(StreakActivity value, $Res Function(StreakActivity) _then) = _$StreakActivityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, int pointsAwarded, int maxDailyCompletions, bool streakEligible, bool isActive, DateTime createdAt, DateTime updatedAt, DateTime? cachedAt
});




}
/// @nodoc
class _$StreakActivityCopyWithImpl<$Res>
    implements $StreakActivityCopyWith<$Res> {
  _$StreakActivityCopyWithImpl(this._self, this._then);

  final StreakActivity _self;
  final $Res Function(StreakActivity) _then;

/// Create a copy of StreakActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? pointsAwarded = null,Object? maxDailyCompletions = null,Object? streakEligible = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? cachedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,pointsAwarded: null == pointsAwarded ? _self.pointsAwarded : pointsAwarded // ignore: cast_nullable_to_non_nullable
as int,maxDailyCompletions: null == maxDailyCompletions ? _self.maxDailyCompletions : maxDailyCompletions // ignore: cast_nullable_to_non_nullable
as int,streakEligible: null == streakEligible ? _self.streakEligible : streakEligible // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,cachedAt: freezed == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StreakActivity].
extension StreakActivityPatterns on StreakActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StreakActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StreakActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StreakActivity value)  $default,){
final _that = this;
switch (_that) {
case _StreakActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StreakActivity value)?  $default,){
final _that = this;
switch (_that) {
case _StreakActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  int pointsAwarded,  int maxDailyCompletions,  bool streakEligible,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  DateTime? cachedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StreakActivity() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.pointsAwarded,_that.maxDailyCompletions,_that.streakEligible,_that.isActive,_that.createdAt,_that.updatedAt,_that.cachedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  int pointsAwarded,  int maxDailyCompletions,  bool streakEligible,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  DateTime? cachedAt)  $default,) {final _that = this;
switch (_that) {
case _StreakActivity():
return $default(_that.id,_that.name,_that.category,_that.pointsAwarded,_that.maxDailyCompletions,_that.streakEligible,_that.isActive,_that.createdAt,_that.updatedAt,_that.cachedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  int pointsAwarded,  int maxDailyCompletions,  bool streakEligible,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  DateTime? cachedAt)?  $default,) {final _that = this;
switch (_that) {
case _StreakActivity() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.pointsAwarded,_that.maxDailyCompletions,_that.streakEligible,_that.isActive,_that.createdAt,_that.updatedAt,_that.cachedAt);case _:
  return null;

}
}

}

/// @nodoc


class _StreakActivity extends StreakActivity {
  const _StreakActivity({required this.id, required this.name, required this.category, required this.pointsAwarded, required this.maxDailyCompletions, required this.streakEligible, required this.isActive, required this.createdAt, required this.updatedAt, this.cachedAt}): super._();
  

@override final  String id;
@override final  String name;
@override final  String category;
@override final  int pointsAwarded;
@override final  int maxDailyCompletions;
@override final  bool streakEligible;
@override final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? cachedAt;

/// Create a copy of StreakActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreakActivityCopyWith<_StreakActivity> get copyWith => __$StreakActivityCopyWithImpl<_StreakActivity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreakActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.pointsAwarded, pointsAwarded) || other.pointsAwarded == pointsAwarded)&&(identical(other.maxDailyCompletions, maxDailyCompletions) || other.maxDailyCompletions == maxDailyCompletions)&&(identical(other.streakEligible, streakEligible) || other.streakEligible == streakEligible)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,category,pointsAwarded,maxDailyCompletions,streakEligible,isActive,createdAt,updatedAt,cachedAt);

@override
String toString() {
  return 'StreakActivity(id: $id, name: $name, category: $category, pointsAwarded: $pointsAwarded, maxDailyCompletions: $maxDailyCompletions, streakEligible: $streakEligible, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, cachedAt: $cachedAt)';
}


}

/// @nodoc
abstract mixin class _$StreakActivityCopyWith<$Res> implements $StreakActivityCopyWith<$Res> {
  factory _$StreakActivityCopyWith(_StreakActivity value, $Res Function(_StreakActivity) _then) = __$StreakActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, int pointsAwarded, int maxDailyCompletions, bool streakEligible, bool isActive, DateTime createdAt, DateTime updatedAt, DateTime? cachedAt
});




}
/// @nodoc
class __$StreakActivityCopyWithImpl<$Res>
    implements _$StreakActivityCopyWith<$Res> {
  __$StreakActivityCopyWithImpl(this._self, this._then);

  final _StreakActivity _self;
  final $Res Function(_StreakActivity) _then;

/// Create a copy of StreakActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? pointsAwarded = null,Object? maxDailyCompletions = null,Object? streakEligible = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? cachedAt = freezed,}) {
  return _then(_StreakActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,pointsAwarded: null == pointsAwarded ? _self.pointsAwarded : pointsAwarded // ignore: cast_nullable_to_non_nullable
as int,maxDailyCompletions: null == maxDailyCompletions ? _self.maxDailyCompletions : maxDailyCompletions // ignore: cast_nullable_to_non_nullable
as int,streakEligible: null == streakEligible ? _self.streakEligible : streakEligible // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,cachedAt: freezed == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
