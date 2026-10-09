// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarnableActivity {

 String get id; String get name; String get category; int get pointsAwarded; int get maxDailyCompletions; bool get streakEligible; String? get code; String? get slug; String? get description;
/// Create a copy of EarnableActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnableActivityCopyWith<EarnableActivity> get copyWith => _$EarnableActivityCopyWithImpl<EarnableActivity>(this as EarnableActivity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EarnableActivity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnableActivity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.pointsAwarded, _this.pointsAwarded) || other.pointsAwarded == _this.pointsAwarded)&&(identical(other.maxDailyCompletions, _this.maxDailyCompletions) || other.maxDailyCompletions == _this.maxDailyCompletions)&&(identical(other.streakEligible, _this.streakEligible) || other.streakEligible == _this.streakEligible)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as EarnableActivity;
  return Object.hash(runtimeType,_this.id,_this.name,_this.category,_this.pointsAwarded,_this.maxDailyCompletions,_this.streakEligible,_this.code,_this.slug,_this.description);
}

@override
String toString() {
  final _this = this as EarnableActivity;
  return 'EarnableActivity(id: ${_this.id}, name: ${_this.name}, category: ${_this.category}, pointsAwarded: ${_this.pointsAwarded}, maxDailyCompletions: ${_this.maxDailyCompletions}, streakEligible: ${_this.streakEligible}, code: ${_this.code}, slug: ${_this.slug}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $EarnableActivityCopyWith<$Res>  {
  factory $EarnableActivityCopyWith(EarnableActivity value, $Res Function(EarnableActivity) _then) = _$EarnableActivityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, int pointsAwarded, int maxDailyCompletions, bool streakEligible, String? code, String? slug, String? description
});




}
/// @nodoc
class _$EarnableActivityCopyWithImpl<$Res>
    implements $EarnableActivityCopyWith<$Res> {
  _$EarnableActivityCopyWithImpl(this._self, this._then);

  final EarnableActivity _self;
  final $Res Function(EarnableActivity) _then;

/// Create a copy of EarnableActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? pointsAwarded = null,Object? maxDailyCompletions = null,Object? streakEligible = null,Object? code = freezed,Object? slug = freezed,Object? description = freezed,}) {
  return _then(EarnableActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,pointsAwarded: null == pointsAwarded ? _self.pointsAwarded : pointsAwarded // ignore: cast_nullable_to_non_nullable
as int,maxDailyCompletions: null == maxDailyCompletions ? _self.maxDailyCompletions : maxDailyCompletions // ignore: cast_nullable_to_non_nullable
as int,streakEligible: null == streakEligible ? _self.streakEligible : streakEligible // ignore: cast_nullable_to_non_nullable
as bool,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarnableActivity].
extension EarnableActivityPatterns on EarnableActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnableActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnableActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnableActivity value)  $default,){
final _that = this;
switch (_that) {
case _EarnableActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnableActivity value)?  $default,){
final _that = this;
switch (_that) {
case _EarnableActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  int pointsAwarded,  int maxDailyCompletions,  bool streakEligible,  String? code,  String? slug,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarnableActivity() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.pointsAwarded,_that.maxDailyCompletions,_that.streakEligible,_that.code,_that.slug,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  int pointsAwarded,  int maxDailyCompletions,  bool streakEligible,  String? code,  String? slug,  String? description)  $default,) {final _that = this;
switch (_that) {
case _EarnableActivity():
return $default(_that.id,_that.name,_that.category,_that.pointsAwarded,_that.maxDailyCompletions,_that.streakEligible,_that.code,_that.slug,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  int pointsAwarded,  int maxDailyCompletions,  bool streakEligible,  String? code,  String? slug,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _EarnableActivity() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.pointsAwarded,_that.maxDailyCompletions,_that.streakEligible,_that.code,_that.slug,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _EarnableActivity implements EarnableActivity {
  const _EarnableActivity({required this.id, required this.name, required this.category, required this.pointsAwarded, required this.maxDailyCompletions, required this.streakEligible, this.code, this.slug, this.description});


@override final  String id;
@override final  String name;
@override final  String category;
@override final  int pointsAwarded;
@override final  int maxDailyCompletions;
@override final  bool streakEligible;
@override final  String? code;
@override final  String? slug;
@override final  String? description;

/// Create a copy of EarnableActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnableActivityCopyWith<_EarnableActivity> get copyWith => __$EarnableActivityCopyWithImpl<_EarnableActivity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnableActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.pointsAwarded, pointsAwarded) || other.pointsAwarded == pointsAwarded)&&(identical(other.maxDailyCompletions, maxDailyCompletions) || other.maxDailyCompletions == maxDailyCompletions)&&(identical(other.streakEligible, streakEligible) || other.streakEligible == streakEligible)&&(identical(other.code, code) || other.code == code)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,category,pointsAwarded,maxDailyCompletions,streakEligible,code,slug,description);
}

@override
String toString() {
    return 'EarnableActivity(id: $id, name: $name, category: $category, pointsAwarded: $pointsAwarded, maxDailyCompletions: $maxDailyCompletions, streakEligible: $streakEligible, code: $code, slug: $slug, description: $description)';
}


}

/// @nodoc
abstract mixin class _$EarnableActivityCopyWith<$Res> implements $EarnableActivityCopyWith<$Res> {
  factory _$EarnableActivityCopyWith(_EarnableActivity value, $Res Function(_EarnableActivity) _then) = __$EarnableActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, int pointsAwarded, int maxDailyCompletions, bool streakEligible, String? code, String? slug, String? description
});




}
/// @nodoc
class __$EarnableActivityCopyWithImpl<$Res>
    implements _$EarnableActivityCopyWith<$Res> {
  __$EarnableActivityCopyWithImpl(this._self, this._then);

  final _EarnableActivity _self;
  final $Res Function(_EarnableActivity) _then;

/// Create a copy of EarnableActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? pointsAwarded = null,Object? maxDailyCompletions = null,Object? streakEligible = null,Object? code = freezed,Object? slug = freezed,Object? description = freezed,}) {
  return _then(_EarnableActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,pointsAwarded: null == pointsAwarded ? _self.pointsAwarded : pointsAwarded // ignore: cast_nullable_to_non_nullable
as int,maxDailyCompletions: null == maxDailyCompletions ? _self.maxDailyCompletions : maxDailyCompletions // ignore: cast_nullable_to_non_nullable
as int,streakEligible: null == streakEligible ? _self.streakEligible : streakEligible // ignore: cast_nullable_to_non_nullable
as bool,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
