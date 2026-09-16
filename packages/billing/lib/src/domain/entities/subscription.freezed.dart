// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Subscription {

 int get id; String get planCode; int get planId; String get planName; String get status; bool get cancelAtPeriodEnd; DateTime? get cancelledAt; DateTime get currentPeriodEnd; DateTime get currentPeriodStart; DateTime get startedAt;
/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionCopyWith<Subscription> get copyWith => _$SubscriptionCopyWithImpl<Subscription>(this as Subscription, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Subscription;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Subscription&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.planCode, _this.planCode) || other.planCode == _this.planCode)&&(identical(other.planId, _this.planId) || other.planId == _this.planId)&&(identical(other.planName, _this.planName) || other.planName == _this.planName)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.cancelAtPeriodEnd, _this.cancelAtPeriodEnd) || other.cancelAtPeriodEnd == _this.cancelAtPeriodEnd)&&(identical(other.cancelledAt, _this.cancelledAt) || other.cancelledAt == _this.cancelledAt)&&(identical(other.currentPeriodEnd, _this.currentPeriodEnd) || other.currentPeriodEnd == _this.currentPeriodEnd)&&(identical(other.currentPeriodStart, _this.currentPeriodStart) || other.currentPeriodStart == _this.currentPeriodStart)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt));
}


@override
int get hashCode {
  final _this = this as Subscription;
  return Object.hash(runtimeType,_this.id,_this.planCode,_this.planId,_this.planName,_this.status,_this.cancelAtPeriodEnd,_this.cancelledAt,_this.currentPeriodEnd,_this.currentPeriodStart,_this.startedAt);
}

@override
String toString() {
  final _this = this as Subscription;
  return 'Subscription(id: ${_this.id}, planCode: ${_this.planCode}, planId: ${_this.planId}, planName: ${_this.planName}, status: ${_this.status}, cancelAtPeriodEnd: ${_this.cancelAtPeriodEnd}, cancelledAt: ${_this.cancelledAt}, currentPeriodEnd: ${_this.currentPeriodEnd}, currentPeriodStart: ${_this.currentPeriodStart}, startedAt: ${_this.startedAt})';
}


}

/// @nodoc
abstract mixin class $SubscriptionCopyWith<$Res>  {
  factory $SubscriptionCopyWith(Subscription value, $Res Function(Subscription) _then) = _$SubscriptionCopyWithImpl;
@useResult
$Res call({
 int id, String planCode, int planId, String planName, String status, bool cancelAtPeriodEnd, DateTime? cancelledAt, DateTime currentPeriodEnd, DateTime currentPeriodStart, DateTime startedAt
});




}
/// @nodoc
class _$SubscriptionCopyWithImpl<$Res>
    implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._self, this._then);

  final Subscription _self;
  final $Res Function(Subscription) _then;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? planCode = null,Object? planId = null,Object? planName = null,Object? status = null,Object? cancelAtPeriodEnd = null,Object? cancelledAt = freezed,Object? currentPeriodEnd = null,Object? currentPeriodStart = null,Object? startedAt = null,}) {
  return _then(Subscription(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,planCode: null == planCode ? _self.planCode : planCode // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,cancelAtPeriodEnd: null == cancelAtPeriodEnd ? _self.cancelAtPeriodEnd : cancelAtPeriodEnd // ignore: cast_nullable_to_non_nullable
as bool,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentPeriodEnd: null == currentPeriodEnd ? _self.currentPeriodEnd : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,currentPeriodStart: null == currentPeriodStart ? _self.currentPeriodStart : currentPeriodStart // ignore: cast_nullable_to_non_nullable
as DateTime,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Subscription].
extension SubscriptionPatterns on Subscription {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Subscription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Subscription() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Subscription value)  $default,){
final _that = this;
switch (_that) {
case _Subscription():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Subscription value)?  $default,){
final _that = this;
switch (_that) {
case _Subscription() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String planCode,  int planId,  String planName,  String status,  bool cancelAtPeriodEnd,  DateTime? cancelledAt,  DateTime currentPeriodEnd,  DateTime currentPeriodStart,  DateTime startedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Subscription() when $default != null:
return $default(_that.id,_that.planCode,_that.planId,_that.planName,_that.status,_that.cancelAtPeriodEnd,_that.cancelledAt,_that.currentPeriodEnd,_that.currentPeriodStart,_that.startedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String planCode,  int planId,  String planName,  String status,  bool cancelAtPeriodEnd,  DateTime? cancelledAt,  DateTime currentPeriodEnd,  DateTime currentPeriodStart,  DateTime startedAt)  $default,) {final _that = this;
switch (_that) {
case _Subscription():
return $default(_that.id,_that.planCode,_that.planId,_that.planName,_that.status,_that.cancelAtPeriodEnd,_that.cancelledAt,_that.currentPeriodEnd,_that.currentPeriodStart,_that.startedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String planCode,  int planId,  String planName,  String status,  bool cancelAtPeriodEnd,  DateTime? cancelledAt,  DateTime currentPeriodEnd,  DateTime currentPeriodStart,  DateTime startedAt)?  $default,) {final _that = this;
switch (_that) {
case _Subscription() when $default != null:
return $default(_that.id,_that.planCode,_that.planId,_that.planName,_that.status,_that.cancelAtPeriodEnd,_that.cancelledAt,_that.currentPeriodEnd,_that.currentPeriodStart,_that.startedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Subscription implements Subscription {
  const _Subscription({required this.id, required this.planCode, required this.planId, required this.planName, required this.status, required this.cancelAtPeriodEnd, required this.cancelledAt, required this.currentPeriodEnd, required this.currentPeriodStart, required this.startedAt});


@override final  int id;
@override final  String planCode;
@override final  int planId;
@override final  String planName;
@override final  String status;
@override final  bool cancelAtPeriodEnd;
@override final  DateTime? cancelledAt;
@override final  DateTime currentPeriodEnd;
@override final  DateTime currentPeriodStart;
@override final  DateTime startedAt;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionCopyWith<_Subscription> get copyWith => __$SubscriptionCopyWithImpl<_Subscription>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Subscription&&(identical(other.id, id) || other.id == id)&&(identical(other.planCode, planCode) || other.planCode == planCode)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.status, status) || other.status == status)&&(identical(other.cancelAtPeriodEnd, cancelAtPeriodEnd) || other.cancelAtPeriodEnd == cancelAtPeriodEnd)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.currentPeriodEnd, currentPeriodEnd) || other.currentPeriodEnd == currentPeriodEnd)&&(identical(other.currentPeriodStart, currentPeriodStart) || other.currentPeriodStart == currentPeriodStart)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,planCode,planId,planName,status,cancelAtPeriodEnd,cancelledAt,currentPeriodEnd,currentPeriodStart,startedAt);
}

@override
String toString() {
    return 'Subscription(id: $id, planCode: $planCode, planId: $planId, planName: $planName, status: $status, cancelAtPeriodEnd: $cancelAtPeriodEnd, cancelledAt: $cancelledAt, currentPeriodEnd: $currentPeriodEnd, currentPeriodStart: $currentPeriodStart, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionCopyWith<$Res> implements $SubscriptionCopyWith<$Res> {
  factory _$SubscriptionCopyWith(_Subscription value, $Res Function(_Subscription) _then) = __$SubscriptionCopyWithImpl;
@override @useResult
$Res call({
 int id, String planCode, int planId, String planName, String status, bool cancelAtPeriodEnd, DateTime? cancelledAt, DateTime currentPeriodEnd, DateTime currentPeriodStart, DateTime startedAt
});




}
/// @nodoc
class __$SubscriptionCopyWithImpl<$Res>
    implements _$SubscriptionCopyWith<$Res> {
  __$SubscriptionCopyWithImpl(this._self, this._then);

  final _Subscription _self;
  final $Res Function(_Subscription) _then;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? planCode = null,Object? planId = null,Object? planName = null,Object? status = null,Object? cancelAtPeriodEnd = null,Object? cancelledAt = freezed,Object? currentPeriodEnd = null,Object? currentPeriodStart = null,Object? startedAt = null,}) {
  return _then(_Subscription(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,planCode: null == planCode ? _self.planCode : planCode // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,cancelAtPeriodEnd: null == cancelAtPeriodEnd ? _self.cancelAtPeriodEnd : cancelAtPeriodEnd // ignore: cast_nullable_to_non_nullable
as bool,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentPeriodEnd: null == currentPeriodEnd ? _self.currentPeriodEnd : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,currentPeriodStart: null == currentPeriodStart ? _self.currentPeriodStart : currentPeriodStart // ignore: cast_nullable_to_non_nullable
as DateTime,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
