// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_order_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateOrderDto {

 String get currency;@JsonKey(name: 'expires_at') DateTime? get expiresAt; List<int> get metadata;@JsonKey(name: 'user_id') String? get userId;
/// Create a copy of CreateOrderDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateOrderDtoCopyWith<CreateOrderDto> get copyWith => _$CreateOrderDtoCopyWithImpl<CreateOrderDto>(this as CreateOrderDto, _$identity);

  /// Serializes this CreateOrderDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateOrderDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateOrderDto&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&const DeepCollectionEquality().equals(other.metadata, _this.metadata)&&(identical(other.userId, _this.userId) || other.userId == _this.userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateOrderDto;
  return Object.hash(runtimeType,_this.currency,_this.expiresAt,const DeepCollectionEquality().hash(_this.metadata),_this.userId);
}

@override
String toString() {
  final _this = this as CreateOrderDto;
  return 'CreateOrderDto(currency: ${_this.currency}, expiresAt: ${_this.expiresAt}, metadata: ${_this.metadata}, userId: ${_this.userId})';
}


}

/// @nodoc
abstract mixin class $CreateOrderDtoCopyWith<$Res>  {
  factory $CreateOrderDtoCopyWith(CreateOrderDto value, $Res Function(CreateOrderDto) _then) = _$CreateOrderDtoCopyWithImpl;
@useResult
$Res call({
 String currency,@JsonKey(name: 'expires_at') DateTime? expiresAt, List<int> metadata,@JsonKey(name: 'user_id') String? userId
});




}
/// @nodoc
class _$CreateOrderDtoCopyWithImpl<$Res>
    implements $CreateOrderDtoCopyWith<$Res> {
  _$CreateOrderDtoCopyWithImpl(this._self, this._then);

  final CreateOrderDto _self;
  final $Res Function(CreateOrderDto) _then;

/// Create a copy of CreateOrderDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currency = null,Object? expiresAt = freezed,Object? metadata = null,Object? userId = freezed,}) {
  return _then(CreateOrderDto(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as List<int>,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateOrderDto].
extension CreateOrderDtoPatterns on CreateOrderDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateOrderDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateOrderDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateOrderDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateOrderDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateOrderDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateOrderDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currency, @JsonKey(name: 'expires_at')  DateTime? expiresAt,  List<int> metadata, @JsonKey(name: 'user_id')  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateOrderDto() when $default != null:
return $default(_that.currency,_that.expiresAt,_that.metadata,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currency, @JsonKey(name: 'expires_at')  DateTime? expiresAt,  List<int> metadata, @JsonKey(name: 'user_id')  String? userId)  $default,) {final _that = this;
switch (_that) {
case _CreateOrderDto():
return $default(_that.currency,_that.expiresAt,_that.metadata,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currency, @JsonKey(name: 'expires_at')  DateTime? expiresAt,  List<int> metadata, @JsonKey(name: 'user_id')  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _CreateOrderDto() when $default != null:
return $default(_that.currency,_that.expiresAt,_that.metadata,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateOrderDto implements CreateOrderDto {
  const _CreateOrderDto({required this.currency, @JsonKey(name: 'expires_at') this.expiresAt,  List<int> metadata = const <int>[], @JsonKey(name: 'user_id') this.userId}): _metadata = metadata;
  factory _CreateOrderDto.fromJson(Map<String, dynamic> json) => _$CreateOrderDtoFromJson(json);

@override final  String currency;
@override@JsonKey(name: 'expires_at') final  DateTime? expiresAt;
 final  List<int> _metadata;
@override@JsonKey() List<int> get metadata {
  if (_metadata is EqualUnmodifiableListView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_metadata);
}

@override@JsonKey(name: 'user_id') final  String? userId;

/// Create a copy of CreateOrderDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateOrderDtoCopyWith<_CreateOrderDto> get copyWith => __$CreateOrderDtoCopyWithImpl<_CreateOrderDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateOrderDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateOrderDto&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other.metadata, _metadata)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,currency,expiresAt,const DeepCollectionEquality().hash(_metadata),userId);
}

@override
String toString() {
    return 'CreateOrderDto(currency: $currency, expiresAt: $expiresAt, metadata: $metadata, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$CreateOrderDtoCopyWith<$Res> implements $CreateOrderDtoCopyWith<$Res> {
  factory _$CreateOrderDtoCopyWith(_CreateOrderDto value, $Res Function(_CreateOrderDto) _then) = __$CreateOrderDtoCopyWithImpl;
@override @useResult
$Res call({
 String currency,@JsonKey(name: 'expires_at') DateTime? expiresAt, List<int> metadata,@JsonKey(name: 'user_id') String? userId
});




}
/// @nodoc
class __$CreateOrderDtoCopyWithImpl<$Res>
    implements _$CreateOrderDtoCopyWith<$Res> {
  __$CreateOrderDtoCopyWithImpl(this._self, this._then);

  final _CreateOrderDto _self;
  final $Res Function(_CreateOrderDto) _then;

/// Create a copy of CreateOrderDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currency = null,Object? expiresAt = freezed,Object? metadata = null,Object? userId = freezed,}) {
  return _then(_CreateOrderDto(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as List<int>,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
