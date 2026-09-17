// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {

 String get message; Object? get error; StackTrace? get stackTrace; String? get code; Map<String, dynamic>? get metadata;
/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this as Failure, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Failure;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.error, _this.error)&&(identical(other.stackTrace, _this.stackTrace) || other.stackTrace == _this.stackTrace)&&(identical(other.code, _this.code) || other.code == _this.code)&&const DeepCollectionEquality().equals(other.metadata, _this.metadata));
}


@override
int get hashCode {
  final _this = this as Failure;
  return Object.hash(runtimeType,_this.message,const DeepCollectionEquality().hash(_this.error),_this.stackTrace,_this.code,const DeepCollectionEquality().hash(_this.metadata));
}

@override
String toString() {
  final _this = this as Failure;
  return 'Failure(message: ${_this.message}, error: ${_this.error}, stackTrace: ${_this.stackTrace}, code: ${_this.code}, metadata: ${_this.metadata})';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res>  {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String message, Object? error, StackTrace? stackTrace, String? code, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? error = freezed,Object? stackTrace = freezed,Object? code = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServerFailure value)?  server,TResult Function( NetworkFailure value)?  network,TResult Function( AuthFailure value)?  auth,TResult Function( CacheFailure value)?  cache,TResult Function( ValidationFailure value)?  validation,TResult Function( UnexpectedFailure value)?  unexpected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that);case NetworkFailure() when network != null:
return network(_that);case AuthFailure() when auth != null:
return auth(_that);case CacheFailure() when cache != null:
return cache(_that);case ValidationFailure() when validation != null:
return validation(_that);case UnexpectedFailure() when unexpected != null:
return unexpected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServerFailure value)  server,required TResult Function( NetworkFailure value)  network,required TResult Function( AuthFailure value)  auth,required TResult Function( CacheFailure value)  cache,required TResult Function( ValidationFailure value)  validation,required TResult Function( UnexpectedFailure value)  unexpected,}){
final _that = this;
switch (_that) {
case ServerFailure():
return server(_that);case NetworkFailure():
return network(_that);case AuthFailure():
return auth(_that);case CacheFailure():
return cache(_that);case ValidationFailure():
return validation(_that);case UnexpectedFailure():
return unexpected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServerFailure value)?  server,TResult? Function( NetworkFailure value)?  network,TResult? Function( AuthFailure value)?  auth,TResult? Function( CacheFailure value)?  cache,TResult? Function( ValidationFailure value)?  validation,TResult? Function( UnexpectedFailure value)?  unexpected,}){
final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that);case NetworkFailure() when network != null:
return network(_that);case AuthFailure() when auth != null:
return auth(_that);case CacheFailure() when cache != null:
return cache(_that);case ValidationFailure() when validation != null:
return validation(_that);case UnexpectedFailure() when unexpected != null:
return unexpected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  int? statusCode,  Map<String, dynamic>? metadata)?  server,TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)?  network,TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  int? statusCode,  Map<String, dynamic>? metadata)?  auth,TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)?  cache,TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)?  validation,TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)?  unexpected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that.message,_that.error,_that.stackTrace,_that.code,_that.statusCode,_that.metadata);case NetworkFailure() when network != null:
return network(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case AuthFailure() when auth != null:
return auth(_that.message,_that.error,_that.stackTrace,_that.code,_that.statusCode,_that.metadata);case CacheFailure() when cache != null:
return cache(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case ValidationFailure() when validation != null:
return validation(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case UnexpectedFailure() when unexpected != null:
return unexpected(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  int? statusCode,  Map<String, dynamic>? metadata)  server,required TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)  network,required TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  int? statusCode,  Map<String, dynamic>? metadata)  auth,required TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)  cache,required TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)  validation,required TResult Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)  unexpected,}) {final _that = this;
switch (_that) {
case ServerFailure():
return server(_that.message,_that.error,_that.stackTrace,_that.code,_that.statusCode,_that.metadata);case NetworkFailure():
return network(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case AuthFailure():
return auth(_that.message,_that.error,_that.stackTrace,_that.code,_that.statusCode,_that.metadata);case CacheFailure():
return cache(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case ValidationFailure():
return validation(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case UnexpectedFailure():
return unexpected(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  int? statusCode,  Map<String, dynamic>? metadata)?  server,TResult? Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)?  network,TResult? Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  int? statusCode,  Map<String, dynamic>? metadata)?  auth,TResult? Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)?  cache,TResult? Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)?  validation,TResult? Function( String message,  Object? error,  StackTrace? stackTrace,  String? code,  Map<String, dynamic>? metadata)?  unexpected,}) {final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that.message,_that.error,_that.stackTrace,_that.code,_that.statusCode,_that.metadata);case NetworkFailure() when network != null:
return network(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case AuthFailure() when auth != null:
return auth(_that.message,_that.error,_that.stackTrace,_that.code,_that.statusCode,_that.metadata);case CacheFailure() when cache != null:
return cache(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case ValidationFailure() when validation != null:
return validation(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case UnexpectedFailure() when unexpected != null:
return unexpected(_that.message,_that.error,_that.stackTrace,_that.code,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc


class ServerFailure implements Failure {
  const ServerFailure({required this.message, this.error, this.stackTrace, this.code, this.statusCode,  Map<String, dynamic>? metadata}): _metadata = metadata;
  

@override final  String message;
@override final  Object? error;
@override final  StackTrace? stackTrace;
@override final  String? code;
 final  int? statusCode;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.code, code) || other.code == code)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.metadata, _metadata));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(error),stackTrace,code,statusCode,const DeepCollectionEquality().hash(_metadata));
}

@override
String toString() {
    return 'Failure.server(message: $message, error: $error, stackTrace: $stackTrace, code: $code, statusCode: $statusCode, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? error, StackTrace? stackTrace, String? code, int? statusCode, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? error = freezed,Object? stackTrace = freezed,Object? code = freezed,Object? statusCode = freezed,Object? metadata = freezed,}) {
  return _then(ServerFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class NetworkFailure implements Failure {
  const NetworkFailure({this.message = 'No internet connection', this.error, this.stackTrace, this.code,  Map<String, dynamic>? metadata}): _metadata = metadata;
  

@override@JsonKey() final  String message;
@override final  Object? error;
@override final  StackTrace? stackTrace;
@override final  String? code;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<NetworkFailure> get copyWith => _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.metadata, _metadata));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(error),stackTrace,code,const DeepCollectionEquality().hash(_metadata));
}

@override
String toString() {
    return 'Failure.network(message: $message, error: $error, stackTrace: $stackTrace, code: $code, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(NetworkFailure value, $Res Function(NetworkFailure) _then) = _$NetworkFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? error, StackTrace? stackTrace, String? code, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? error = freezed,Object? stackTrace = freezed,Object? code = freezed,Object? metadata = freezed,}) {
  return _then(NetworkFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class AuthFailure implements Failure {
  const AuthFailure({required this.message, this.error, this.stackTrace, this.code, this.statusCode,  Map<String, dynamic>? metadata}): _metadata = metadata;
  

@override final  String message;
@override final  Object? error;
@override final  StackTrace? stackTrace;
@override final  String? code;
 final  int? statusCode;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<AuthFailure> get copyWith => _$AuthFailureCopyWithImpl<AuthFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.code, code) || other.code == code)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.metadata, _metadata));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(error),stackTrace,code,statusCode,const DeepCollectionEquality().hash(_metadata));
}

@override
String toString() {
    return 'Failure.auth(message: $message, error: $error, stackTrace: $stackTrace, code: $code, statusCode: $statusCode, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $AuthFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(AuthFailure value, $Res Function(AuthFailure) _then) = _$AuthFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? error, StackTrace? stackTrace, String? code, int? statusCode, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$AuthFailureCopyWithImpl<$Res>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._self, this._then);

  final AuthFailure _self;
  final $Res Function(AuthFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? error = freezed,Object? stackTrace = freezed,Object? code = freezed,Object? statusCode = freezed,Object? metadata = freezed,}) {
  return _then(AuthFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class CacheFailure implements Failure {
  const CacheFailure({required this.message, this.error, this.stackTrace, this.code,  Map<String, dynamic>? metadata}): _metadata = metadata;
  

@override final  String message;
@override final  Object? error;
@override final  StackTrace? stackTrace;
@override final  String? code;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacheFailureCopyWith<CacheFailure> get copyWith => _$CacheFailureCopyWithImpl<CacheFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.metadata, _metadata));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(error),stackTrace,code,const DeepCollectionEquality().hash(_metadata));
}

@override
String toString() {
    return 'Failure.cache(message: $message, error: $error, stackTrace: $stackTrace, code: $code, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $CacheFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $CacheFailureCopyWith(CacheFailure value, $Res Function(CacheFailure) _then) = _$CacheFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? error, StackTrace? stackTrace, String? code, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$CacheFailureCopyWithImpl<$Res>
    implements $CacheFailureCopyWith<$Res> {
  _$CacheFailureCopyWithImpl(this._self, this._then);

  final CacheFailure _self;
  final $Res Function(CacheFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? error = freezed,Object? stackTrace = freezed,Object? code = freezed,Object? metadata = freezed,}) {
  return _then(CacheFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class ValidationFailure implements Failure {
  const ValidationFailure({required this.message, this.error, this.stackTrace, this.code,  Map<String, dynamic>? metadata}): _metadata = metadata;
  

@override final  String message;
@override final  Object? error;
@override final  StackTrace? stackTrace;
@override final  String? code;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationFailureCopyWith<ValidationFailure> get copyWith => _$ValidationFailureCopyWithImpl<ValidationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.metadata, _metadata));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(error),stackTrace,code,const DeepCollectionEquality().hash(_metadata));
}

@override
String toString() {
    return 'Failure.validation(message: $message, error: $error, stackTrace: $stackTrace, code: $code, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ValidationFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ValidationFailureCopyWith(ValidationFailure value, $Res Function(ValidationFailure) _then) = _$ValidationFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? error, StackTrace? stackTrace, String? code, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$ValidationFailureCopyWithImpl<$Res>
    implements $ValidationFailureCopyWith<$Res> {
  _$ValidationFailureCopyWithImpl(this._self, this._then);

  final ValidationFailure _self;
  final $Res Function(ValidationFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? error = freezed,Object? stackTrace = freezed,Object? code = freezed,Object? metadata = freezed,}) {
  return _then(ValidationFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class UnexpectedFailure implements Failure {
  const UnexpectedFailure({this.message = 'Unexpected error occurred', this.error, this.stackTrace, this.code,  Map<String, dynamic>? metadata}): _metadata = metadata;
  

@override@JsonKey() final  String message;
@override final  Object? error;
@override final  StackTrace? stackTrace;
@override final  String? code;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnexpectedFailureCopyWith<UnexpectedFailure> get copyWith => _$UnexpectedFailureCopyWithImpl<UnexpectedFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UnexpectedFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.metadata, _metadata));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(error),stackTrace,code,const DeepCollectionEquality().hash(_metadata));
}

@override
String toString() {
    return 'Failure.unexpected(message: $message, error: $error, stackTrace: $stackTrace, code: $code, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $UnexpectedFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnexpectedFailureCopyWith(UnexpectedFailure value, $Res Function(UnexpectedFailure) _then) = _$UnexpectedFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? error, StackTrace? stackTrace, String? code, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$UnexpectedFailureCopyWithImpl<$Res>
    implements $UnexpectedFailureCopyWith<$Res> {
  _$UnexpectedFailureCopyWithImpl(this._self, this._then);

  final UnexpectedFailure _self;
  final $Res Function(UnexpectedFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? error = freezed,Object? stackTrace = freezed,Object? code = freezed,Object? metadata = freezed,}) {
  return _then(UnexpectedFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
