// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoListState()';
}


}

/// @nodoc
class $TodoListStateCopyWith<$Res>  {
$TodoListStateCopyWith(TodoListState _, $Res Function(TodoListState) __);
}


/// Adds pattern-matching-related methods to [TodoListState].
extension TodoListStatePatterns on TodoListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( TodoListSuccess value)?  success,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case TodoListSuccess() when success != null:
return success(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( TodoListSuccess value)  success,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case TodoListSuccess():
return success(_that);case _Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( TodoListSuccess value)?  success,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case TodoListSuccess() when success != null:
return success(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<TodoListEntity> todoLists,  String? nextUrl,  bool isPaginating,  bool isSyncing)?  success,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case TodoListSuccess() when success != null:
return success(_that.todoLists,_that.nextUrl,_that.isPaginating,_that.isSyncing);case _Failure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<TodoListEntity> todoLists,  String? nextUrl,  bool isPaginating,  bool isSyncing)  success,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case TodoListSuccess():
return success(_that.todoLists,_that.nextUrl,_that.isPaginating,_that.isSyncing);case _Failure():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<TodoListEntity> todoLists,  String? nextUrl,  bool isPaginating,  bool isSyncing)?  success,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case TodoListSuccess() when success != null:
return success(_that.todoLists,_that.nextUrl,_that.isPaginating,_that.isSyncing);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements TodoListState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoListState.initial()';
}


}




/// @nodoc


class _Loading implements TodoListState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoListState.loading()';
}


}




/// @nodoc


class TodoListSuccess implements TodoListState {
  const TodoListSuccess({required final  List<TodoListEntity> todoLists, this.nextUrl, this.isPaginating = false, this.isSyncing = false}): _todoLists = todoLists;
  

 final  List<TodoListEntity> _todoLists;
 List<TodoListEntity> get todoLists {
  if (_todoLists is EqualUnmodifiableListView) return _todoLists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todoLists);
}

 final  String? nextUrl;
@JsonKey() final  bool isPaginating;
@JsonKey() final  bool isSyncing;

/// Create a copy of TodoListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoListSuccessCopyWith<TodoListSuccess> get copyWith => _$TodoListSuccessCopyWithImpl<TodoListSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoListSuccess&&const DeepCollectionEquality().equals(other._todoLists, _todoLists)&&(identical(other.nextUrl, nextUrl) || other.nextUrl == nextUrl)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_todoLists),nextUrl,isPaginating,isSyncing);

@override
String toString() {
  return 'TodoListState.success(todoLists: $todoLists, nextUrl: $nextUrl, isPaginating: $isPaginating, isSyncing: $isSyncing)';
}


}

/// @nodoc
abstract mixin class $TodoListSuccessCopyWith<$Res> implements $TodoListStateCopyWith<$Res> {
  factory $TodoListSuccessCopyWith(TodoListSuccess value, $Res Function(TodoListSuccess) _then) = _$TodoListSuccessCopyWithImpl;
@useResult
$Res call({
 List<TodoListEntity> todoLists, String? nextUrl, bool isPaginating, bool isSyncing
});




}
/// @nodoc
class _$TodoListSuccessCopyWithImpl<$Res>
    implements $TodoListSuccessCopyWith<$Res> {
  _$TodoListSuccessCopyWithImpl(this._self, this._then);

  final TodoListSuccess _self;
  final $Res Function(TodoListSuccess) _then;

/// Create a copy of TodoListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? todoLists = null,Object? nextUrl = freezed,Object? isPaginating = null,Object? isSyncing = null,}) {
  return _then(TodoListSuccess(
todoLists: null == todoLists ? _self._todoLists : todoLists // ignore: cast_nullable_to_non_nullable
as List<TodoListEntity>,nextUrl: freezed == nextUrl ? _self.nextUrl : nextUrl // ignore: cast_nullable_to_non_nullable
as String?,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Failure implements TodoListState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of TodoListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'TodoListState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $TodoListStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of TodoListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
