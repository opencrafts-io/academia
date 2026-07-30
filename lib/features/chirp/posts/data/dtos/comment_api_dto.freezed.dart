// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentApiDto {

 int get id; int get post;@JsonKey(name: 'author_id') String get authorId; String get content;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt; int get upvotes; int get downvotes; List<CommentApiDto> get replies; int? get parent;
/// Create a copy of CommentApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentApiDtoCopyWith<CommentApiDto> get copyWith => _$CommentApiDtoCopyWithImpl<CommentApiDto>(this as CommentApiDto, _$identity);

  /// Serializes this CommentApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.post, post) || other.post == post)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.upvotes, upvotes) || other.upvotes == upvotes)&&(identical(other.downvotes, downvotes) || other.downvotes == downvotes)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.parent, parent) || other.parent == parent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,post,authorId,content,createdAt,updatedAt,upvotes,downvotes,const DeepCollectionEquality().hash(replies),parent);

@override
String toString() {
  return 'CommentApiDto(id: $id, post: $post, authorId: $authorId, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, upvotes: $upvotes, downvotes: $downvotes, replies: $replies, parent: $parent)';
}


}

/// @nodoc
abstract mixin class $CommentApiDtoCopyWith<$Res>  {
  factory $CommentApiDtoCopyWith(CommentApiDto value, $Res Function(CommentApiDto) _then) = _$CommentApiDtoCopyWithImpl;
@useResult
$Res call({
 int id, int post,@JsonKey(name: 'author_id') String authorId, String content,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, int upvotes, int downvotes, List<CommentApiDto> replies, int? parent
});




}
/// @nodoc
class _$CommentApiDtoCopyWithImpl<$Res>
    implements $CommentApiDtoCopyWith<$Res> {
  _$CommentApiDtoCopyWithImpl(this._self, this._then);

  final CommentApiDto _self;
  final $Res Function(CommentApiDto) _then;

/// Create a copy of CommentApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? post = null,Object? authorId = null,Object? content = null,Object? createdAt = null,Object? updatedAt = null,Object? upvotes = null,Object? downvotes = null,Object? replies = null,Object? parent = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as int,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,upvotes: null == upvotes ? _self.upvotes : upvotes // ignore: cast_nullable_to_non_nullable
as int,downvotes: null == downvotes ? _self.downvotes : downvotes // ignore: cast_nullable_to_non_nullable
as int,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentApiDto>,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentApiDto].
extension CommentApiDtoPatterns on CommentApiDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentApiDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentApiDto value)  $default,){
final _that = this;
switch (_that) {
case _CommentApiDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommentApiDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int post, @JsonKey(name: 'author_id')  String authorId,  String content, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  int upvotes,  int downvotes,  List<CommentApiDto> replies,  int? parent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentApiDto() when $default != null:
return $default(_that.id,_that.post,_that.authorId,_that.content,_that.createdAt,_that.updatedAt,_that.upvotes,_that.downvotes,_that.replies,_that.parent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int post, @JsonKey(name: 'author_id')  String authorId,  String content, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  int upvotes,  int downvotes,  List<CommentApiDto> replies,  int? parent)  $default,) {final _that = this;
switch (_that) {
case _CommentApiDto():
return $default(_that.id,_that.post,_that.authorId,_that.content,_that.createdAt,_that.updatedAt,_that.upvotes,_that.downvotes,_that.replies,_that.parent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int post, @JsonKey(name: 'author_id')  String authorId,  String content, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  int upvotes,  int downvotes,  List<CommentApiDto> replies,  int? parent)?  $default,) {final _that = this;
switch (_that) {
case _CommentApiDto() when $default != null:
return $default(_that.id,_that.post,_that.authorId,_that.content,_that.createdAt,_that.updatedAt,_that.upvotes,_that.downvotes,_that.replies,_that.parent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentApiDto implements CommentApiDto {
  const _CommentApiDto({required this.id, required this.post, @JsonKey(name: 'author_id') required this.authorId, required this.content, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, this.upvotes = 0, this.downvotes = 0, final  List<CommentApiDto> replies = const [], this.parent}): _replies = replies;
  factory _CommentApiDto.fromJson(Map<String, dynamic> json) => _$CommentApiDtoFromJson(json);

@override final  int id;
@override final  int post;
@override@JsonKey(name: 'author_id') final  String authorId;
@override final  String content;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override@JsonKey() final  int upvotes;
@override@JsonKey() final  int downvotes;
 final  List<CommentApiDto> _replies;
@override@JsonKey() List<CommentApiDto> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override final  int? parent;

/// Create a copy of CommentApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentApiDtoCopyWith<_CommentApiDto> get copyWith => __$CommentApiDtoCopyWithImpl<_CommentApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.post, post) || other.post == post)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.upvotes, upvotes) || other.upvotes == upvotes)&&(identical(other.downvotes, downvotes) || other.downvotes == downvotes)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.parent, parent) || other.parent == parent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,post,authorId,content,createdAt,updatedAt,upvotes,downvotes,const DeepCollectionEquality().hash(_replies),parent);

@override
String toString() {
  return 'CommentApiDto(id: $id, post: $post, authorId: $authorId, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, upvotes: $upvotes, downvotes: $downvotes, replies: $replies, parent: $parent)';
}


}

/// @nodoc
abstract mixin class _$CommentApiDtoCopyWith<$Res> implements $CommentApiDtoCopyWith<$Res> {
  factory _$CommentApiDtoCopyWith(_CommentApiDto value, $Res Function(_CommentApiDto) _then) = __$CommentApiDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int post,@JsonKey(name: 'author_id') String authorId, String content,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, int upvotes, int downvotes, List<CommentApiDto> replies, int? parent
});




}
/// @nodoc
class __$CommentApiDtoCopyWithImpl<$Res>
    implements _$CommentApiDtoCopyWith<$Res> {
  __$CommentApiDtoCopyWithImpl(this._self, this._then);

  final _CommentApiDto _self;
  final $Res Function(_CommentApiDto) _then;

/// Create a copy of CommentApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? post = null,Object? authorId = null,Object? content = null,Object? createdAt = null,Object? updatedAt = null,Object? upvotes = null,Object? downvotes = null,Object? replies = null,Object? parent = freezed,}) {
  return _then(_CommentApiDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as int,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,upvotes: null == upvotes ? _self.upvotes : upvotes // ignore: cast_nullable_to_non_nullable
as int,downvotes: null == downvotes ? _self.downvotes : downvotes // ignore: cast_nullable_to_non_nullable
as int,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentApiDto>,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
