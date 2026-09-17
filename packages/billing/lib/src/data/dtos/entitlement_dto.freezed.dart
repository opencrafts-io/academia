// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entitlement_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EntitlementDto {

@JsonKey(name: 'created_at') DateTime get createdAt; String? get description; String get key;@JsonKey(name: 'plan_code') String get planCode; String get unit; int get value;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of EntitlementDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntitlementDtoCopyWith<EntitlementDto> get copyWith => _$EntitlementDtoCopyWithImpl<EntitlementDto>(this as EntitlementDto, _$identity);

  /// Serializes this EntitlementDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EntitlementDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntitlementDto&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.planCode, _this.planCode) || other.planCode == _this.planCode)&&(identical(other.unit, _this.unit) || other.unit == _this.unit)&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EntitlementDto;
  return Object.hash(runtimeType,_this.createdAt,_this.description,_this.key,_this.planCode,_this.unit,_this.value,_this.updatedAt);
}

@override
String toString() {
  final _this = this as EntitlementDto;
  return 'EntitlementDto(createdAt: ${_this.createdAt}, description: ${_this.description}, key: ${_this.key}, planCode: ${_this.planCode}, unit: ${_this.unit}, value: ${_this.value}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $EntitlementDtoCopyWith<$Res>  {
  factory $EntitlementDtoCopyWith(EntitlementDto value, $Res Function(EntitlementDto) _then) = _$EntitlementDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'created_at') DateTime createdAt, String? description, String key,@JsonKey(name: 'plan_code') String planCode, String unit, int value,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$EntitlementDtoCopyWithImpl<$Res>
    implements $EntitlementDtoCopyWith<$Res> {
  _$EntitlementDtoCopyWithImpl(this._self, this._then);

  final EntitlementDto _self;
  final $Res Function(EntitlementDto) _then;

/// Create a copy of EntitlementDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? createdAt = null,Object? description = freezed,Object? key = null,Object? planCode = null,Object? unit = null,Object? value = null,Object? updatedAt = null,}) {
  return _then(EntitlementDto(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,planCode: null == planCode ? _self.planCode : planCode // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [EntitlementDto].
extension EntitlementDtoPatterns on EntitlementDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntitlementDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntitlementDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntitlementDto value)  $default,){
final _that = this;
switch (_that) {
case _EntitlementDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntitlementDto value)?  $default,){
final _that = this;
switch (_that) {
case _EntitlementDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'created_at')  DateTime createdAt,  String? description,  String key, @JsonKey(name: 'plan_code')  String planCode,  String unit,  int value, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntitlementDto() when $default != null:
return $default(_that.createdAt,_that.description,_that.key,_that.planCode,_that.unit,_that.value,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'created_at')  DateTime createdAt,  String? description,  String key, @JsonKey(name: 'plan_code')  String planCode,  String unit,  int value, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _EntitlementDto():
return $default(_that.createdAt,_that.description,_that.key,_that.planCode,_that.unit,_that.value,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'created_at')  DateTime createdAt,  String? description,  String key, @JsonKey(name: 'plan_code')  String planCode,  String unit,  int value, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _EntitlementDto() when $default != null:
return $default(_that.createdAt,_that.description,_that.key,_that.planCode,_that.unit,_that.value,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EntitlementDto implements EntitlementDto {
  const _EntitlementDto({@JsonKey(name: 'created_at') required this.createdAt, required this.description, required this.key, @JsonKey(name: 'plan_code') required this.planCode, required this.unit, required this.value, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _EntitlementDto.fromJson(Map<String, dynamic> json) => _$EntitlementDtoFromJson(json);

@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override final  String? description;
@override final  String key;
@override@JsonKey(name: 'plan_code') final  String planCode;
@override final  String unit;
@override final  int value;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of EntitlementDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntitlementDtoCopyWith<_EntitlementDto> get copyWith => __$EntitlementDtoCopyWithImpl<_EntitlementDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EntitlementDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntitlementDto&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.key, key) || other.key == key)&&(identical(other.planCode, planCode) || other.planCode == planCode)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.value, value) || other.value == value)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,createdAt,description,key,planCode,unit,value,updatedAt);
}

@override
String toString() {
    return 'EntitlementDto(createdAt: $createdAt, description: $description, key: $key, planCode: $planCode, unit: $unit, value: $value, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EntitlementDtoCopyWith<$Res> implements $EntitlementDtoCopyWith<$Res> {
  factory _$EntitlementDtoCopyWith(_EntitlementDto value, $Res Function(_EntitlementDto) _then) = __$EntitlementDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'created_at') DateTime createdAt, String? description, String key,@JsonKey(name: 'plan_code') String planCode, String unit, int value,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$EntitlementDtoCopyWithImpl<$Res>
    implements _$EntitlementDtoCopyWith<$Res> {
  __$EntitlementDtoCopyWithImpl(this._self, this._then);

  final _EntitlementDto _self;
  final $Res Function(_EntitlementDto) _then;

/// Create a copy of EntitlementDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? createdAt = null,Object? description = freezed,Object? key = null,Object? planCode = null,Object? unit = null,Object? value = null,Object? updatedAt = null,}) {
  return _then(_EntitlementDto(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,planCode: null == planCode ? _self.planCode : planCode // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
