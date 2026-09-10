// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_order_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateOrderItemDto {

@JsonKey(name: 'order_id') String get orderId;@JsonKey(name: 'plan_id') int get planId; int get quantity;@JsonKey(name: 'unit_price') int get unitPrice; int get discount; int get tax;@JsonKey(name: 'added_by') String? get addedBy;
/// Create a copy of CreateOrderItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateOrderItemDtoCopyWith<CreateOrderItemDto> get copyWith => _$CreateOrderItemDtoCopyWithImpl<CreateOrderItemDto>(this as CreateOrderItemDto, _$identity);

  /// Serializes this CreateOrderItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateOrderItemDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateOrderItemDto&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.planId, _this.planId) || other.planId == _this.planId)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.unitPrice, _this.unitPrice) || other.unitPrice == _this.unitPrice)&&(identical(other.discount, _this.discount) || other.discount == _this.discount)&&(identical(other.tax, _this.tax) || other.tax == _this.tax)&&(identical(other.addedBy, _this.addedBy) || other.addedBy == _this.addedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateOrderItemDto;
  return Object.hash(runtimeType,_this.orderId,_this.planId,_this.quantity,_this.unitPrice,_this.discount,_this.tax,_this.addedBy);
}

@override
String toString() {
  final _this = this as CreateOrderItemDto;
  return 'CreateOrderItemDto(orderId: ${_this.orderId}, planId: ${_this.planId}, quantity: ${_this.quantity}, unitPrice: ${_this.unitPrice}, discount: ${_this.discount}, tax: ${_this.tax}, addedBy: ${_this.addedBy})';
}


}

/// @nodoc
abstract mixin class $CreateOrderItemDtoCopyWith<$Res>  {
  factory $CreateOrderItemDtoCopyWith(CreateOrderItemDto value, $Res Function(CreateOrderItemDto) _then) = _$CreateOrderItemDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'order_id') String orderId,@JsonKey(name: 'plan_id') int planId, int quantity,@JsonKey(name: 'unit_price') int unitPrice, int discount, int tax,@JsonKey(name: 'added_by') String? addedBy
});




}
/// @nodoc
class _$CreateOrderItemDtoCopyWithImpl<$Res>
    implements $CreateOrderItemDtoCopyWith<$Res> {
  _$CreateOrderItemDtoCopyWithImpl(this._self, this._then);

  final CreateOrderItemDto _self;
  final $Res Function(CreateOrderItemDto) _then;

/// Create a copy of CreateOrderItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? planId = null,Object? quantity = null,Object? unitPrice = null,Object? discount = null,Object? tax = null,Object? addedBy = freezed,}) {
  return _then(CreateOrderItemDto(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as int,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as int,addedBy: freezed == addedBy ? _self.addedBy : addedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateOrderItemDto].
extension CreateOrderItemDtoPatterns on CreateOrderItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateOrderItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateOrderItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateOrderItemDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateOrderItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateOrderItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateOrderItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'order_id')  String orderId, @JsonKey(name: 'plan_id')  int planId,  int quantity, @JsonKey(name: 'unit_price')  int unitPrice,  int discount,  int tax, @JsonKey(name: 'added_by')  String? addedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateOrderItemDto() when $default != null:
return $default(_that.orderId,_that.planId,_that.quantity,_that.unitPrice,_that.discount,_that.tax,_that.addedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'order_id')  String orderId, @JsonKey(name: 'plan_id')  int planId,  int quantity, @JsonKey(name: 'unit_price')  int unitPrice,  int discount,  int tax, @JsonKey(name: 'added_by')  String? addedBy)  $default,) {final _that = this;
switch (_that) {
case _CreateOrderItemDto():
return $default(_that.orderId,_that.planId,_that.quantity,_that.unitPrice,_that.discount,_that.tax,_that.addedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'order_id')  String orderId, @JsonKey(name: 'plan_id')  int planId,  int quantity, @JsonKey(name: 'unit_price')  int unitPrice,  int discount,  int tax, @JsonKey(name: 'added_by')  String? addedBy)?  $default,) {final _that = this;
switch (_that) {
case _CreateOrderItemDto() when $default != null:
return $default(_that.orderId,_that.planId,_that.quantity,_that.unitPrice,_that.discount,_that.tax,_that.addedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateOrderItemDto implements CreateOrderItemDto {
  const _CreateOrderItemDto({@JsonKey(name: 'order_id') required this.orderId, @JsonKey(name: 'plan_id') required this.planId, required this.quantity, @JsonKey(name: 'unit_price') required this.unitPrice, this.discount = 0, this.tax = 0, @JsonKey(name: 'added_by') this.addedBy});
  factory _CreateOrderItemDto.fromJson(Map<String, dynamic> json) => _$CreateOrderItemDtoFromJson(json);

@override@JsonKey(name: 'order_id') final  String orderId;
@override@JsonKey(name: 'plan_id') final  int planId;
@override final  int quantity;
@override@JsonKey(name: 'unit_price') final  int unitPrice;
@override@JsonKey() final  int discount;
@override@JsonKey() final  int tax;
@override@JsonKey(name: 'added_by') final  String? addedBy;

/// Create a copy of CreateOrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateOrderItemDtoCopyWith<_CreateOrderItemDto> get copyWith => __$CreateOrderItemDtoCopyWithImpl<_CreateOrderItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateOrderItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateOrderItemDto&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.addedBy, addedBy) || other.addedBy == addedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,orderId,planId,quantity,unitPrice,discount,tax,addedBy);
}

@override
String toString() {
    return 'CreateOrderItemDto(orderId: $orderId, planId: $planId, quantity: $quantity, unitPrice: $unitPrice, discount: $discount, tax: $tax, addedBy: $addedBy)';
}


}

/// @nodoc
abstract mixin class _$CreateOrderItemDtoCopyWith<$Res> implements $CreateOrderItemDtoCopyWith<$Res> {
  factory _$CreateOrderItemDtoCopyWith(_CreateOrderItemDto value, $Res Function(_CreateOrderItemDto) _then) = __$CreateOrderItemDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'order_id') String orderId,@JsonKey(name: 'plan_id') int planId, int quantity,@JsonKey(name: 'unit_price') int unitPrice, int discount, int tax,@JsonKey(name: 'added_by') String? addedBy
});




}
/// @nodoc
class __$CreateOrderItemDtoCopyWithImpl<$Res>
    implements _$CreateOrderItemDtoCopyWith<$Res> {
  __$CreateOrderItemDtoCopyWithImpl(this._self, this._then);

  final _CreateOrderItemDto _self;
  final $Res Function(_CreateOrderItemDto) _then;

/// Create a copy of CreateOrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? planId = null,Object? quantity = null,Object? unitPrice = null,Object? discount = null,Object? tax = null,Object? addedBy = freezed,}) {
  return _then(_CreateOrderItemDto(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as int,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as int,addedBy: freezed == addedBy ? _self.addedBy : addedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
