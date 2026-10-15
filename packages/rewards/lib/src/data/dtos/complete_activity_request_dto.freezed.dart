// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_activity_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompletionMetadataDto {

 String get source; String get event;
/// Create a copy of CompletionMetadataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompletionMetadataDtoCopyWith<CompletionMetadataDto> get copyWith => _$CompletionMetadataDtoCopyWithImpl<CompletionMetadataDto>(this as CompletionMetadataDto, _$identity);

  /// Serializes this CompletionMetadataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CompletionMetadataDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompletionMetadataDto&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.event, _this.event) || other.event == _this.event));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CompletionMetadataDto;
  return Object.hash(runtimeType,_this.source,_this.event);
}

@override
String toString() {
  final _this = this as CompletionMetadataDto;
  return 'CompletionMetadataDto(source: ${_this.source}, event: ${_this.event})';
}


}

/// @nodoc
abstract mixin class $CompletionMetadataDtoCopyWith<$Res>  {
  factory $CompletionMetadataDtoCopyWith(CompletionMetadataDto value, $Res Function(CompletionMetadataDto) _then) = _$CompletionMetadataDtoCopyWithImpl;
@useResult
$Res call({
 String source, String event
});




}
/// @nodoc
class _$CompletionMetadataDtoCopyWithImpl<$Res>
    implements $CompletionMetadataDtoCopyWith<$Res> {
  _$CompletionMetadataDtoCopyWithImpl(this._self, this._then);

  final CompletionMetadataDto _self;
  final $Res Function(CompletionMetadataDto) _then;

/// Create a copy of CompletionMetadataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? event = null,}) {
  return _then(CompletionMetadataDto(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CompletionMetadataDto].
extension CompletionMetadataDtoPatterns on CompletionMetadataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompletionMetadataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompletionMetadataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompletionMetadataDto value)  $default,){
final _that = this;
switch (_that) {
case _CompletionMetadataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompletionMetadataDto value)?  $default,){
final _that = this;
switch (_that) {
case _CompletionMetadataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String source,  String event)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompletionMetadataDto() when $default != null:
return $default(_that.source,_that.event);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String source,  String event)  $default,) {final _that = this;
switch (_that) {
case _CompletionMetadataDto():
return $default(_that.source,_that.event);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String source,  String event)?  $default,) {final _that = this;
switch (_that) {
case _CompletionMetadataDto() when $default != null:
return $default(_that.source,_that.event);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompletionMetadataDto implements CompletionMetadataDto {
  const _CompletionMetadataDto({required this.source, required this.event});
  factory _CompletionMetadataDto.fromJson(Map<String, dynamic> json) => _$CompletionMetadataDtoFromJson(json);

@override final  String source;
@override final  String event;

/// Create a copy of CompletionMetadataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompletionMetadataDtoCopyWith<_CompletionMetadataDto> get copyWith => __$CompletionMetadataDtoCopyWithImpl<_CompletionMetadataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompletionMetadataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompletionMetadataDto&&(identical(other.source, source) || other.source == source)&&(identical(other.event, event) || other.event == event));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,source,event);
}

@override
String toString() {
    return 'CompletionMetadataDto(source: $source, event: $event)';
}


}

/// @nodoc
abstract mixin class _$CompletionMetadataDtoCopyWith<$Res> implements $CompletionMetadataDtoCopyWith<$Res> {
  factory _$CompletionMetadataDtoCopyWith(_CompletionMetadataDto value, $Res Function(_CompletionMetadataDto) _then) = __$CompletionMetadataDtoCopyWithImpl;
@override @useResult
$Res call({
 String source, String event
});




}
/// @nodoc
class __$CompletionMetadataDtoCopyWithImpl<$Res>
    implements _$CompletionMetadataDtoCopyWith<$Res> {
  __$CompletionMetadataDtoCopyWithImpl(this._self, this._then);

  final _CompletionMetadataDto _self;
  final $Res Function(_CompletionMetadataDto) _then;

/// Create a copy of CompletionMetadataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? event = null,}) {
  return _then(_CompletionMetadataDto(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CompleteActivityRequestDto {

@JsonKey(name: 'account_id') String get accountId;@JsonKey(name: 'activity_id') String get activityId;@JsonKey(name: 'idempotency_key') String get idempotencyKey; CompletionMetadataDto get metadata;
/// Create a copy of CompleteActivityRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteActivityRequestDtoCopyWith<CompleteActivityRequestDto> get copyWith => _$CompleteActivityRequestDtoCopyWithImpl<CompleteActivityRequestDto>(this as CompleteActivityRequestDto, _$identity);

  /// Serializes this CompleteActivityRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CompleteActivityRequestDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteActivityRequestDto&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.idempotencyKey, _this.idempotencyKey) || other.idempotencyKey == _this.idempotencyKey)&&(identical(other.metadata, _this.metadata) || other.metadata == _this.metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CompleteActivityRequestDto;
  return Object.hash(runtimeType,_this.accountId,_this.activityId,_this.idempotencyKey,_this.metadata);
}

@override
String toString() {
  final _this = this as CompleteActivityRequestDto;
  return 'CompleteActivityRequestDto(accountId: ${_this.accountId}, activityId: ${_this.activityId}, idempotencyKey: ${_this.idempotencyKey}, metadata: ${_this.metadata})';
}


}

/// @nodoc
abstract mixin class $CompleteActivityRequestDtoCopyWith<$Res>  {
  factory $CompleteActivityRequestDtoCopyWith(CompleteActivityRequestDto value, $Res Function(CompleteActivityRequestDto) _then) = _$CompleteActivityRequestDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'account_id') String accountId,@JsonKey(name: 'activity_id') String activityId,@JsonKey(name: 'idempotency_key') String idempotencyKey, CompletionMetadataDto metadata
});


$CompletionMetadataDtoCopyWith<$Res> get metadata;

}
/// @nodoc
class _$CompleteActivityRequestDtoCopyWithImpl<$Res>
    implements $CompleteActivityRequestDtoCopyWith<$Res> {
  _$CompleteActivityRequestDtoCopyWithImpl(this._self, this._then);

  final CompleteActivityRequestDto _self;
  final $Res Function(CompleteActivityRequestDto) _then;

/// Create a copy of CompleteActivityRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? activityId = null,Object? idempotencyKey = null,Object? metadata = null,}) {
  return _then(CompleteActivityRequestDto(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as CompletionMetadataDto,
  ));
}
/// Create a copy of CompleteActivityRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompletionMetadataDtoCopyWith<$Res> get metadata {

  return $CompletionMetadataDtoCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompleteActivityRequestDto].
extension CompleteActivityRequestDtoPatterns on CompleteActivityRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompleteActivityRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompleteActivityRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompleteActivityRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CompleteActivityRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompleteActivityRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CompleteActivityRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'account_id')  String accountId, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'idempotency_key')  String idempotencyKey,  CompletionMetadataDto metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompleteActivityRequestDto() when $default != null:
return $default(_that.accountId,_that.activityId,_that.idempotencyKey,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'account_id')  String accountId, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'idempotency_key')  String idempotencyKey,  CompletionMetadataDto metadata)  $default,) {final _that = this;
switch (_that) {
case _CompleteActivityRequestDto():
return $default(_that.accountId,_that.activityId,_that.idempotencyKey,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'account_id')  String accountId, @JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'idempotency_key')  String idempotencyKey,  CompletionMetadataDto metadata)?  $default,) {final _that = this;
switch (_that) {
case _CompleteActivityRequestDto() when $default != null:
return $default(_that.accountId,_that.activityId,_that.idempotencyKey,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompleteActivityRequestDto implements CompleteActivityRequestDto {
  const _CompleteActivityRequestDto({@JsonKey(name: 'account_id') required this.accountId, @JsonKey(name: 'activity_id') required this.activityId, @JsonKey(name: 'idempotency_key') required this.idempotencyKey, required this.metadata});
  factory _CompleteActivityRequestDto.fromJson(Map<String, dynamic> json) => _$CompleteActivityRequestDtoFromJson(json);

@override@JsonKey(name: 'account_id') final  String accountId;
@override@JsonKey(name: 'activity_id') final  String activityId;
@override@JsonKey(name: 'idempotency_key') final  String idempotencyKey;
@override final  CompletionMetadataDto metadata;

/// Create a copy of CompleteActivityRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteActivityRequestDtoCopyWith<_CompleteActivityRequestDto> get copyWith => __$CompleteActivityRequestDtoCopyWithImpl<_CompleteActivityRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompleteActivityRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteActivityRequestDto&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,accountId,activityId,idempotencyKey,metadata);
}

@override
String toString() {
    return 'CompleteActivityRequestDto(accountId: $accountId, activityId: $activityId, idempotencyKey: $idempotencyKey, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$CompleteActivityRequestDtoCopyWith<$Res> implements $CompleteActivityRequestDtoCopyWith<$Res> {
  factory _$CompleteActivityRequestDtoCopyWith(_CompleteActivityRequestDto value, $Res Function(_CompleteActivityRequestDto) _then) = __$CompleteActivityRequestDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'account_id') String accountId,@JsonKey(name: 'activity_id') String activityId,@JsonKey(name: 'idempotency_key') String idempotencyKey, CompletionMetadataDto metadata
});


@override $CompletionMetadataDtoCopyWith<$Res> get metadata;

}
/// @nodoc
class __$CompleteActivityRequestDtoCopyWithImpl<$Res>
    implements _$CompleteActivityRequestDtoCopyWith<$Res> {
  __$CompleteActivityRequestDtoCopyWithImpl(this._self, this._then);

  final _CompleteActivityRequestDto _self;
  final $Res Function(_CompleteActivityRequestDto) _then;

/// Create a copy of CompleteActivityRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? activityId = null,Object? idempotencyKey = null,Object? metadata = null,}) {
  return _then(_CompleteActivityRequestDto(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as CompletionMetadataDto,
  ));
}

/// Create a copy of CompleteActivityRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompletionMetadataDtoCopyWith<$Res> get metadata {

  return $CompletionMetadataDtoCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
