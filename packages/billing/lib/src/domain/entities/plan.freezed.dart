// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Plan {

 bool get active; int get billingIntervalDays; String get code; DateTime get createdAt; String get createdBy; String get currency; String get description; String get name; num get price; DateTime get updatedAt; bool get visible;
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCopyWith<Plan> get copyWith => _$PlanCopyWithImpl<Plan>(this as Plan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Plan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plan&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.billingIntervalDays, _this.billingIntervalDays) || other.billingIntervalDays == _this.billingIntervalDays)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.createdBy, _this.createdBy) || other.createdBy == _this.createdBy)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.visible, _this.visible) || other.visible == _this.visible));
}


@override
int get hashCode {
  final _this = this as Plan;
  return Object.hash(runtimeType,_this.active,_this.billingIntervalDays,_this.code,_this.createdAt,_this.createdBy,_this.currency,_this.description,_this.name,_this.price,_this.updatedAt,_this.visible);
}

@override
String toString() {
  final _this = this as Plan;
  return 'Plan(active: ${_this.active}, billingIntervalDays: ${_this.billingIntervalDays}, code: ${_this.code}, createdAt: ${_this.createdAt}, createdBy: ${_this.createdBy}, currency: ${_this.currency}, description: ${_this.description}, name: ${_this.name}, price: ${_this.price}, updatedAt: ${_this.updatedAt}, visible: ${_this.visible})';
}


}

/// @nodoc
abstract mixin class $PlanCopyWith<$Res>  {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) _then) = _$PlanCopyWithImpl;
@useResult
$Res call({
 bool active, int billingIntervalDays, String code, DateTime createdAt, String createdBy, String currency, String description, String name, num price, DateTime updatedAt, bool visible
});




}
/// @nodoc
class _$PlanCopyWithImpl<$Res>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._self, this._then);

  final Plan _self;
  final $Res Function(Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? active = null,Object? billingIntervalDays = null,Object? code = null,Object? createdAt = null,Object? createdBy = null,Object? currency = null,Object? description = null,Object? name = null,Object? price = null,Object? updatedAt = null,Object? visible = null,}) {
  return _then(Plan(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,billingIntervalDays: null == billingIntervalDays ? _self.billingIntervalDays : billingIntervalDays // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Plan].
extension PlanPatterns on Plan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plan value)  $default,){
final _that = this;
switch (_that) {
case _Plan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plan value)?  $default,){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool active,  int billingIntervalDays,  String code,  DateTime createdAt,  String createdBy,  String currency,  String description,  String name,  num price,  DateTime updatedAt,  bool visible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.active,_that.billingIntervalDays,_that.code,_that.createdAt,_that.createdBy,_that.currency,_that.description,_that.name,_that.price,_that.updatedAt,_that.visible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool active,  int billingIntervalDays,  String code,  DateTime createdAt,  String createdBy,  String currency,  String description,  String name,  num price,  DateTime updatedAt,  bool visible)  $default,) {final _that = this;
switch (_that) {
case _Plan():
return $default(_that.active,_that.billingIntervalDays,_that.code,_that.createdAt,_that.createdBy,_that.currency,_that.description,_that.name,_that.price,_that.updatedAt,_that.visible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool active,  int billingIntervalDays,  String code,  DateTime createdAt,  String createdBy,  String currency,  String description,  String name,  num price,  DateTime updatedAt,  bool visible)?  $default,) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.active,_that.billingIntervalDays,_that.code,_that.createdAt,_that.createdBy,_that.currency,_that.description,_that.name,_that.price,_that.updatedAt,_that.visible);case _:
  return null;

}
}

}

/// @nodoc


class _Plan implements Plan {
  const _Plan({required this.active, required this.billingIntervalDays, required this.code, required this.createdAt, required this.createdBy, required this.currency, required this.description, required this.name, required this.price, required this.updatedAt, required this.visible});
  

@override final  bool active;
@override final  int billingIntervalDays;
@override final  String code;
@override final  DateTime createdAt;
@override final  String createdBy;
@override final  String currency;
@override final  String description;
@override final  String name;
@override final  num price;
@override final  DateTime updatedAt;
@override final  bool visible;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plan&&(identical(other.active, active) || other.active == active)&&(identical(other.billingIntervalDays, billingIntervalDays) || other.billingIntervalDays == billingIntervalDays)&&(identical(other.code, code) || other.code == code)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.visible, visible) || other.visible == visible));
}


@override
int get hashCode {
    return Object.hash(runtimeType,active,billingIntervalDays,code,createdAt,createdBy,currency,description,name,price,updatedAt,visible);
}

@override
String toString() {
    return 'Plan(active: $active, billingIntervalDays: $billingIntervalDays, code: $code, createdAt: $createdAt, createdBy: $createdBy, currency: $currency, description: $description, name: $name, price: $price, updatedAt: $updatedAt, visible: $visible)';
}


}

/// @nodoc
abstract mixin class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) _then) = __$PlanCopyWithImpl;
@override @useResult
$Res call({
 bool active, int billingIntervalDays, String code, DateTime createdAt, String createdBy, String currency, String description, String name, num price, DateTime updatedAt, bool visible
});




}
/// @nodoc
class __$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(this._self, this._then);

  final _Plan _self;
  final $Res Function(_Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? active = null,Object? billingIntervalDays = null,Object? code = null,Object? createdAt = null,Object? createdBy = null,Object? currency = null,Object? description = null,Object? name = null,Object? price = null,Object? updatedAt = null,Object? visible = null,}) {
  return _then(_Plan(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,billingIntervalDays: null == billingIntervalDays ? _self.billingIntervalDays : billingIntervalDays // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
