// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_status_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionStatusDto {

 bool get active; SubscriptionDto? get subscription;
/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStatusDtoCopyWith<SubscriptionStatusDto> get copyWith => _$SubscriptionStatusDtoCopyWithImpl<SubscriptionStatusDto>(this as SubscriptionStatusDto, _$identity);

  /// Serializes this SubscriptionStatusDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionStatusDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatusDto&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.subscription, _this.subscription) || other.subscription == _this.subscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionStatusDto;
  return Object.hash(runtimeType,_this.active,_this.subscription);
}

@override
String toString() {
  final _this = this as SubscriptionStatusDto;
  return 'SubscriptionStatusDto(active: ${_this.active}, subscription: ${_this.subscription})';
}


}

/// @nodoc
abstract mixin class $SubscriptionStatusDtoCopyWith<$Res>  {
  factory $SubscriptionStatusDtoCopyWith(SubscriptionStatusDto value, $Res Function(SubscriptionStatusDto) _then) = _$SubscriptionStatusDtoCopyWithImpl;
@useResult
$Res call({
 bool active, SubscriptionDto? subscription
});


$SubscriptionDtoCopyWith<$Res>? get subscription;

}
/// @nodoc
class _$SubscriptionStatusDtoCopyWithImpl<$Res>
    implements $SubscriptionStatusDtoCopyWith<$Res> {
  _$SubscriptionStatusDtoCopyWithImpl(this._self, this._then);

  final SubscriptionStatusDto _self;
  final $Res Function(SubscriptionStatusDto) _then;

/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? active = null,Object? subscription = freezed,}) {
  return _then(SubscriptionStatusDto(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as SubscriptionDto?,
  ));
}
/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionDtoCopyWith<$Res>? get subscription {
    if (_self.subscription == null) {
    return null;
  }

  return $SubscriptionDtoCopyWith<$Res>(_self.subscription!, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubscriptionStatusDto].
extension SubscriptionStatusDtoPatterns on SubscriptionStatusDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionStatusDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionStatusDto value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionStatusDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionStatusDto value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool active,  SubscriptionDto? subscription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
return $default(_that.active,_that.subscription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool active,  SubscriptionDto? subscription)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionStatusDto():
return $default(_that.active,_that.subscription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool active,  SubscriptionDto? subscription)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
return $default(_that.active,_that.subscription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionStatusDto implements SubscriptionStatusDto {
  const _SubscriptionStatusDto({required this.active, required this.subscription});
  factory _SubscriptionStatusDto.fromJson(Map<String, dynamic> json) => _$SubscriptionStatusDtoFromJson(json);

@override final  bool active;
@override final  SubscriptionDto? subscription;

/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionStatusDtoCopyWith<_SubscriptionStatusDto> get copyWith => __$SubscriptionStatusDtoCopyWithImpl<_SubscriptionStatusDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionStatusDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionStatusDto&&(identical(other.active, active) || other.active == active)&&(identical(other.subscription, subscription) || other.subscription == subscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,active,subscription);
}

@override
String toString() {
    return 'SubscriptionStatusDto(active: $active, subscription: $subscription)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionStatusDtoCopyWith<$Res> implements $SubscriptionStatusDtoCopyWith<$Res> {
  factory _$SubscriptionStatusDtoCopyWith(_SubscriptionStatusDto value, $Res Function(_SubscriptionStatusDto) _then) = __$SubscriptionStatusDtoCopyWithImpl;
@override @useResult
$Res call({
 bool active, SubscriptionDto? subscription
});


@override $SubscriptionDtoCopyWith<$Res>? get subscription;

}
/// @nodoc
class __$SubscriptionStatusDtoCopyWithImpl<$Res>
    implements _$SubscriptionStatusDtoCopyWith<$Res> {
  __$SubscriptionStatusDtoCopyWithImpl(this._self, this._then);

  final _SubscriptionStatusDto _self;
  final $Res Function(_SubscriptionStatusDto) _then;

/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? active = null,Object? subscription = freezed,}) {
  return _then(_SubscriptionStatusDto(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as SubscriptionDto?,
  ));
}

/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionDtoCopyWith<$Res>? get subscription {
    if (_self.subscription == null) {
    return null;
  }

  return $SubscriptionDtoCopyWith<$Res>(_self.subscription!, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}
}

// dart format on
