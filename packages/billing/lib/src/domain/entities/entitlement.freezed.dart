// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entitlement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Entitlement {

 String? get description; String get key; String get planCode; String get unit; int get value; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Entitlement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntitlementCopyWith<Entitlement> get copyWith => _$EntitlementCopyWithImpl<Entitlement>(this as Entitlement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Entitlement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Entitlement&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.key, _this.key) || other.key == _this.key)&&(identical(other.planCode, _this.planCode) || other.planCode == _this.planCode)&&(identical(other.unit, _this.unit) || other.unit == _this.unit)&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as Entitlement;
  return Object.hash(runtimeType,_this.description,_this.key,_this.planCode,_this.unit,_this.value,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Entitlement;
  return 'Entitlement(description: ${_this.description}, key: ${_this.key}, planCode: ${_this.planCode}, unit: ${_this.unit}, value: ${_this.value}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $EntitlementCopyWith<$Res>  {
  factory $EntitlementCopyWith(Entitlement value, $Res Function(Entitlement) _then) = _$EntitlementCopyWithImpl;
@useResult
$Res call({
 String? description, String key, String planCode, String unit, int value, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$EntitlementCopyWithImpl<$Res>
    implements $EntitlementCopyWith<$Res> {
  _$EntitlementCopyWithImpl(this._self, this._then);

  final Entitlement _self;
  final $Res Function(Entitlement) _then;

/// Create a copy of Entitlement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = freezed,Object? key = null,Object? planCode = null,Object? unit = null,Object? value = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Entitlement(
description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,planCode: null == planCode ? _self.planCode : planCode // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Entitlement].
extension EntitlementPatterns on Entitlement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Entitlement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Entitlement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Entitlement value)  $default,){
final _that = this;
switch (_that) {
case _Entitlement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Entitlement value)?  $default,){
final _that = this;
switch (_that) {
case _Entitlement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? description,  String key,  String planCode,  String unit,  int value,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Entitlement() when $default != null:
return $default(_that.description,_that.key,_that.planCode,_that.unit,_that.value,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? description,  String key,  String planCode,  String unit,  int value,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Entitlement():
return $default(_that.description,_that.key,_that.planCode,_that.unit,_that.value,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? description,  String key,  String planCode,  String unit,  int value,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Entitlement() when $default != null:
return $default(_that.description,_that.key,_that.planCode,_that.unit,_that.value,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Entitlement implements Entitlement {
  const _Entitlement({required this.description, required this.key, required this.planCode, required this.unit, required this.value, required this.createdAt, required this.updatedAt});
  

@override final  String? description;
@override final  String key;
@override final  String planCode;
@override final  String unit;
@override final  int value;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Entitlement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntitlementCopyWith<_Entitlement> get copyWith => __$EntitlementCopyWithImpl<_Entitlement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Entitlement&&(identical(other.description, description) || other.description == description)&&(identical(other.key, key) || other.key == key)&&(identical(other.planCode, planCode) || other.planCode == planCode)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.value, value) || other.value == value)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,description,key,planCode,unit,value,createdAt,updatedAt);
}

@override
String toString() {
    return 'Entitlement(description: $description, key: $key, planCode: $planCode, unit: $unit, value: $value, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EntitlementCopyWith<$Res> implements $EntitlementCopyWith<$Res> {
  factory _$EntitlementCopyWith(_Entitlement value, $Res Function(_Entitlement) _then) = __$EntitlementCopyWithImpl;
@override @useResult
$Res call({
 String? description, String key, String planCode, String unit, int value, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$EntitlementCopyWithImpl<$Res>
    implements _$EntitlementCopyWith<$Res> {
  __$EntitlementCopyWithImpl(this._self, this._then);

  final _Entitlement _self;
  final $Res Function(_Entitlement) _then;

/// Create a copy of Entitlement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = freezed,Object? key = null,Object? planCode = null,Object? unit = null,Object? value = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Entitlement(
description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,planCode: null == planCode ? _self.planCode : planCode // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
