// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState()';
}


}

/// @nodoc
class $FeedStateCopyWith<$Res>  {
$FeedStateCopyWith(FeedState _, $Res Function(FeedState) __);
}


/// Adds pattern-matching-related methods to [FeedState].
extension FeedStatePatterns on FeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FeedInitial value)?  initial,TResult Function( FeedLoading value)?  loading,TResult Function( FeedPaginationLoading value)?  paginationLoading,TResult Function( FeedLoaded value)?  loaded,TResult Function( FeedPaginationError value)?  paginationError,TResult Function( FeedError value)?  error,TResult Function( PostDetailLoading value)?  postDetailLoading,TResult Function( PostDetailLoaded value)?  postDetailLoaded,TResult Function( PostDetailError value)?  postDetailError,TResult Function( PostCreating value)?  postCreating,TResult Function( PostCreated value)?  postCreated,TResult Function( PostCreateError value)?  postCreateError,TResult Function( PostLikeError value)?  postLikeError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FeedInitial() when initial != null:
return initial(_that);case FeedLoading() when loading != null:
return loading(_that);case FeedPaginationLoading() when paginationLoading != null:
return paginationLoading(_that);case FeedLoaded() when loaded != null:
return loaded(_that);case FeedPaginationError() when paginationError != null:
return paginationError(_that);case FeedError() when error != null:
return error(_that);case PostDetailLoading() when postDetailLoading != null:
return postDetailLoading(_that);case PostDetailLoaded() when postDetailLoaded != null:
return postDetailLoaded(_that);case PostDetailError() when postDetailError != null:
return postDetailError(_that);case PostCreating() when postCreating != null:
return postCreating(_that);case PostCreated() when postCreated != null:
return postCreated(_that);case PostCreateError() when postCreateError != null:
return postCreateError(_that);case PostLikeError() when postLikeError != null:
return postLikeError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FeedInitial value)  initial,required TResult Function( FeedLoading value)  loading,required TResult Function( FeedPaginationLoading value)  paginationLoading,required TResult Function( FeedLoaded value)  loaded,required TResult Function( FeedPaginationError value)  paginationError,required TResult Function( FeedError value)  error,required TResult Function( PostDetailLoading value)  postDetailLoading,required TResult Function( PostDetailLoaded value)  postDetailLoaded,required TResult Function( PostDetailError value)  postDetailError,required TResult Function( PostCreating value)  postCreating,required TResult Function( PostCreated value)  postCreated,required TResult Function( PostCreateError value)  postCreateError,required TResult Function( PostLikeError value)  postLikeError,}){
final _that = this;
switch (_that) {
case FeedInitial():
return initial(_that);case FeedLoading():
return loading(_that);case FeedPaginationLoading():
return paginationLoading(_that);case FeedLoaded():
return loaded(_that);case FeedPaginationError():
return paginationError(_that);case FeedError():
return error(_that);case PostDetailLoading():
return postDetailLoading(_that);case PostDetailLoaded():
return postDetailLoaded(_that);case PostDetailError():
return postDetailError(_that);case PostCreating():
return postCreating(_that);case PostCreated():
return postCreated(_that);case PostCreateError():
return postCreateError(_that);case PostLikeError():
return postLikeError(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FeedInitial value)?  initial,TResult? Function( FeedLoading value)?  loading,TResult? Function( FeedPaginationLoading value)?  paginationLoading,TResult? Function( FeedLoaded value)?  loaded,TResult? Function( FeedPaginationError value)?  paginationError,TResult? Function( FeedError value)?  error,TResult? Function( PostDetailLoading value)?  postDetailLoading,TResult? Function( PostDetailLoaded value)?  postDetailLoaded,TResult? Function( PostDetailError value)?  postDetailError,TResult? Function( PostCreating value)?  postCreating,TResult? Function( PostCreated value)?  postCreated,TResult? Function( PostCreateError value)?  postCreateError,TResult? Function( PostLikeError value)?  postLikeError,}){
final _that = this;
switch (_that) {
case FeedInitial() when initial != null:
return initial(_that);case FeedLoading() when loading != null:
return loading(_that);case FeedPaginationLoading() when paginationLoading != null:
return paginationLoading(_that);case FeedLoaded() when loaded != null:
return loaded(_that);case FeedPaginationError() when paginationError != null:
return paginationError(_that);case FeedError() when error != null:
return error(_that);case PostDetailLoading() when postDetailLoading != null:
return postDetailLoading(_that);case PostDetailLoaded() when postDetailLoaded != null:
return postDetailLoaded(_that);case PostDetailError() when postDetailError != null:
return postDetailError(_that);case PostCreating() when postCreating != null:
return postCreating(_that);case PostCreated() when postCreated != null:
return postCreated(_that);case PostCreateError() when postCreateError != null:
return postCreateError(_that);case PostLikeError() when postLikeError != null:
return postLikeError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Post> existingPosts,  bool hasMore)?  paginationLoading,TResult Function( List<Post> posts,  String? next,  String? previous,  int count,  bool hasMore)?  loaded,TResult Function( List<Post> existingPosts,  String message,  bool hasMore)?  paginationError,TResult Function( String message)?  error,TResult Function()?  postDetailLoading,TResult Function( Post post)?  postDetailLoaded,TResult Function( String message)?  postDetailError,TResult Function()?  postCreating,TResult Function( List<Post> posts)?  postCreated,TResult Function( String message)?  postCreateError,TResult Function( Post post,  String message)?  postLikeError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FeedInitial() when initial != null:
return initial();case FeedLoading() when loading != null:
return loading();case FeedPaginationLoading() when paginationLoading != null:
return paginationLoading(_that.existingPosts,_that.hasMore);case FeedLoaded() when loaded != null:
return loaded(_that.posts,_that.next,_that.previous,_that.count,_that.hasMore);case FeedPaginationError() when paginationError != null:
return paginationError(_that.existingPosts,_that.message,_that.hasMore);case FeedError() when error != null:
return error(_that.message);case PostDetailLoading() when postDetailLoading != null:
return postDetailLoading();case PostDetailLoaded() when postDetailLoaded != null:
return postDetailLoaded(_that.post);case PostDetailError() when postDetailError != null:
return postDetailError(_that.message);case PostCreating() when postCreating != null:
return postCreating();case PostCreated() when postCreated != null:
return postCreated(_that.posts);case PostCreateError() when postCreateError != null:
return postCreateError(_that.message);case PostLikeError() when postLikeError != null:
return postLikeError(_that.post,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Post> existingPosts,  bool hasMore)  paginationLoading,required TResult Function( List<Post> posts,  String? next,  String? previous,  int count,  bool hasMore)  loaded,required TResult Function( List<Post> existingPosts,  String message,  bool hasMore)  paginationError,required TResult Function( String message)  error,required TResult Function()  postDetailLoading,required TResult Function( Post post)  postDetailLoaded,required TResult Function( String message)  postDetailError,required TResult Function()  postCreating,required TResult Function( List<Post> posts)  postCreated,required TResult Function( String message)  postCreateError,required TResult Function( Post post,  String message)  postLikeError,}) {final _that = this;
switch (_that) {
case FeedInitial():
return initial();case FeedLoading():
return loading();case FeedPaginationLoading():
return paginationLoading(_that.existingPosts,_that.hasMore);case FeedLoaded():
return loaded(_that.posts,_that.next,_that.previous,_that.count,_that.hasMore);case FeedPaginationError():
return paginationError(_that.existingPosts,_that.message,_that.hasMore);case FeedError():
return error(_that.message);case PostDetailLoading():
return postDetailLoading();case PostDetailLoaded():
return postDetailLoaded(_that.post);case PostDetailError():
return postDetailError(_that.message);case PostCreating():
return postCreating();case PostCreated():
return postCreated(_that.posts);case PostCreateError():
return postCreateError(_that.message);case PostLikeError():
return postLikeError(_that.post,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Post> existingPosts,  bool hasMore)?  paginationLoading,TResult? Function( List<Post> posts,  String? next,  String? previous,  int count,  bool hasMore)?  loaded,TResult? Function( List<Post> existingPosts,  String message,  bool hasMore)?  paginationError,TResult? Function( String message)?  error,TResult? Function()?  postDetailLoading,TResult? Function( Post post)?  postDetailLoaded,TResult? Function( String message)?  postDetailError,TResult? Function()?  postCreating,TResult? Function( List<Post> posts)?  postCreated,TResult? Function( String message)?  postCreateError,TResult? Function( Post post,  String message)?  postLikeError,}) {final _that = this;
switch (_that) {
case FeedInitial() when initial != null:
return initial();case FeedLoading() when loading != null:
return loading();case FeedPaginationLoading() when paginationLoading != null:
return paginationLoading(_that.existingPosts,_that.hasMore);case FeedLoaded() when loaded != null:
return loaded(_that.posts,_that.next,_that.previous,_that.count,_that.hasMore);case FeedPaginationError() when paginationError != null:
return paginationError(_that.existingPosts,_that.message,_that.hasMore);case FeedError() when error != null:
return error(_that.message);case PostDetailLoading() when postDetailLoading != null:
return postDetailLoading();case PostDetailLoaded() when postDetailLoaded != null:
return postDetailLoaded(_that.post);case PostDetailError() when postDetailError != null:
return postDetailError(_that.message);case PostCreating() when postCreating != null:
return postCreating();case PostCreated() when postCreated != null:
return postCreated(_that.posts);case PostCreateError() when postCreateError != null:
return postCreateError(_that.message);case PostLikeError() when postLikeError != null:
return postLikeError(_that.post,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class FeedInitial implements FeedState {
  const FeedInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState.initial()';
}


}




/// @nodoc


class FeedLoading implements FeedState {
  const FeedLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState.loading()';
}


}




/// @nodoc


class FeedPaginationLoading implements FeedState {
  const FeedPaginationLoading({required final  List<Post> existingPosts, required this.hasMore}): _existingPosts = existingPosts;
  

 final  List<Post> _existingPosts;
 List<Post> get existingPosts {
  if (_existingPosts is EqualUnmodifiableListView) return _existingPosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_existingPosts);
}

 final  bool hasMore;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedPaginationLoadingCopyWith<FeedPaginationLoading> get copyWith => _$FeedPaginationLoadingCopyWithImpl<FeedPaginationLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedPaginationLoading&&const DeepCollectionEquality().equals(other._existingPosts, _existingPosts)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_existingPosts),hasMore);

@override
String toString() {
  return 'FeedState.paginationLoading(existingPosts: $existingPosts, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $FeedPaginationLoadingCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $FeedPaginationLoadingCopyWith(FeedPaginationLoading value, $Res Function(FeedPaginationLoading) _then) = _$FeedPaginationLoadingCopyWithImpl;
@useResult
$Res call({
 List<Post> existingPosts, bool hasMore
});




}
/// @nodoc
class _$FeedPaginationLoadingCopyWithImpl<$Res>
    implements $FeedPaginationLoadingCopyWith<$Res> {
  _$FeedPaginationLoadingCopyWithImpl(this._self, this._then);

  final FeedPaginationLoading _self;
  final $Res Function(FeedPaginationLoading) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? existingPosts = null,Object? hasMore = null,}) {
  return _then(FeedPaginationLoading(
existingPosts: null == existingPosts ? _self._existingPosts : existingPosts // ignore: cast_nullable_to_non_nullable
as List<Post>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class FeedLoaded implements FeedState {
  const FeedLoaded({required final  List<Post> posts, this.next, this.previous, required this.count, this.hasMore = false}): _posts = posts;
  

 final  List<Post> _posts;
 List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

 final  String? next;
 final  String? previous;
 final  int count;
@JsonKey() final  bool hasMore;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedLoadedCopyWith<FeedLoaded> get copyWith => _$FeedLoadedCopyWithImpl<FeedLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedLoaded&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.count, count) || other.count == count)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts),next,previous,count,hasMore);

@override
String toString() {
  return 'FeedState.loaded(posts: $posts, next: $next, previous: $previous, count: $count, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $FeedLoadedCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $FeedLoadedCopyWith(FeedLoaded value, $Res Function(FeedLoaded) _then) = _$FeedLoadedCopyWithImpl;
@useResult
$Res call({
 List<Post> posts, String? next, String? previous, int count, bool hasMore
});




}
/// @nodoc
class _$FeedLoadedCopyWithImpl<$Res>
    implements $FeedLoadedCopyWith<$Res> {
  _$FeedLoadedCopyWithImpl(this._self, this._then);

  final FeedLoaded _self;
  final $Res Function(FeedLoaded) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? posts = null,Object? next = freezed,Object? previous = freezed,Object? count = null,Object? hasMore = null,}) {
  return _then(FeedLoaded(
posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class FeedPaginationError implements FeedState {
  const FeedPaginationError({required final  List<Post> existingPosts, required this.message, required this.hasMore}): _existingPosts = existingPosts;
  

 final  List<Post> _existingPosts;
 List<Post> get existingPosts {
  if (_existingPosts is EqualUnmodifiableListView) return _existingPosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_existingPosts);
}

 final  String message;
 final  bool hasMore;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedPaginationErrorCopyWith<FeedPaginationError> get copyWith => _$FeedPaginationErrorCopyWithImpl<FeedPaginationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedPaginationError&&const DeepCollectionEquality().equals(other._existingPosts, _existingPosts)&&(identical(other.message, message) || other.message == message)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_existingPosts),message,hasMore);

@override
String toString() {
  return 'FeedState.paginationError(existingPosts: $existingPosts, message: $message, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $FeedPaginationErrorCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $FeedPaginationErrorCopyWith(FeedPaginationError value, $Res Function(FeedPaginationError) _then) = _$FeedPaginationErrorCopyWithImpl;
@useResult
$Res call({
 List<Post> existingPosts, String message, bool hasMore
});




}
/// @nodoc
class _$FeedPaginationErrorCopyWithImpl<$Res>
    implements $FeedPaginationErrorCopyWith<$Res> {
  _$FeedPaginationErrorCopyWithImpl(this._self, this._then);

  final FeedPaginationError _self;
  final $Res Function(FeedPaginationError) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? existingPosts = null,Object? message = null,Object? hasMore = null,}) {
  return _then(FeedPaginationError(
existingPosts: null == existingPosts ? _self._existingPosts : existingPosts // ignore: cast_nullable_to_non_nullable
as List<Post>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class FeedError implements FeedState {
  const FeedError({required this.message});
  

 final  String message;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedErrorCopyWith<FeedError> get copyWith => _$FeedErrorCopyWithImpl<FeedError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FeedState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $FeedErrorCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $FeedErrorCopyWith(FeedError value, $Res Function(FeedError) _then) = _$FeedErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FeedErrorCopyWithImpl<$Res>
    implements $FeedErrorCopyWith<$Res> {
  _$FeedErrorCopyWithImpl(this._self, this._then);

  final FeedError _self;
  final $Res Function(FeedError) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FeedError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PostDetailLoading implements FeedState {
  const PostDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState.postDetailLoading()';
}


}




/// @nodoc


class PostDetailLoaded implements FeedState {
  const PostDetailLoaded({required this.post});
  

 final  Post post;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDetailLoadedCopyWith<PostDetailLoaded> get copyWith => _$PostDetailLoadedCopyWithImpl<PostDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDetailLoaded&&(identical(other.post, post) || other.post == post));
}


@override
int get hashCode => Object.hash(runtimeType,post);

@override
String toString() {
  return 'FeedState.postDetailLoaded(post: $post)';
}


}

/// @nodoc
abstract mixin class $PostDetailLoadedCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $PostDetailLoadedCopyWith(PostDetailLoaded value, $Res Function(PostDetailLoaded) _then) = _$PostDetailLoadedCopyWithImpl;
@useResult
$Res call({
 Post post
});


$PostCopyWith<$Res> get post;

}
/// @nodoc
class _$PostDetailLoadedCopyWithImpl<$Res>
    implements $PostDetailLoadedCopyWith<$Res> {
  _$PostDetailLoadedCopyWithImpl(this._self, this._then);

  final PostDetailLoaded _self;
  final $Res Function(PostDetailLoaded) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? post = null,}) {
  return _then(PostDetailLoaded(
post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post,
  ));
}

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res> get post {
  
  return $PostCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}

/// @nodoc


class PostDetailError implements FeedState {
  const PostDetailError({required this.message});
  

 final  String message;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDetailErrorCopyWith<PostDetailError> get copyWith => _$PostDetailErrorCopyWithImpl<PostDetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDetailError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FeedState.postDetailError(message: $message)';
}


}

/// @nodoc
abstract mixin class $PostDetailErrorCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $PostDetailErrorCopyWith(PostDetailError value, $Res Function(PostDetailError) _then) = _$PostDetailErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PostDetailErrorCopyWithImpl<$Res>
    implements $PostDetailErrorCopyWith<$Res> {
  _$PostDetailErrorCopyWithImpl(this._self, this._then);

  final PostDetailError _self;
  final $Res Function(PostDetailError) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PostDetailError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PostCreating implements FeedState {
  const PostCreating();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostCreating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState.postCreating()';
}


}




/// @nodoc


class PostCreated implements FeedState {
  const PostCreated({required final  List<Post> posts}): _posts = posts;
  

 final  List<Post> _posts;
 List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCreatedCopyWith<PostCreated> get copyWith => _$PostCreatedCopyWithImpl<PostCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostCreated&&const DeepCollectionEquality().equals(other._posts, _posts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts));

@override
String toString() {
  return 'FeedState.postCreated(posts: $posts)';
}


}

/// @nodoc
abstract mixin class $PostCreatedCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $PostCreatedCopyWith(PostCreated value, $Res Function(PostCreated) _then) = _$PostCreatedCopyWithImpl;
@useResult
$Res call({
 List<Post> posts
});




}
/// @nodoc
class _$PostCreatedCopyWithImpl<$Res>
    implements $PostCreatedCopyWith<$Res> {
  _$PostCreatedCopyWithImpl(this._self, this._then);

  final PostCreated _self;
  final $Res Function(PostCreated) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? posts = null,}) {
  return _then(PostCreated(
posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}


}

/// @nodoc


class PostCreateError implements FeedState {
  const PostCreateError(this.message);
  

 final  String message;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCreateErrorCopyWith<PostCreateError> get copyWith => _$PostCreateErrorCopyWithImpl<PostCreateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostCreateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FeedState.postCreateError(message: $message)';
}


}

/// @nodoc
abstract mixin class $PostCreateErrorCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $PostCreateErrorCopyWith(PostCreateError value, $Res Function(PostCreateError) _then) = _$PostCreateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PostCreateErrorCopyWithImpl<$Res>
    implements $PostCreateErrorCopyWith<$Res> {
  _$PostCreateErrorCopyWithImpl(this._self, this._then);

  final PostCreateError _self;
  final $Res Function(PostCreateError) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PostCreateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PostLikeError implements FeedState {
  const PostLikeError({required this.post, required this.message});
  

 final  Post post;
 final  String message;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostLikeErrorCopyWith<PostLikeError> get copyWith => _$PostLikeErrorCopyWithImpl<PostLikeError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostLikeError&&(identical(other.post, post) || other.post == post)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,post,message);

@override
String toString() {
  return 'FeedState.postLikeError(post: $post, message: $message)';
}


}

/// @nodoc
abstract mixin class $PostLikeErrorCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $PostLikeErrorCopyWith(PostLikeError value, $Res Function(PostLikeError) _then) = _$PostLikeErrorCopyWithImpl;
@useResult
$Res call({
 Post post, String message
});


$PostCopyWith<$Res> get post;

}
/// @nodoc
class _$PostLikeErrorCopyWithImpl<$Res>
    implements $PostLikeErrorCopyWith<$Res> {
  _$PostLikeErrorCopyWithImpl(this._self, this._then);

  final PostLikeError _self;
  final $Res Function(PostLikeError) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? post = null,Object? message = null,}) {
  return _then(PostLikeError(
post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res> get post {
  
  return $PostCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}

// dart format on
