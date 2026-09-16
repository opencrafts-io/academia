// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachment_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttachmentApiDto {

 int get id;@JsonKey(name: 'attachment_type') String get attachmentType; String get file;@JsonKey(name: 'file_size') int get size;@JsonKey(name: 'original_filename') String get name;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'post') int get postId;
/// Create a copy of AttachmentApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttachmentApiDtoCopyWith<AttachmentApiDto> get copyWith => _$AttachmentApiDtoCopyWithImpl<AttachmentApiDto>(this as AttachmentApiDto, _$identity);

  /// Serializes this AttachmentApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttachmentApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.attachmentType, attachmentType) || other.attachmentType == attachmentType)&&(identical(other.file, file) || other.file == file)&&(identical(other.size, size) || other.size == size)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.postId, postId) || other.postId == postId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attachmentType,file,size,name,createdAt,postId);

@override
String toString() {
  return 'AttachmentApiDto(id: $id, attachmentType: $attachmentType, file: $file, size: $size, name: $name, createdAt: $createdAt, postId: $postId)';
}


}

/// @nodoc
abstract mixin class $AttachmentApiDtoCopyWith<$Res>  {
  factory $AttachmentApiDtoCopyWith(AttachmentApiDto value, $Res Function(AttachmentApiDto) _then) = _$AttachmentApiDtoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'attachment_type') String attachmentType, String file,@JsonKey(name: 'file_size') int size,@JsonKey(name: 'original_filename') String name,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'post') int postId
});




}
/// @nodoc
class _$AttachmentApiDtoCopyWithImpl<$Res>
    implements $AttachmentApiDtoCopyWith<$Res> {
  _$AttachmentApiDtoCopyWithImpl(this._self, this._then);

  final AttachmentApiDto _self;
  final $Res Function(AttachmentApiDto) _then;

/// Create a copy of AttachmentApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? attachmentType = null,Object? file = null,Object? size = null,Object? name = null,Object? createdAt = null,Object? postId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,attachmentType: null == attachmentType ? _self.attachmentType : attachmentType // ignore: cast_nullable_to_non_nullable
as String,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AttachmentApiDto].
extension AttachmentApiDtoPatterns on AttachmentApiDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttachmentApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttachmentApiDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttachmentApiDto value)  $default,){
final _that = this;
switch (_that) {
case _AttachmentApiDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttachmentApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _AttachmentApiDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'attachment_type')  String attachmentType,  String file, @JsonKey(name: 'file_size')  int size, @JsonKey(name: 'original_filename')  String name, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'post')  int postId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttachmentApiDto() when $default != null:
return $default(_that.id,_that.attachmentType,_that.file,_that.size,_that.name,_that.createdAt,_that.postId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'attachment_type')  String attachmentType,  String file, @JsonKey(name: 'file_size')  int size, @JsonKey(name: 'original_filename')  String name, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'post')  int postId)  $default,) {final _that = this;
switch (_that) {
case _AttachmentApiDto():
return $default(_that.id,_that.attachmentType,_that.file,_that.size,_that.name,_that.createdAt,_that.postId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'attachment_type')  String attachmentType,  String file, @JsonKey(name: 'file_size')  int size, @JsonKey(name: 'original_filename')  String name, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'post')  int postId)?  $default,) {final _that = this;
switch (_that) {
case _AttachmentApiDto() when $default != null:
return $default(_that.id,_that.attachmentType,_that.file,_that.size,_that.name,_that.createdAt,_that.postId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttachmentApiDto implements AttachmentApiDto {
  const _AttachmentApiDto({required this.id, @JsonKey(name: 'attachment_type') required this.attachmentType, required this.file, @JsonKey(name: 'file_size') required this.size, @JsonKey(name: 'original_filename') required this.name, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'post') required this.postId});
  factory _AttachmentApiDto.fromJson(Map<String, dynamic> json) => _$AttachmentApiDtoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'attachment_type') final  String attachmentType;
@override final  String file;
@override@JsonKey(name: 'file_size') final  int size;
@override@JsonKey(name: 'original_filename') final  String name;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'post') final  int postId;

/// Create a copy of AttachmentApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachmentApiDtoCopyWith<_AttachmentApiDto> get copyWith => __$AttachmentApiDtoCopyWithImpl<_AttachmentApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttachmentApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttachmentApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.attachmentType, attachmentType) || other.attachmentType == attachmentType)&&(identical(other.file, file) || other.file == file)&&(identical(other.size, size) || other.size == size)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.postId, postId) || other.postId == postId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attachmentType,file,size,name,createdAt,postId);

@override
String toString() {
  return 'AttachmentApiDto(id: $id, attachmentType: $attachmentType, file: $file, size: $size, name: $name, createdAt: $createdAt, postId: $postId)';
}


}

/// @nodoc
abstract mixin class _$AttachmentApiDtoCopyWith<$Res> implements $AttachmentApiDtoCopyWith<$Res> {
  factory _$AttachmentApiDtoCopyWith(_AttachmentApiDto value, $Res Function(_AttachmentApiDto) _then) = __$AttachmentApiDtoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'attachment_type') String attachmentType, String file,@JsonKey(name: 'file_size') int size,@JsonKey(name: 'original_filename') String name,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'post') int postId
});




}
/// @nodoc
class __$AttachmentApiDtoCopyWithImpl<$Res>
    implements _$AttachmentApiDtoCopyWith<$Res> {
  __$AttachmentApiDtoCopyWithImpl(this._self, this._then);

  final _AttachmentApiDto _self;
  final $Res Function(_AttachmentApiDto) _then;

/// Create a copy of AttachmentApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attachmentType = null,Object? file = null,Object? size = null,Object? name = null,Object? createdAt = null,Object? postId = null,}) {
  return _then(_AttachmentApiDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,attachmentType: null == attachmentType ? _self.attachmentType : attachmentType // ignore: cast_nullable_to_non_nullable
as String,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
