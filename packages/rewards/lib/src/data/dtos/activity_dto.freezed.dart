// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityDto {

 String get id; String get name; String get category;@JsonKey(name: 'points_awarded') int get pointsAwarded;@JsonKey(name: 'max_daily_completions') int get maxDailyCompletions;@JsonKey(name: 'streak_eligible') bool get streakEligible; String? get code; String? get slug; String? get description;
/// Create a copy of ActivityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityDtoCopyWith<ActivityDto> get copyWith => _$ActivityDtoCopyWithImpl<ActivityDto>(this as ActivityDto, _$identity);

  /// Serializes this ActivityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.pointsAwarded, _this.pointsAwarded) || other.pointsAwarded == _this.pointsAwarded)&&(identical(other.maxDailyCompletions, _this.maxDailyCompletions) || other.maxDailyCompletions == _this.maxDailyCompletions)&&(identical(other.streakEligible, _this.streakEligible) || other.streakEligible == _this.streakEligible)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.description, _this.description) || other.description == _this.description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.category,_this.pointsAwarded,_this.maxDailyCompletions,_this.streakEligible,_this.code,_this.slug,_this.description);
}

@override
String toString() {
  final _this = this as ActivityDto;
  return 'ActivityDto(id: ${_this.id}, name: ${_this.name}, category: ${_this.category}, pointsAwarded: ${_this.pointsAwarded}, maxDailyCompletions: ${_this.maxDailyCompletions}, streakEligible: ${_this.streakEligible}, code: ${_this.code}, slug: ${_this.slug}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $ActivityDtoCopyWith<$Res>  {
  factory $ActivityDtoCopyWith(ActivityDto value, $Res Function(ActivityDto) _then) = _$ActivityDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category,@JsonKey(name: 'points_awarded') int pointsAwarded,@JsonKey(name: 'max_daily_completions') int maxDailyCompletions,@JsonKey(name: 'streak_eligible') bool streakEligible, String? code, String? slug, String? description
});




}
/// @nodoc
class _$ActivityDtoCopyWithImpl<$Res>
    implements $ActivityDtoCopyWith<$Res> {
  _$ActivityDtoCopyWithImpl(this._self, this._then);

  final ActivityDto _self;
  final $Res Function(ActivityDto) _then;

/// Create a copy of ActivityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? pointsAwarded = null,Object? maxDailyCompletions = null,Object? streakEligible = null,Object? code = freezed,Object? slug = freezed,Object? description = freezed,}) {
  return _then(ActivityDto(
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


/// Adds pattern-matching-related methods to [ActivityDto].
extension ActivityDtoPatterns on ActivityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityDto value)  $default,){
final _that = this;
switch (_that) {
case _ActivityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityDto value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category, @JsonKey(name: 'points_awarded')  int pointsAwarded, @JsonKey(name: 'max_daily_completions')  int maxDailyCompletions, @JsonKey(name: 'streak_eligible')  bool streakEligible,  String? code,  String? slug,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category, @JsonKey(name: 'points_awarded')  int pointsAwarded, @JsonKey(name: 'max_daily_completions')  int maxDailyCompletions, @JsonKey(name: 'streak_eligible')  bool streakEligible,  String? code,  String? slug,  String? description)  $default,) {final _that = this;
switch (_that) {
case _ActivityDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category, @JsonKey(name: 'points_awarded')  int pointsAwarded, @JsonKey(name: 'max_daily_completions')  int maxDailyCompletions, @JsonKey(name: 'streak_eligible')  bool streakEligible,  String? code,  String? slug,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _ActivityDto() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.pointsAwarded,_that.maxDailyCompletions,_that.streakEligible,_that.code,_that.slug,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityDto extends ActivityDto {
  const _ActivityDto({this.id = '', this.name = '', this.category = '', @JsonKey(name: 'points_awarded') this.pointsAwarded = 0, @JsonKey(name: 'max_daily_completions') this.maxDailyCompletions = 0, @JsonKey(name: 'streak_eligible') this.streakEligible = false, this.code, this.slug, this.description}): super._();
  factory _ActivityDto.fromJson(Map<String, dynamic> json) => _$ActivityDtoFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String category;
@override@JsonKey(name: 'points_awarded') final  int pointsAwarded;
@override@JsonKey(name: 'max_daily_completions') final  int maxDailyCompletions;
@override@JsonKey(name: 'streak_eligible') final  bool streakEligible;
@override final  String? code;
@override final  String? slug;
@override final  String? description;

/// Create a copy of ActivityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityDtoCopyWith<_ActivityDto> get copyWith => __$ActivityDtoCopyWithImpl<_ActivityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.pointsAwarded, pointsAwarded) || other.pointsAwarded == pointsAwarded)&&(identical(other.maxDailyCompletions, maxDailyCompletions) || other.maxDailyCompletions == maxDailyCompletions)&&(identical(other.streakEligible, streakEligible) || other.streakEligible == streakEligible)&&(identical(other.code, code) || other.code == code)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,category,pointsAwarded,maxDailyCompletions,streakEligible,code,slug,description);
}

@override
String toString() {
    return 'ActivityDto(id: $id, name: $name, category: $category, pointsAwarded: $pointsAwarded, maxDailyCompletions: $maxDailyCompletions, streakEligible: $streakEligible, code: $code, slug: $slug, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ActivityDtoCopyWith<$Res> implements $ActivityDtoCopyWith<$Res> {
  factory _$ActivityDtoCopyWith(_ActivityDto value, $Res Function(_ActivityDto) _then) = __$ActivityDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category,@JsonKey(name: 'points_awarded') int pointsAwarded,@JsonKey(name: 'max_daily_completions') int maxDailyCompletions,@JsonKey(name: 'streak_eligible') bool streakEligible, String? code, String? slug, String? description
});




}
/// @nodoc
class __$ActivityDtoCopyWithImpl<$Res>
    implements _$ActivityDtoCopyWith<$Res> {
  __$ActivityDtoCopyWithImpl(this._self, this._then);

  final _ActivityDto _self;
  final $Res Function(_ActivityDto) _then;

/// Create a copy of ActivityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? pointsAwarded = null,Object? maxDailyCompletions = null,Object? streakEligible = null,Object? code = freezed,Object? slug = freezed,Object? description = freezed,}) {
  return _then(_ActivityDto(
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
