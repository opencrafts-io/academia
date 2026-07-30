// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Attachments {

 int get id; int get postId; String get attachmentType; String get file; String get name; int get size; DateTime get createdAt;
/// Create a copy of Attachments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttachmentsCopyWith<Attachments> get copyWith => _$AttachmentsCopyWithImpl<Attachments>(this as Attachments, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Attachments&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.attachmentType, attachmentType) || other.attachmentType == attachmentType)&&(identical(other.file, file) || other.file == file)&&(identical(other.name, name) || other.name == name)&&(identical(other.size, size) || other.size == size)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,postId,attachmentType,file,name,size,createdAt);

@override
String toString() {
  return 'Attachments(id: $id, postId: $postId, attachmentType: $attachmentType, file: $file, name: $name, size: $size, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AttachmentsCopyWith<$Res>  {
  factory $AttachmentsCopyWith(Attachments value, $Res Function(Attachments) _then) = _$AttachmentsCopyWithImpl;
@useResult
$Res call({
 int id, int postId, String attachmentType, String file, String name, int size, DateTime createdAt
});




}
/// @nodoc
class _$AttachmentsCopyWithImpl<$Res>
    implements $AttachmentsCopyWith<$Res> {
  _$AttachmentsCopyWithImpl(this._self, this._then);

  final Attachments _self;
  final $Res Function(Attachments) _then;

/// Create a copy of Attachments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? postId = null,Object? attachmentType = null,Object? file = null,Object? name = null,Object? size = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,attachmentType: null == attachmentType ? _self.attachmentType : attachmentType // ignore: cast_nullable_to_non_nullable
as String,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Attachments].
extension AttachmentsPatterns on Attachments {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Attachments value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Attachments() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Attachments value)  $default,){
final _that = this;
switch (_that) {
case _Attachments():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Attachments value)?  $default,){
final _that = this;
switch (_that) {
case _Attachments() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int postId,  String attachmentType,  String file,  String name,  int size,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Attachments() when $default != null:
return $default(_that.id,_that.postId,_that.attachmentType,_that.file,_that.name,_that.size,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int postId,  String attachmentType,  String file,  String name,  int size,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Attachments():
return $default(_that.id,_that.postId,_that.attachmentType,_that.file,_that.name,_that.size,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int postId,  String attachmentType,  String file,  String name,  int size,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Attachments() when $default != null:
return $default(_that.id,_that.postId,_that.attachmentType,_that.file,_that.name,_that.size,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Attachments implements Attachments {
  const _Attachments({required this.id, required this.postId, required this.attachmentType, required this.file, required this.name, required this.size, required this.createdAt});
  

@override final  int id;
@override final  int postId;
@override final  String attachmentType;
@override final  String file;
@override final  String name;
@override final  int size;
@override final  DateTime createdAt;

/// Create a copy of Attachments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachmentsCopyWith<_Attachments> get copyWith => __$AttachmentsCopyWithImpl<_Attachments>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Attachments&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.attachmentType, attachmentType) || other.attachmentType == attachmentType)&&(identical(other.file, file) || other.file == file)&&(identical(other.name, name) || other.name == name)&&(identical(other.size, size) || other.size == size)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,postId,attachmentType,file,name,size,createdAt);

@override
String toString() {
  return 'Attachments(id: $id, postId: $postId, attachmentType: $attachmentType, file: $file, name: $name, size: $size, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AttachmentsCopyWith<$Res> implements $AttachmentsCopyWith<$Res> {
  factory _$AttachmentsCopyWith(_Attachments value, $Res Function(_Attachments) _then) = __$AttachmentsCopyWithImpl;
@override @useResult
$Res call({
 int id, int postId, String attachmentType, String file, String name, int size, DateTime createdAt
});




}
/// @nodoc
class __$AttachmentsCopyWithImpl<$Res>
    implements _$AttachmentsCopyWith<$Res> {
  __$AttachmentsCopyWithImpl(this._self, this._then);

  final _Attachments _self;
  final $Res Function(_Attachments) _then;

/// Create a copy of Attachments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? postId = null,Object? attachmentType = null,Object? file = null,Object? name = null,Object? size = null,Object? createdAt = null,}) {
  return _then(_Attachments(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,attachmentType: null == attachmentType ? _self.attachmentType : attachmentType // ignore: cast_nullable_to_non_nullable
as String,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
