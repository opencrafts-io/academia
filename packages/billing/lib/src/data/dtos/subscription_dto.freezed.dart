// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionDto {

 int get id;@JsonKey(name: 'plan_code') String get planCode;@JsonKey(name: 'plan_id') int get planId;@JsonKey(name: 'plan_name') String get planName; String get status;@JsonKey(name: 'cancel_at_period_end') bool get cancelAtPeriodEnd;@JsonKey(name: 'cancelled_at') DateTime? get cancelledAt;@JsonKey(name: 'current_period_end') DateTime get currentPeriodEnd;@JsonKey(name: 'current_period_start') DateTime get currentPeriodStart;@JsonKey(name: 'started_at') DateTime get startedAt;
/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionDtoCopyWith<SubscriptionDto> get copyWith => _$SubscriptionDtoCopyWithImpl<SubscriptionDto>(this as SubscriptionDto, _$identity);

  /// Serializes this SubscriptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.planCode, _this.planCode) || other.planCode == _this.planCode)&&(identical(other.planId, _this.planId) || other.planId == _this.planId)&&(identical(other.planName, _this.planName) || other.planName == _this.planName)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.cancelAtPeriodEnd, _this.cancelAtPeriodEnd) || other.cancelAtPeriodEnd == _this.cancelAtPeriodEnd)&&(identical(other.cancelledAt, _this.cancelledAt) || other.cancelledAt == _this.cancelledAt)&&(identical(other.currentPeriodEnd, _this.currentPeriodEnd) || other.currentPeriodEnd == _this.currentPeriodEnd)&&(identical(other.currentPeriodStart, _this.currentPeriodStart) || other.currentPeriodStart == _this.currentPeriodStart)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionDto;
  return Object.hash(runtimeType,_this.id,_this.planCode,_this.planId,_this.planName,_this.status,_this.cancelAtPeriodEnd,_this.cancelledAt,_this.currentPeriodEnd,_this.currentPeriodStart,_this.startedAt);
}

@override
String toString() {
  final _this = this as SubscriptionDto;
  return 'SubscriptionDto(id: ${_this.id}, planCode: ${_this.planCode}, planId: ${_this.planId}, planName: ${_this.planName}, status: ${_this.status}, cancelAtPeriodEnd: ${_this.cancelAtPeriodEnd}, cancelledAt: ${_this.cancelledAt}, currentPeriodEnd: ${_this.currentPeriodEnd}, currentPeriodStart: ${_this.currentPeriodStart}, startedAt: ${_this.startedAt})';
}


}

/// @nodoc
abstract mixin class $SubscriptionDtoCopyWith<$Res>  {
  factory $SubscriptionDtoCopyWith(SubscriptionDto value, $Res Function(SubscriptionDto) _then) = _$SubscriptionDtoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'plan_code') String planCode,@JsonKey(name: 'plan_id') int planId,@JsonKey(name: 'plan_name') String planName, String status,@JsonKey(name: 'cancel_at_period_end') bool cancelAtPeriodEnd,@JsonKey(name: 'cancelled_at') DateTime? cancelledAt,@JsonKey(name: 'current_period_end') DateTime currentPeriodEnd,@JsonKey(name: 'current_period_start') DateTime currentPeriodStart,@JsonKey(name: 'started_at') DateTime startedAt
});




}
/// @nodoc
class _$SubscriptionDtoCopyWithImpl<$Res>
    implements $SubscriptionDtoCopyWith<$Res> {
  _$SubscriptionDtoCopyWithImpl(this._self, this._then);

  final SubscriptionDto _self;
  final $Res Function(SubscriptionDto) _then;

/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? planCode = null,Object? planId = null,Object? planName = null,Object? status = null,Object? cancelAtPeriodEnd = null,Object? cancelledAt = freezed,Object? currentPeriodEnd = null,Object? currentPeriodStart = null,Object? startedAt = null,}) {
  return _then(SubscriptionDto(
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


/// Adds pattern-matching-related methods to [SubscriptionDto].
extension SubscriptionDtoPatterns on SubscriptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionDto value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'plan_code')  String planCode, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'plan_name')  String planName,  String status, @JsonKey(name: 'cancel_at_period_end')  bool cancelAtPeriodEnd, @JsonKey(name: 'cancelled_at')  DateTime? cancelledAt, @JsonKey(name: 'current_period_end')  DateTime currentPeriodEnd, @JsonKey(name: 'current_period_start')  DateTime currentPeriodStart, @JsonKey(name: 'started_at')  DateTime startedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'plan_code')  String planCode, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'plan_name')  String planName,  String status, @JsonKey(name: 'cancel_at_period_end')  bool cancelAtPeriodEnd, @JsonKey(name: 'cancelled_at')  DateTime? cancelledAt, @JsonKey(name: 'current_period_end')  DateTime currentPeriodEnd, @JsonKey(name: 'current_period_start')  DateTime currentPeriodStart, @JsonKey(name: 'started_at')  DateTime startedAt)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'plan_code')  String planCode, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'plan_name')  String planName,  String status, @JsonKey(name: 'cancel_at_period_end')  bool cancelAtPeriodEnd, @JsonKey(name: 'cancelled_at')  DateTime? cancelledAt, @JsonKey(name: 'current_period_end')  DateTime currentPeriodEnd, @JsonKey(name: 'current_period_start')  DateTime currentPeriodStart, @JsonKey(name: 'started_at')  DateTime startedAt)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
return $default(_that.id,_that.planCode,_that.planId,_that.planName,_that.status,_that.cancelAtPeriodEnd,_that.cancelledAt,_that.currentPeriodEnd,_that.currentPeriodStart,_that.startedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionDto implements SubscriptionDto {
  const _SubscriptionDto({required this.id, @JsonKey(name: 'plan_code') required this.planCode, @JsonKey(name: 'plan_id') required this.planId, @JsonKey(name: 'plan_name') required this.planName, required this.status, @JsonKey(name: 'cancel_at_period_end') required this.cancelAtPeriodEnd, @JsonKey(name: 'cancelled_at') required this.cancelledAt, @JsonKey(name: 'current_period_end') required this.currentPeriodEnd, @JsonKey(name: 'current_period_start') required this.currentPeriodStart, @JsonKey(name: 'started_at') required this.startedAt});
  factory _SubscriptionDto.fromJson(Map<String, dynamic> json) => _$SubscriptionDtoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'plan_code') final  String planCode;
@override@JsonKey(name: 'plan_id') final  int planId;
@override@JsonKey(name: 'plan_name') final  String planName;
@override final  String status;
@override@JsonKey(name: 'cancel_at_period_end') final  bool cancelAtPeriodEnd;
@override@JsonKey(name: 'cancelled_at') final  DateTime? cancelledAt;
@override@JsonKey(name: 'current_period_end') final  DateTime currentPeriodEnd;
@override@JsonKey(name: 'current_period_start') final  DateTime currentPeriodStart;
@override@JsonKey(name: 'started_at') final  DateTime startedAt;

/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionDtoCopyWith<_SubscriptionDto> get copyWith => __$SubscriptionDtoCopyWithImpl<_SubscriptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.planCode, planCode) || other.planCode == planCode)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.status, status) || other.status == status)&&(identical(other.cancelAtPeriodEnd, cancelAtPeriodEnd) || other.cancelAtPeriodEnd == cancelAtPeriodEnd)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.currentPeriodEnd, currentPeriodEnd) || other.currentPeriodEnd == currentPeriodEnd)&&(identical(other.currentPeriodStart, currentPeriodStart) || other.currentPeriodStart == currentPeriodStart)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,planCode,planId,planName,status,cancelAtPeriodEnd,cancelledAt,currentPeriodEnd,currentPeriodStart,startedAt);
}

@override
String toString() {
    return 'SubscriptionDto(id: $id, planCode: $planCode, planId: $planId, planName: $planName, status: $status, cancelAtPeriodEnd: $cancelAtPeriodEnd, cancelledAt: $cancelledAt, currentPeriodEnd: $currentPeriodEnd, currentPeriodStart: $currentPeriodStart, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionDtoCopyWith<$Res> implements $SubscriptionDtoCopyWith<$Res> {
  factory _$SubscriptionDtoCopyWith(_SubscriptionDto value, $Res Function(_SubscriptionDto) _then) = __$SubscriptionDtoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'plan_code') String planCode,@JsonKey(name: 'plan_id') int planId,@JsonKey(name: 'plan_name') String planName, String status,@JsonKey(name: 'cancel_at_period_end') bool cancelAtPeriodEnd,@JsonKey(name: 'cancelled_at') DateTime? cancelledAt,@JsonKey(name: 'current_period_end') DateTime currentPeriodEnd,@JsonKey(name: 'current_period_start') DateTime currentPeriodStart,@JsonKey(name: 'started_at') DateTime startedAt
});




}
/// @nodoc
class __$SubscriptionDtoCopyWithImpl<$Res>
    implements _$SubscriptionDtoCopyWith<$Res> {
  __$SubscriptionDtoCopyWithImpl(this._self, this._then);

  final _SubscriptionDto _self;
  final $Res Function(_SubscriptionDto) _then;

/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? planCode = null,Object? planId = null,Object? planName = null,Object? status = null,Object? cancelAtPeriodEnd = null,Object? cancelledAt = freezed,Object? currentPeriodEnd = null,Object? currentPeriodStart = null,Object? startedAt = null,}) {
  return _then(_SubscriptionDto(
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
