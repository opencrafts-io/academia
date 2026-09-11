// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderItem {

 String get id; String get orderId; int get planId; int get quantity; int get unitPrice; int get discount; int get tax; String get addedBy; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemCopyWith<OrderItem> get copyWith => _$OrderItemCopyWithImpl<OrderItem>(this as OrderItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OrderItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.planId, _this.planId) || other.planId == _this.planId)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.unitPrice, _this.unitPrice) || other.unitPrice == _this.unitPrice)&&(identical(other.discount, _this.discount) || other.discount == _this.discount)&&(identical(other.tax, _this.tax) || other.tax == _this.tax)&&(identical(other.addedBy, _this.addedBy) || other.addedBy == _this.addedBy)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as OrderItem;
  return Object.hash(runtimeType,_this.id,_this.orderId,_this.planId,_this.quantity,_this.unitPrice,_this.discount,_this.tax,_this.addedBy,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as OrderItem;
  return 'OrderItem(id: ${_this.id}, orderId: ${_this.orderId}, planId: ${_this.planId}, quantity: ${_this.quantity}, unitPrice: ${_this.unitPrice}, discount: ${_this.discount}, tax: ${_this.tax}, addedBy: ${_this.addedBy}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $OrderItemCopyWith<$Res>  {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) _then) = _$OrderItemCopyWithImpl;
@useResult
$Res call({
 String id, String orderId, int planId, int quantity, int unitPrice, int discount, int tax, String addedBy, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$OrderItemCopyWithImpl<$Res>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._self, this._then);

  final OrderItem _self;
  final $Res Function(OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? planId = null,Object? quantity = null,Object? unitPrice = null,Object? discount = null,Object? tax = null,Object? addedBy = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(OrderItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as int,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as int,addedBy: null == addedBy ? _self.addedBy : addedBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderItem].
extension OrderItemPatterns on OrderItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItem value)  $default,){
final _that = this;
switch (_that) {
case _OrderItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItem value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderId,  int planId,  int quantity,  int unitPrice,  int discount,  int tax,  String addedBy,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
return $default(_that.id,_that.orderId,_that.planId,_that.quantity,_that.unitPrice,_that.discount,_that.tax,_that.addedBy,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderId,  int planId,  int quantity,  int unitPrice,  int discount,  int tax,  String addedBy,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _OrderItem():
return $default(_that.id,_that.orderId,_that.planId,_that.quantity,_that.unitPrice,_that.discount,_that.tax,_that.addedBy,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderId,  int planId,  int quantity,  int unitPrice,  int discount,  int tax,  String addedBy,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
return $default(_that.id,_that.orderId,_that.planId,_that.quantity,_that.unitPrice,_that.discount,_that.tax,_that.addedBy,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _OrderItem implements OrderItem {
  const _OrderItem({required this.id, required this.orderId, required this.planId, required this.quantity, required this.unitPrice, required this.discount, required this.tax, required this.addedBy, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String orderId;
@override final  int planId;
@override final  int quantity;
@override final  int unitPrice;
@override final  int discount;
@override final  int tax;
@override final  String addedBy;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemCopyWith<_OrderItem> get copyWith => __$OrderItemCopyWithImpl<_OrderItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.addedBy, addedBy) || other.addedBy == addedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,orderId,planId,quantity,unitPrice,discount,tax,addedBy,createdAt,updatedAt);
}

@override
String toString() {
    return 'OrderItem(id: $id, orderId: $orderId, planId: $planId, quantity: $quantity, unitPrice: $unitPrice, discount: $discount, tax: $tax, addedBy: $addedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$OrderItemCopyWith<$Res> implements $OrderItemCopyWith<$Res> {
  factory _$OrderItemCopyWith(_OrderItem value, $Res Function(_OrderItem) _then) = __$OrderItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderId, int planId, int quantity, int unitPrice, int discount, int tax, String addedBy, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$OrderItemCopyWithImpl<$Res>
    implements _$OrderItemCopyWith<$Res> {
  __$OrderItemCopyWithImpl(this._self, this._then);

  final _OrderItem _self;
  final $Res Function(_OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? planId = null,Object? quantity = null,Object? unitPrice = null,Object? discount = null,Object? tax = null,Object? addedBy = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_OrderItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as int,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as int,addedBy: null == addedBy ? _self.addedBy : addedBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
