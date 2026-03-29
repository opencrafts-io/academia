// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenData {

@JsonKey(name: "verisafe") String get provider;@JsonKey(name: "access_token") String get accessToken;@JsonKey(name: "refresh_token") String get refreshToken;@JsonKey(name: "access_expires_at", fromJson: _dateFromJson, toJson: _dateToJson) DateTime get accessExpiresAt;@JsonKey(name: "refresh_expires_at", fromJson: _dateFromJson, toJson: _dateToJson) DateTime get refreshExpiresAt;
/// Create a copy of TokenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenDataCopyWith<TokenData> get copyWith => _$TokenDataCopyWithImpl<TokenData>(this as TokenData, _$identity);

  /// Serializes this TokenData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenData&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.accessExpiresAt, accessExpiresAt) || other.accessExpiresAt == accessExpiresAt)&&(identical(other.refreshExpiresAt, refreshExpiresAt) || other.refreshExpiresAt == refreshExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,accessToken,refreshToken,accessExpiresAt,refreshExpiresAt);

@override
String toString() {
  return 'TokenData(provider: $provider, accessToken: $accessToken, refreshToken: $refreshToken, accessExpiresAt: $accessExpiresAt, refreshExpiresAt: $refreshExpiresAt)';
}


}

/// @nodoc
abstract mixin class $TokenDataCopyWith<$Res>  {
  factory $TokenDataCopyWith(TokenData value, $Res Function(TokenData) _then) = _$TokenDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "verisafe") String provider,@JsonKey(name: "access_token") String accessToken,@JsonKey(name: "refresh_token") String refreshToken,@JsonKey(name: "access_expires_at", fromJson: _dateFromJson, toJson: _dateToJson) DateTime accessExpiresAt,@JsonKey(name: "refresh_expires_at", fromJson: _dateFromJson, toJson: _dateToJson) DateTime refreshExpiresAt
});




}
/// @nodoc
class _$TokenDataCopyWithImpl<$Res>
    implements $TokenDataCopyWith<$Res> {
  _$TokenDataCopyWithImpl(this._self, this._then);

  final TokenData _self;
  final $Res Function(TokenData) _then;

/// Create a copy of TokenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? accessToken = null,Object? refreshToken = null,Object? accessExpiresAt = null,Object? refreshExpiresAt = null,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,accessExpiresAt: null == accessExpiresAt ? _self.accessExpiresAt : accessExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,refreshExpiresAt: null == refreshExpiresAt ? _self.refreshExpiresAt : refreshExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenData].
extension TokenDataPatterns on TokenData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenData value)  $default,){
final _that = this;
switch (_that) {
case _TokenData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenData value)?  $default,){
final _that = this;
switch (_that) {
case _TokenData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "verisafe")  String provider, @JsonKey(name: "access_token")  String accessToken, @JsonKey(name: "refresh_token")  String refreshToken, @JsonKey(name: "access_expires_at", fromJson: _dateFromJson, toJson: _dateToJson)  DateTime accessExpiresAt, @JsonKey(name: "refresh_expires_at", fromJson: _dateFromJson, toJson: _dateToJson)  DateTime refreshExpiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenData() when $default != null:
return $default(_that.provider,_that.accessToken,_that.refreshToken,_that.accessExpiresAt,_that.refreshExpiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "verisafe")  String provider, @JsonKey(name: "access_token")  String accessToken, @JsonKey(name: "refresh_token")  String refreshToken, @JsonKey(name: "access_expires_at", fromJson: _dateFromJson, toJson: _dateToJson)  DateTime accessExpiresAt, @JsonKey(name: "refresh_expires_at", fromJson: _dateFromJson, toJson: _dateToJson)  DateTime refreshExpiresAt)  $default,) {final _that = this;
switch (_that) {
case _TokenData():
return $default(_that.provider,_that.accessToken,_that.refreshToken,_that.accessExpiresAt,_that.refreshExpiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "verisafe")  String provider, @JsonKey(name: "access_token")  String accessToken, @JsonKey(name: "refresh_token")  String refreshToken, @JsonKey(name: "access_expires_at", fromJson: _dateFromJson, toJson: _dateToJson)  DateTime accessExpiresAt, @JsonKey(name: "refresh_expires_at", fromJson: _dateFromJson, toJson: _dateToJson)  DateTime refreshExpiresAt)?  $default,) {final _that = this;
switch (_that) {
case _TokenData() when $default != null:
return $default(_that.provider,_that.accessToken,_that.refreshToken,_that.accessExpiresAt,_that.refreshExpiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenData implements TokenData {
  const _TokenData({@JsonKey(name: "verisafe") required this.provider, @JsonKey(name: "access_token") required this.accessToken, @JsonKey(name: "refresh_token") required this.refreshToken, @JsonKey(name: "access_expires_at", fromJson: _dateFromJson, toJson: _dateToJson) required this.accessExpiresAt, @JsonKey(name: "refresh_expires_at", fromJson: _dateFromJson, toJson: _dateToJson) required this.refreshExpiresAt});
  factory _TokenData.fromJson(Map<String, dynamic> json) => _$TokenDataFromJson(json);

@override@JsonKey(name: "verisafe") final  String provider;
@override@JsonKey(name: "access_token") final  String accessToken;
@override@JsonKey(name: "refresh_token") final  String refreshToken;
@override@JsonKey(name: "access_expires_at", fromJson: _dateFromJson, toJson: _dateToJson) final  DateTime accessExpiresAt;
@override@JsonKey(name: "refresh_expires_at", fromJson: _dateFromJson, toJson: _dateToJson) final  DateTime refreshExpiresAt;

/// Create a copy of TokenData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenDataCopyWith<_TokenData> get copyWith => __$TokenDataCopyWithImpl<_TokenData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenData&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.accessExpiresAt, accessExpiresAt) || other.accessExpiresAt == accessExpiresAt)&&(identical(other.refreshExpiresAt, refreshExpiresAt) || other.refreshExpiresAt == refreshExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,accessToken,refreshToken,accessExpiresAt,refreshExpiresAt);

@override
String toString() {
  return 'TokenData(provider: $provider, accessToken: $accessToken, refreshToken: $refreshToken, accessExpiresAt: $accessExpiresAt, refreshExpiresAt: $refreshExpiresAt)';
}


}

/// @nodoc
abstract mixin class _$TokenDataCopyWith<$Res> implements $TokenDataCopyWith<$Res> {
  factory _$TokenDataCopyWith(_TokenData value, $Res Function(_TokenData) _then) = __$TokenDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "verisafe") String provider,@JsonKey(name: "access_token") String accessToken,@JsonKey(name: "refresh_token") String refreshToken,@JsonKey(name: "access_expires_at", fromJson: _dateFromJson, toJson: _dateToJson) DateTime accessExpiresAt,@JsonKey(name: "refresh_expires_at", fromJson: _dateFromJson, toJson: _dateToJson) DateTime refreshExpiresAt
});




}
/// @nodoc
class __$TokenDataCopyWithImpl<$Res>
    implements _$TokenDataCopyWith<$Res> {
  __$TokenDataCopyWithImpl(this._self, this._then);

  final _TokenData _self;
  final $Res Function(_TokenData) _then;

/// Create a copy of TokenData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? accessToken = null,Object? refreshToken = null,Object? accessExpiresAt = null,Object? refreshExpiresAt = null,}) {
  return _then(_TokenData(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,accessExpiresAt: null == accessExpiresAt ? _self.accessExpiresAt : accessExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,refreshExpiresAt: null == refreshExpiresAt ? _self.refreshExpiresAt : refreshExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
