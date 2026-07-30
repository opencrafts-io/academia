// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'block_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BlockApiDto {

 int get id;@JsonKey(name: 'block_type') String get blockType;@JsonKey(name: 'blocked_user') String? get blockedUser;@JsonKey(name: 'blocked_community') int? get blockedCommunity;@JsonKey(name: 'blocked_name') String? get blockedName;@JsonKey(name: 'blocked_image') String? get blockedImage;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of BlockApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockApiDtoCopyWith<BlockApiDto> get copyWith => _$BlockApiDtoCopyWithImpl<BlockApiDto>(this as BlockApiDto, _$identity);

  /// Serializes this BlockApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.blockType, blockType) || other.blockType == blockType)&&(identical(other.blockedUser, blockedUser) || other.blockedUser == blockedUser)&&(identical(other.blockedCommunity, blockedCommunity) || other.blockedCommunity == blockedCommunity)&&(identical(other.blockedName, blockedName) || other.blockedName == blockedName)&&(identical(other.blockedImage, blockedImage) || other.blockedImage == blockedImage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,blockType,blockedUser,blockedCommunity,blockedName,blockedImage,createdAt);

@override
String toString() {
  return 'BlockApiDto(id: $id, blockType: $blockType, blockedUser: $blockedUser, blockedCommunity: $blockedCommunity, blockedName: $blockedName, blockedImage: $blockedImage, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BlockApiDtoCopyWith<$Res>  {
  factory $BlockApiDtoCopyWith(BlockApiDto value, $Res Function(BlockApiDto) _then) = _$BlockApiDtoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'block_type') String blockType,@JsonKey(name: 'blocked_user') String? blockedUser,@JsonKey(name: 'blocked_community') int? blockedCommunity,@JsonKey(name: 'blocked_name') String? blockedName,@JsonKey(name: 'blocked_image') String? blockedImage,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$BlockApiDtoCopyWithImpl<$Res>
    implements $BlockApiDtoCopyWith<$Res> {
  _$BlockApiDtoCopyWithImpl(this._self, this._then);

  final BlockApiDto _self;
  final $Res Function(BlockApiDto) _then;

/// Create a copy of BlockApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? blockType = null,Object? blockedUser = freezed,Object? blockedCommunity = freezed,Object? blockedName = freezed,Object? blockedImage = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,blockType: null == blockType ? _self.blockType : blockType // ignore: cast_nullable_to_non_nullable
as String,blockedUser: freezed == blockedUser ? _self.blockedUser : blockedUser // ignore: cast_nullable_to_non_nullable
as String?,blockedCommunity: freezed == blockedCommunity ? _self.blockedCommunity : blockedCommunity // ignore: cast_nullable_to_non_nullable
as int?,blockedName: freezed == blockedName ? _self.blockedName : blockedName // ignore: cast_nullable_to_non_nullable
as String?,blockedImage: freezed == blockedImage ? _self.blockedImage : blockedImage // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockApiDto].
extension BlockApiDtoPatterns on BlockApiDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockApiDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockApiDto value)  $default,){
final _that = this;
switch (_that) {
case _BlockApiDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _BlockApiDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'block_type')  String blockType, @JsonKey(name: 'blocked_user')  String? blockedUser, @JsonKey(name: 'blocked_community')  int? blockedCommunity, @JsonKey(name: 'blocked_name')  String? blockedName, @JsonKey(name: 'blocked_image')  String? blockedImage, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockApiDto() when $default != null:
return $default(_that.id,_that.blockType,_that.blockedUser,_that.blockedCommunity,_that.blockedName,_that.blockedImage,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'block_type')  String blockType, @JsonKey(name: 'blocked_user')  String? blockedUser, @JsonKey(name: 'blocked_community')  int? blockedCommunity, @JsonKey(name: 'blocked_name')  String? blockedName, @JsonKey(name: 'blocked_image')  String? blockedImage, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _BlockApiDto():
return $default(_that.id,_that.blockType,_that.blockedUser,_that.blockedCommunity,_that.blockedName,_that.blockedImage,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'block_type')  String blockType, @JsonKey(name: 'blocked_user')  String? blockedUser, @JsonKey(name: 'blocked_community')  int? blockedCommunity, @JsonKey(name: 'blocked_name')  String? blockedName, @JsonKey(name: 'blocked_image')  String? blockedImage, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BlockApiDto() when $default != null:
return $default(_that.id,_that.blockType,_that.blockedUser,_that.blockedCommunity,_that.blockedName,_that.blockedImage,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlockApiDto implements BlockApiDto {
  const _BlockApiDto({required this.id, @JsonKey(name: 'block_type') required this.blockType, @JsonKey(name: 'blocked_user') this.blockedUser, @JsonKey(name: 'blocked_community') this.blockedCommunity, @JsonKey(name: 'blocked_name') this.blockedName, @JsonKey(name: 'blocked_image') this.blockedImage, @JsonKey(name: 'created_at') required this.createdAt});
  factory _BlockApiDto.fromJson(Map<String, dynamic> json) => _$BlockApiDtoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'block_type') final  String blockType;
@override@JsonKey(name: 'blocked_user') final  String? blockedUser;
@override@JsonKey(name: 'blocked_community') final  int? blockedCommunity;
@override@JsonKey(name: 'blocked_name') final  String? blockedName;
@override@JsonKey(name: 'blocked_image') final  String? blockedImage;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of BlockApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockApiDtoCopyWith<_BlockApiDto> get copyWith => __$BlockApiDtoCopyWithImpl<_BlockApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlockApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.blockType, blockType) || other.blockType == blockType)&&(identical(other.blockedUser, blockedUser) || other.blockedUser == blockedUser)&&(identical(other.blockedCommunity, blockedCommunity) || other.blockedCommunity == blockedCommunity)&&(identical(other.blockedName, blockedName) || other.blockedName == blockedName)&&(identical(other.blockedImage, blockedImage) || other.blockedImage == blockedImage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,blockType,blockedUser,blockedCommunity,blockedName,blockedImage,createdAt);

@override
String toString() {
  return 'BlockApiDto(id: $id, blockType: $blockType, blockedUser: $blockedUser, blockedCommunity: $blockedCommunity, blockedName: $blockedName, blockedImage: $blockedImage, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BlockApiDtoCopyWith<$Res> implements $BlockApiDtoCopyWith<$Res> {
  factory _$BlockApiDtoCopyWith(_BlockApiDto value, $Res Function(_BlockApiDto) _then) = __$BlockApiDtoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'block_type') String blockType,@JsonKey(name: 'blocked_user') String? blockedUser,@JsonKey(name: 'blocked_community') int? blockedCommunity,@JsonKey(name: 'blocked_name') String? blockedName,@JsonKey(name: 'blocked_image') String? blockedImage,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$BlockApiDtoCopyWithImpl<$Res>
    implements _$BlockApiDtoCopyWith<$Res> {
  __$BlockApiDtoCopyWithImpl(this._self, this._then);

  final _BlockApiDto _self;
  final $Res Function(_BlockApiDto) _then;

/// Create a copy of BlockApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? blockType = null,Object? blockedUser = freezed,Object? blockedCommunity = freezed,Object? blockedName = freezed,Object? blockedImage = freezed,Object? createdAt = null,}) {
  return _then(_BlockApiDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,blockType: null == blockType ? _self.blockType : blockType // ignore: cast_nullable_to_non_nullable
as String,blockedUser: freezed == blockedUser ? _self.blockedUser : blockedUser // ignore: cast_nullable_to_non_nullable
as String?,blockedCommunity: freezed == blockedCommunity ? _self.blockedCommunity : blockedCommunity // ignore: cast_nullable_to_non_nullable
as int?,blockedName: freezed == blockedName ? _self.blockedName : blockedName // ignore: cast_nullable_to_non_nullable
as String?,blockedImage: freezed == blockedImage ? _self.blockedImage : blockedImage // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
