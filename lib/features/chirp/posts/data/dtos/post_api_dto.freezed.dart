// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostApiDto {

 int get id; CommunityApiDto get community;@JsonKey(name: 'author_id') String get authorId; String get title; String get content; int get upvotes; int get downvotes; List<AttachmentApiDto> get attachments;@JsonKey(name: 'views_count') int get viewsCount;@JsonKey(name: 'comment_count') int get commentCount; List<CommentApiDto> get comments;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of PostApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostApiDtoCopyWith<PostApiDto> get copyWith => _$PostApiDtoCopyWithImpl<PostApiDto>(this as PostApiDto, _$identity);

  /// Serializes this PostApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.community, community) || other.community == community)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.upvotes, upvotes) || other.upvotes == upvotes)&&(identical(other.downvotes, downvotes) || other.downvotes == downvotes)&&const DeepCollectionEquality().equals(other.attachments, attachments)&&(identical(other.viewsCount, viewsCount) || other.viewsCount == viewsCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,community,authorId,title,content,upvotes,downvotes,const DeepCollectionEquality().hash(attachments),viewsCount,commentCount,const DeepCollectionEquality().hash(comments),createdAt,updatedAt);

@override
String toString() {
  return 'PostApiDto(id: $id, community: $community, authorId: $authorId, title: $title, content: $content, upvotes: $upvotes, downvotes: $downvotes, attachments: $attachments, viewsCount: $viewsCount, commentCount: $commentCount, comments: $comments, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PostApiDtoCopyWith<$Res>  {
  factory $PostApiDtoCopyWith(PostApiDto value, $Res Function(PostApiDto) _then) = _$PostApiDtoCopyWithImpl;
@useResult
$Res call({
 int id, CommunityApiDto community,@JsonKey(name: 'author_id') String authorId, String title, String content, int upvotes, int downvotes, List<AttachmentApiDto> attachments,@JsonKey(name: 'views_count') int viewsCount,@JsonKey(name: 'comment_count') int commentCount, List<CommentApiDto> comments,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});


$CommunityApiDtoCopyWith<$Res> get community;

}
/// @nodoc
class _$PostApiDtoCopyWithImpl<$Res>
    implements $PostApiDtoCopyWith<$Res> {
  _$PostApiDtoCopyWithImpl(this._self, this._then);

  final PostApiDto _self;
  final $Res Function(PostApiDto) _then;

/// Create a copy of PostApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? community = null,Object? authorId = null,Object? title = null,Object? content = null,Object? upvotes = null,Object? downvotes = null,Object? attachments = null,Object? viewsCount = null,Object? commentCount = null,Object? comments = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,community: null == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as CommunityApiDto,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,upvotes: null == upvotes ? _self.upvotes : upvotes // ignore: cast_nullable_to_non_nullable
as int,downvotes: null == downvotes ? _self.downvotes : downvotes // ignore: cast_nullable_to_non_nullable
as int,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<AttachmentApiDto>,viewsCount: null == viewsCount ? _self.viewsCount : viewsCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentApiDto>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of PostApiDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunityApiDtoCopyWith<$Res> get community {
  
  return $CommunityApiDtoCopyWith<$Res>(_self.community, (value) {
    return _then(_self.copyWith(community: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostApiDto].
extension PostApiDtoPatterns on PostApiDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostApiDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostApiDto value)  $default,){
final _that = this;
switch (_that) {
case _PostApiDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _PostApiDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  CommunityApiDto community, @JsonKey(name: 'author_id')  String authorId,  String title,  String content,  int upvotes,  int downvotes,  List<AttachmentApiDto> attachments, @JsonKey(name: 'views_count')  int viewsCount, @JsonKey(name: 'comment_count')  int commentCount,  List<CommentApiDto> comments, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostApiDto() when $default != null:
return $default(_that.id,_that.community,_that.authorId,_that.title,_that.content,_that.upvotes,_that.downvotes,_that.attachments,_that.viewsCount,_that.commentCount,_that.comments,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  CommunityApiDto community, @JsonKey(name: 'author_id')  String authorId,  String title,  String content,  int upvotes,  int downvotes,  List<AttachmentApiDto> attachments, @JsonKey(name: 'views_count')  int viewsCount, @JsonKey(name: 'comment_count')  int commentCount,  List<CommentApiDto> comments, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PostApiDto():
return $default(_that.id,_that.community,_that.authorId,_that.title,_that.content,_that.upvotes,_that.downvotes,_that.attachments,_that.viewsCount,_that.commentCount,_that.comments,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  CommunityApiDto community, @JsonKey(name: 'author_id')  String authorId,  String title,  String content,  int upvotes,  int downvotes,  List<AttachmentApiDto> attachments, @JsonKey(name: 'views_count')  int viewsCount, @JsonKey(name: 'comment_count')  int commentCount,  List<CommentApiDto> comments, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PostApiDto() when $default != null:
return $default(_that.id,_that.community,_that.authorId,_that.title,_that.content,_that.upvotes,_that.downvotes,_that.attachments,_that.viewsCount,_that.commentCount,_that.comments,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostApiDto implements PostApiDto {
  const _PostApiDto({required this.id, required this.community, @JsonKey(name: 'author_id') required this.authorId, required this.title, required this.content, this.upvotes = 0, this.downvotes = 0, final  List<AttachmentApiDto> attachments = const [], @JsonKey(name: 'views_count') this.viewsCount = 0, @JsonKey(name: 'comment_count') this.commentCount = 0, final  List<CommentApiDto> comments = const [], @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): _attachments = attachments,_comments = comments;
  factory _PostApiDto.fromJson(Map<String, dynamic> json) => _$PostApiDtoFromJson(json);

@override final  int id;
@override final  CommunityApiDto community;
@override@JsonKey(name: 'author_id') final  String authorId;
@override final  String title;
@override final  String content;
@override@JsonKey() final  int upvotes;
@override@JsonKey() final  int downvotes;
 final  List<AttachmentApiDto> _attachments;
@override@JsonKey() List<AttachmentApiDto> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

@override@JsonKey(name: 'views_count') final  int viewsCount;
@override@JsonKey(name: 'comment_count') final  int commentCount;
 final  List<CommentApiDto> _comments;
@override@JsonKey() List<CommentApiDto> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of PostApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostApiDtoCopyWith<_PostApiDto> get copyWith => __$PostApiDtoCopyWithImpl<_PostApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.community, community) || other.community == community)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.upvotes, upvotes) || other.upvotes == upvotes)&&(identical(other.downvotes, downvotes) || other.downvotes == downvotes)&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&(identical(other.viewsCount, viewsCount) || other.viewsCount == viewsCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,community,authorId,title,content,upvotes,downvotes,const DeepCollectionEquality().hash(_attachments),viewsCount,commentCount,const DeepCollectionEquality().hash(_comments),createdAt,updatedAt);

@override
String toString() {
  return 'PostApiDto(id: $id, community: $community, authorId: $authorId, title: $title, content: $content, upvotes: $upvotes, downvotes: $downvotes, attachments: $attachments, viewsCount: $viewsCount, commentCount: $commentCount, comments: $comments, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PostApiDtoCopyWith<$Res> implements $PostApiDtoCopyWith<$Res> {
  factory _$PostApiDtoCopyWith(_PostApiDto value, $Res Function(_PostApiDto) _then) = __$PostApiDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, CommunityApiDto community,@JsonKey(name: 'author_id') String authorId, String title, String content, int upvotes, int downvotes, List<AttachmentApiDto> attachments,@JsonKey(name: 'views_count') int viewsCount,@JsonKey(name: 'comment_count') int commentCount, List<CommentApiDto> comments,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});


@override $CommunityApiDtoCopyWith<$Res> get community;

}
/// @nodoc
class __$PostApiDtoCopyWithImpl<$Res>
    implements _$PostApiDtoCopyWith<$Res> {
  __$PostApiDtoCopyWithImpl(this._self, this._then);

  final _PostApiDto _self;
  final $Res Function(_PostApiDto) _then;

/// Create a copy of PostApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? community = null,Object? authorId = null,Object? title = null,Object? content = null,Object? upvotes = null,Object? downvotes = null,Object? attachments = null,Object? viewsCount = null,Object? commentCount = null,Object? comments = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PostApiDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,community: null == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as CommunityApiDto,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,upvotes: null == upvotes ? _self.upvotes : upvotes // ignore: cast_nullable_to_non_nullable
as int,downvotes: null == downvotes ? _self.downvotes : downvotes // ignore: cast_nullable_to_non_nullable
as int,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<AttachmentApiDto>,viewsCount: null == viewsCount ? _self.viewsCount : viewsCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentApiDto>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of PostApiDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunityApiDtoCopyWith<$Res> get community {
  
  return $CommunityApiDtoCopyWith<$Res>(_self.community, (value) {
    return _then(_self.copyWith(community: value));
  });
}
}

// dart format on
