// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_tag_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoTagState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoTagState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoTagState()';
}


}

/// @nodoc
class $TodoTagStateCopyWith<$Res>  {
$TodoTagStateCopyWith(TodoTagState _, $Res Function(TodoTagState) __);
}


/// Adds pattern-matching-related methods to [TodoTagState].
extension TodoTagStatePatterns on TodoTagState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _TodoTagInitial value)?  initial,TResult Function( _TodoTagLoading value)?  loading,TResult Function( TodoTagSuccess value)?  success,TResult Function( _TodoTagFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoTagInitial() when initial != null:
return initial(_that);case _TodoTagLoading() when loading != null:
return loading(_that);case TodoTagSuccess() when success != null:
return success(_that);case _TodoTagFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _TodoTagInitial value)  initial,required TResult Function( _TodoTagLoading value)  loading,required TResult Function( TodoTagSuccess value)  success,required TResult Function( _TodoTagFailure value)  failure,}){
final _that = this;
switch (_that) {
case _TodoTagInitial():
return initial(_that);case _TodoTagLoading():
return loading(_that);case TodoTagSuccess():
return success(_that);case _TodoTagFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _TodoTagInitial value)?  initial,TResult? Function( _TodoTagLoading value)?  loading,TResult? Function( TodoTagSuccess value)?  success,TResult? Function( _TodoTagFailure value)?  failure,}){
final _that = this;
switch (_that) {
case _TodoTagInitial() when initial != null:
return initial(_that);case _TodoTagLoading() when loading != null:
return loading(_that);case TodoTagSuccess() when success != null:
return success(_that);case _TodoTagFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<TodoTagEntity> tags)?  loading,TResult Function( List<TodoTagEntity> tags,  String? nextUrl,  bool isPaginating,  bool isSyncing)?  success,TResult Function( Failure failure,  List<TodoTagEntity> tags)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoTagInitial() when initial != null:
return initial();case _TodoTagLoading() when loading != null:
return loading(_that.tags);case TodoTagSuccess() when success != null:
return success(_that.tags,_that.nextUrl,_that.isPaginating,_that.isSyncing);case _TodoTagFailure() when failure != null:
return failure(_that.failure,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<TodoTagEntity> tags)  loading,required TResult Function( List<TodoTagEntity> tags,  String? nextUrl,  bool isPaginating,  bool isSyncing)  success,required TResult Function( Failure failure,  List<TodoTagEntity> tags)  failure,}) {final _that = this;
switch (_that) {
case _TodoTagInitial():
return initial();case _TodoTagLoading():
return loading(_that.tags);case TodoTagSuccess():
return success(_that.tags,_that.nextUrl,_that.isPaginating,_that.isSyncing);case _TodoTagFailure():
return failure(_that.failure,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<TodoTagEntity> tags)?  loading,TResult? Function( List<TodoTagEntity> tags,  String? nextUrl,  bool isPaginating,  bool isSyncing)?  success,TResult? Function( Failure failure,  List<TodoTagEntity> tags)?  failure,}) {final _that = this;
switch (_that) {
case _TodoTagInitial() when initial != null:
return initial();case _TodoTagLoading() when loading != null:
return loading(_that.tags);case TodoTagSuccess() when success != null:
return success(_that.tags,_that.nextUrl,_that.isPaginating,_that.isSyncing);case _TodoTagFailure() when failure != null:
return failure(_that.failure,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _TodoTagInitial implements TodoTagState {
  const _TodoTagInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoTagInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoTagState.initial()';
}


}




/// @nodoc


class _TodoTagLoading implements TodoTagState {
  const _TodoTagLoading({final  List<TodoTagEntity> tags = const []}): _tags = tags;
  

/// Tags retained from the previous success state so the UI
/// doesn't flash empty while reloading.
 final  List<TodoTagEntity> _tags;
/// Tags retained from the previous success state so the UI
/// doesn't flash empty while reloading.
@JsonKey() List<TodoTagEntity> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of TodoTagState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoTagLoadingCopyWith<_TodoTagLoading> get copyWith => __$TodoTagLoadingCopyWithImpl<_TodoTagLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoTagLoading&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'TodoTagState.loading(tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$TodoTagLoadingCopyWith<$Res> implements $TodoTagStateCopyWith<$Res> {
  factory _$TodoTagLoadingCopyWith(_TodoTagLoading value, $Res Function(_TodoTagLoading) _then) = __$TodoTagLoadingCopyWithImpl;
@useResult
$Res call({
 List<TodoTagEntity> tags
});




}
/// @nodoc
class __$TodoTagLoadingCopyWithImpl<$Res>
    implements _$TodoTagLoadingCopyWith<$Res> {
  __$TodoTagLoadingCopyWithImpl(this._self, this._then);

  final _TodoTagLoading _self;
  final $Res Function(_TodoTagLoading) _then;

/// Create a copy of TodoTagState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tags = null,}) {
  return _then(_TodoTagLoading(
tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<TodoTagEntity>,
  ));
}


}

/// @nodoc


class TodoTagSuccess implements TodoTagState {
  const TodoTagSuccess({required final  List<TodoTagEntity> tags, this.nextUrl, this.isPaginating = false, this.isSyncing = false}): _tags = tags;
  

 final  List<TodoTagEntity> _tags;
 List<TodoTagEntity> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  String? nextUrl;
@JsonKey() final  bool isPaginating;
@JsonKey() final  bool isSyncing;

/// Create a copy of TodoTagState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoTagSuccessCopyWith<TodoTagSuccess> get copyWith => _$TodoTagSuccessCopyWithImpl<TodoTagSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoTagSuccess&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.nextUrl, nextUrl) || other.nextUrl == nextUrl)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tags),nextUrl,isPaginating,isSyncing);

@override
String toString() {
  return 'TodoTagState.success(tags: $tags, nextUrl: $nextUrl, isPaginating: $isPaginating, isSyncing: $isSyncing)';
}


}

/// @nodoc
abstract mixin class $TodoTagSuccessCopyWith<$Res> implements $TodoTagStateCopyWith<$Res> {
  factory $TodoTagSuccessCopyWith(TodoTagSuccess value, $Res Function(TodoTagSuccess) _then) = _$TodoTagSuccessCopyWithImpl;
@useResult
$Res call({
 List<TodoTagEntity> tags, String? nextUrl, bool isPaginating, bool isSyncing
});




}
/// @nodoc
class _$TodoTagSuccessCopyWithImpl<$Res>
    implements $TodoTagSuccessCopyWith<$Res> {
  _$TodoTagSuccessCopyWithImpl(this._self, this._then);

  final TodoTagSuccess _self;
  final $Res Function(TodoTagSuccess) _then;

/// Create a copy of TodoTagState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tags = null,Object? nextUrl = freezed,Object? isPaginating = null,Object? isSyncing = null,}) {
  return _then(TodoTagSuccess(
tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<TodoTagEntity>,nextUrl: freezed == nextUrl ? _self.nextUrl : nextUrl // ignore: cast_nullable_to_non_nullable
as String?,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _TodoTagFailure implements TodoTagState {
  const _TodoTagFailure({required this.failure, final  List<TodoTagEntity> tags = const []}): _tags = tags;
  

 final  Failure failure;
/// Tags retained so the UI can still display stale data on error.
 final  List<TodoTagEntity> _tags;
/// Tags retained so the UI can still display stale data on error.
@JsonKey() List<TodoTagEntity> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of TodoTagState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoTagFailureCopyWith<_TodoTagFailure> get copyWith => __$TodoTagFailureCopyWithImpl<_TodoTagFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoTagFailure&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,failure,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'TodoTagState.failure(failure: $failure, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$TodoTagFailureCopyWith<$Res> implements $TodoTagStateCopyWith<$Res> {
  factory _$TodoTagFailureCopyWith(_TodoTagFailure value, $Res Function(_TodoTagFailure) _then) = __$TodoTagFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure, List<TodoTagEntity> tags
});




}
/// @nodoc
class __$TodoTagFailureCopyWithImpl<$Res>
    implements _$TodoTagFailureCopyWith<$Res> {
  __$TodoTagFailureCopyWithImpl(this._self, this._then);

  final _TodoTagFailure _self;
  final $Res Function(_TodoTagFailure) _then;

/// Create a copy of TodoTagState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? tags = null,}) {
  return _then(_TodoTagFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<TodoTagEntity>,
  ));
}


}

// dart format on
