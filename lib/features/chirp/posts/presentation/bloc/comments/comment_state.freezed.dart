// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommentState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommentState()';
}


}

/// @nodoc
class $CommentStateCopyWith<$Res>  {
$CommentStateCopyWith(CommentState _, $Res Function(CommentState) __);
}


/// Adds pattern-matching-related methods to [CommentState].
extension CommentStatePatterns on CommentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CommentInitial value)?  initial,TResult Function( CommentAdding value)?  adding,TResult Function( CommentAdded value)?  added,TResult Function( CommentAddError value)?  addError,TResult Function( CommentsLoading value)?  commentsLoading,TResult Function( CommentsPaginationLoading value)?  commentsPaginationLoading,TResult Function( CommentsLoaded value)?  commentsLoaded,TResult Function( CommentsPaginationError value)?  commentsPaginationError,TResult Function( CommentsError value)?  commentsError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CommentInitial() when initial != null:
return initial(_that);case CommentAdding() when adding != null:
return adding(_that);case CommentAdded() when added != null:
return added(_that);case CommentAddError() when addError != null:
return addError(_that);case CommentsLoading() when commentsLoading != null:
return commentsLoading(_that);case CommentsPaginationLoading() when commentsPaginationLoading != null:
return commentsPaginationLoading(_that);case CommentsLoaded() when commentsLoaded != null:
return commentsLoaded(_that);case CommentsPaginationError() when commentsPaginationError != null:
return commentsPaginationError(_that);case CommentsError() when commentsError != null:
return commentsError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CommentInitial value)  initial,required TResult Function( CommentAdding value)  adding,required TResult Function( CommentAdded value)  added,required TResult Function( CommentAddError value)  addError,required TResult Function( CommentsLoading value)  commentsLoading,required TResult Function( CommentsPaginationLoading value)  commentsPaginationLoading,required TResult Function( CommentsLoaded value)  commentsLoaded,required TResult Function( CommentsPaginationError value)  commentsPaginationError,required TResult Function( CommentsError value)  commentsError,}){
final _that = this;
switch (_that) {
case CommentInitial():
return initial(_that);case CommentAdding():
return adding(_that);case CommentAdded():
return added(_that);case CommentAddError():
return addError(_that);case CommentsLoading():
return commentsLoading(_that);case CommentsPaginationLoading():
return commentsPaginationLoading(_that);case CommentsLoaded():
return commentsLoaded(_that);case CommentsPaginationError():
return commentsPaginationError(_that);case CommentsError():
return commentsError(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CommentInitial value)?  initial,TResult? Function( CommentAdding value)?  adding,TResult? Function( CommentAdded value)?  added,TResult? Function( CommentAddError value)?  addError,TResult? Function( CommentsLoading value)?  commentsLoading,TResult? Function( CommentsPaginationLoading value)?  commentsPaginationLoading,TResult? Function( CommentsLoaded value)?  commentsLoaded,TResult? Function( CommentsPaginationError value)?  commentsPaginationError,TResult? Function( CommentsError value)?  commentsError,}){
final _that = this;
switch (_that) {
case CommentInitial() when initial != null:
return initial(_that);case CommentAdding() when adding != null:
return adding(_that);case CommentAdded() when added != null:
return added(_that);case CommentAddError() when addError != null:
return addError(_that);case CommentsLoading() when commentsLoading != null:
return commentsLoading(_that);case CommentsPaginationLoading() when commentsPaginationLoading != null:
return commentsPaginationLoading(_that);case CommentsLoaded() when commentsLoaded != null:
return commentsLoaded(_that);case CommentsPaginationError() when commentsPaginationError != null:
return commentsPaginationError(_that);case CommentsError() when commentsError != null:
return commentsError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  adding,TResult Function( Comment comment)?  added,TResult Function( String message)?  addError,TResult Function()?  commentsLoading,TResult Function( List<Comment> existingComments,  bool hasMore)?  commentsPaginationLoading,TResult Function( List<Comment> comments,  String? next,  String? previous,  int count,  bool hasMore)?  commentsLoaded,TResult Function( List<Comment> existingComments,  String message,  bool hasMore)?  commentsPaginationError,TResult Function( String message)?  commentsError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CommentInitial() when initial != null:
return initial();case CommentAdding() when adding != null:
return adding();case CommentAdded() when added != null:
return added(_that.comment);case CommentAddError() when addError != null:
return addError(_that.message);case CommentsLoading() when commentsLoading != null:
return commentsLoading();case CommentsPaginationLoading() when commentsPaginationLoading != null:
return commentsPaginationLoading(_that.existingComments,_that.hasMore);case CommentsLoaded() when commentsLoaded != null:
return commentsLoaded(_that.comments,_that.next,_that.previous,_that.count,_that.hasMore);case CommentsPaginationError() when commentsPaginationError != null:
return commentsPaginationError(_that.existingComments,_that.message,_that.hasMore);case CommentsError() when commentsError != null:
return commentsError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  adding,required TResult Function( Comment comment)  added,required TResult Function( String message)  addError,required TResult Function()  commentsLoading,required TResult Function( List<Comment> existingComments,  bool hasMore)  commentsPaginationLoading,required TResult Function( List<Comment> comments,  String? next,  String? previous,  int count,  bool hasMore)  commentsLoaded,required TResult Function( List<Comment> existingComments,  String message,  bool hasMore)  commentsPaginationError,required TResult Function( String message)  commentsError,}) {final _that = this;
switch (_that) {
case CommentInitial():
return initial();case CommentAdding():
return adding();case CommentAdded():
return added(_that.comment);case CommentAddError():
return addError(_that.message);case CommentsLoading():
return commentsLoading();case CommentsPaginationLoading():
return commentsPaginationLoading(_that.existingComments,_that.hasMore);case CommentsLoaded():
return commentsLoaded(_that.comments,_that.next,_that.previous,_that.count,_that.hasMore);case CommentsPaginationError():
return commentsPaginationError(_that.existingComments,_that.message,_that.hasMore);case CommentsError():
return commentsError(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  adding,TResult? Function( Comment comment)?  added,TResult? Function( String message)?  addError,TResult? Function()?  commentsLoading,TResult? Function( List<Comment> existingComments,  bool hasMore)?  commentsPaginationLoading,TResult? Function( List<Comment> comments,  String? next,  String? previous,  int count,  bool hasMore)?  commentsLoaded,TResult? Function( List<Comment> existingComments,  String message,  bool hasMore)?  commentsPaginationError,TResult? Function( String message)?  commentsError,}) {final _that = this;
switch (_that) {
case CommentInitial() when initial != null:
return initial();case CommentAdding() when adding != null:
return adding();case CommentAdded() when added != null:
return added(_that.comment);case CommentAddError() when addError != null:
return addError(_that.message);case CommentsLoading() when commentsLoading != null:
return commentsLoading();case CommentsPaginationLoading() when commentsPaginationLoading != null:
return commentsPaginationLoading(_that.existingComments,_that.hasMore);case CommentsLoaded() when commentsLoaded != null:
return commentsLoaded(_that.comments,_that.next,_that.previous,_that.count,_that.hasMore);case CommentsPaginationError() when commentsPaginationError != null:
return commentsPaginationError(_that.existingComments,_that.message,_that.hasMore);case CommentsError() when commentsError != null:
return commentsError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CommentInitial implements CommentState {
  const CommentInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommentState.initial()';
}


}




/// @nodoc


class CommentAdding implements CommentState {
  const CommentAdding();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentAdding);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommentState.adding()';
}


}




/// @nodoc


class CommentAdded implements CommentState {
  const CommentAdded({required this.comment});
  

 final  Comment comment;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentAddedCopyWith<CommentAdded> get copyWith => _$CommentAddedCopyWithImpl<CommentAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentAdded&&(identical(other.comment, comment) || other.comment == comment));
}


@override
int get hashCode => Object.hash(runtimeType,comment);

@override
String toString() {
  return 'CommentState.added(comment: $comment)';
}


}

/// @nodoc
abstract mixin class $CommentAddedCopyWith<$Res> implements $CommentStateCopyWith<$Res> {
  factory $CommentAddedCopyWith(CommentAdded value, $Res Function(CommentAdded) _then) = _$CommentAddedCopyWithImpl;
@useResult
$Res call({
 Comment comment
});


$CommentCopyWith<$Res> get comment;

}
/// @nodoc
class _$CommentAddedCopyWithImpl<$Res>
    implements $CommentAddedCopyWith<$Res> {
  _$CommentAddedCopyWithImpl(this._self, this._then);

  final CommentAdded _self;
  final $Res Function(CommentAdded) _then;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? comment = null,}) {
  return _then(CommentAdded(
comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as Comment,
  ));
}

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentCopyWith<$Res> get comment {
  
  return $CommentCopyWith<$Res>(_self.comment, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}

/// @nodoc


class CommentAddError implements CommentState {
  const CommentAddError(this.message);
  

 final  String message;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentAddErrorCopyWith<CommentAddError> get copyWith => _$CommentAddErrorCopyWithImpl<CommentAddError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentAddError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CommentState.addError(message: $message)';
}


}

/// @nodoc
abstract mixin class $CommentAddErrorCopyWith<$Res> implements $CommentStateCopyWith<$Res> {
  factory $CommentAddErrorCopyWith(CommentAddError value, $Res Function(CommentAddError) _then) = _$CommentAddErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CommentAddErrorCopyWithImpl<$Res>
    implements $CommentAddErrorCopyWith<$Res> {
  _$CommentAddErrorCopyWithImpl(this._self, this._then);

  final CommentAddError _self;
  final $Res Function(CommentAddError) _then;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CommentAddError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CommentsLoading implements CommentState {
  const CommentsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommentState.commentsLoading()';
}


}




/// @nodoc


class CommentsPaginationLoading implements CommentState {
  const CommentsPaginationLoading({required final  List<Comment> existingComments, required this.hasMore}): _existingComments = existingComments;
  

 final  List<Comment> _existingComments;
 List<Comment> get existingComments {
  if (_existingComments is EqualUnmodifiableListView) return _existingComments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_existingComments);
}

 final  bool hasMore;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentsPaginationLoadingCopyWith<CommentsPaginationLoading> get copyWith => _$CommentsPaginationLoadingCopyWithImpl<CommentsPaginationLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentsPaginationLoading&&const DeepCollectionEquality().equals(other._existingComments, _existingComments)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_existingComments),hasMore);

@override
String toString() {
  return 'CommentState.commentsPaginationLoading(existingComments: $existingComments, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $CommentsPaginationLoadingCopyWith<$Res> implements $CommentStateCopyWith<$Res> {
  factory $CommentsPaginationLoadingCopyWith(CommentsPaginationLoading value, $Res Function(CommentsPaginationLoading) _then) = _$CommentsPaginationLoadingCopyWithImpl;
@useResult
$Res call({
 List<Comment> existingComments, bool hasMore
});




}
/// @nodoc
class _$CommentsPaginationLoadingCopyWithImpl<$Res>
    implements $CommentsPaginationLoadingCopyWith<$Res> {
  _$CommentsPaginationLoadingCopyWithImpl(this._self, this._then);

  final CommentsPaginationLoading _self;
  final $Res Function(CommentsPaginationLoading) _then;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? existingComments = null,Object? hasMore = null,}) {
  return _then(CommentsPaginationLoading(
existingComments: null == existingComments ? _self._existingComments : existingComments // ignore: cast_nullable_to_non_nullable
as List<Comment>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CommentsLoaded implements CommentState {
  const CommentsLoaded({required final  List<Comment> comments, this.next, this.previous, required this.count, this.hasMore = false}): _comments = comments;
  

 final  List<Comment> _comments;
 List<Comment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

 final  String? next;
 final  String? previous;
 final  int count;
@JsonKey() final  bool hasMore;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentsLoadedCopyWith<CommentsLoaded> get copyWith => _$CommentsLoadedCopyWithImpl<CommentsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentsLoaded&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.count, count) || other.count == count)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_comments),next,previous,count,hasMore);

@override
String toString() {
  return 'CommentState.commentsLoaded(comments: $comments, next: $next, previous: $previous, count: $count, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $CommentsLoadedCopyWith<$Res> implements $CommentStateCopyWith<$Res> {
  factory $CommentsLoadedCopyWith(CommentsLoaded value, $Res Function(CommentsLoaded) _then) = _$CommentsLoadedCopyWithImpl;
@useResult
$Res call({
 List<Comment> comments, String? next, String? previous, int count, bool hasMore
});




}
/// @nodoc
class _$CommentsLoadedCopyWithImpl<$Res>
    implements $CommentsLoadedCopyWith<$Res> {
  _$CommentsLoadedCopyWithImpl(this._self, this._then);

  final CommentsLoaded _self;
  final $Res Function(CommentsLoaded) _then;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? comments = null,Object? next = freezed,Object? previous = freezed,Object? count = null,Object? hasMore = null,}) {
  return _then(CommentsLoaded(
comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<Comment>,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CommentsPaginationError implements CommentState {
  const CommentsPaginationError({required final  List<Comment> existingComments, required this.message, required this.hasMore}): _existingComments = existingComments;
  

 final  List<Comment> _existingComments;
 List<Comment> get existingComments {
  if (_existingComments is EqualUnmodifiableListView) return _existingComments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_existingComments);
}

 final  String message;
 final  bool hasMore;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentsPaginationErrorCopyWith<CommentsPaginationError> get copyWith => _$CommentsPaginationErrorCopyWithImpl<CommentsPaginationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentsPaginationError&&const DeepCollectionEquality().equals(other._existingComments, _existingComments)&&(identical(other.message, message) || other.message == message)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_existingComments),message,hasMore);

@override
String toString() {
  return 'CommentState.commentsPaginationError(existingComments: $existingComments, message: $message, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $CommentsPaginationErrorCopyWith<$Res> implements $CommentStateCopyWith<$Res> {
  factory $CommentsPaginationErrorCopyWith(CommentsPaginationError value, $Res Function(CommentsPaginationError) _then) = _$CommentsPaginationErrorCopyWithImpl;
@useResult
$Res call({
 List<Comment> existingComments, String message, bool hasMore
});




}
/// @nodoc
class _$CommentsPaginationErrorCopyWithImpl<$Res>
    implements $CommentsPaginationErrorCopyWith<$Res> {
  _$CommentsPaginationErrorCopyWithImpl(this._self, this._then);

  final CommentsPaginationError _self;
  final $Res Function(CommentsPaginationError) _then;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? existingComments = null,Object? message = null,Object? hasMore = null,}) {
  return _then(CommentsPaginationError(
existingComments: null == existingComments ? _self._existingComments : existingComments // ignore: cast_nullable_to_non_nullable
as List<Comment>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CommentsError implements CommentState {
  const CommentsError({required this.message});
  

 final  String message;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentsErrorCopyWith<CommentsError> get copyWith => _$CommentsErrorCopyWithImpl<CommentsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CommentState.commentsError(message: $message)';
}


}

/// @nodoc
abstract mixin class $CommentsErrorCopyWith<$Res> implements $CommentStateCopyWith<$Res> {
  factory $CommentsErrorCopyWith(CommentsError value, $Res Function(CommentsError) _then) = _$CommentsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CommentsErrorCopyWithImpl<$Res>
    implements $CommentsErrorCopyWith<$Res> {
  _$CommentsErrorCopyWithImpl(this._self, this._then);

  final CommentsError _self;
  final $Res Function(CommentsError) _then;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CommentsError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
