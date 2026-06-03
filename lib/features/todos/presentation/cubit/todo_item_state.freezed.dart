// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoItemState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoItemState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoItemState()';
}


}

/// @nodoc
class $TodoItemStateCopyWith<$Res>  {
$TodoItemStateCopyWith(TodoItemState _, $Res Function(TodoItemState) __);
}


/// Adds pattern-matching-related methods to [TodoItemState].
extension TodoItemStatePatterns on TodoItemState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _TodoItemInitial value)?  initial,TResult Function( _TodoItemLoading value)?  loading,TResult Function( TodoItemSuccess value)?  success,TResult Function( _TodoItemFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoItemInitial() when initial != null:
return initial(_that);case _TodoItemLoading() when loading != null:
return loading(_that);case TodoItemSuccess() when success != null:
return success(_that);case _TodoItemFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _TodoItemInitial value)  initial,required TResult Function( _TodoItemLoading value)  loading,required TResult Function( TodoItemSuccess value)  success,required TResult Function( _TodoItemFailure value)  failure,}){
final _that = this;
switch (_that) {
case _TodoItemInitial():
return initial(_that);case _TodoItemLoading():
return loading(_that);case TodoItemSuccess():
return success(_that);case _TodoItemFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _TodoItemInitial value)?  initial,TResult? Function( _TodoItemLoading value)?  loading,TResult? Function( TodoItemSuccess value)?  success,TResult? Function( _TodoItemFailure value)?  failure,}){
final _that = this;
switch (_that) {
case _TodoItemInitial() when initial != null:
return initial(_that);case _TodoItemLoading() when loading != null:
return loading(_that);case TodoItemSuccess() when success != null:
return success(_that);case _TodoItemFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<TodoItemEntity> items)?  loading,TResult Function( List<TodoItemEntity> items,  String? nextUrl,  bool isPaginating,  bool isSyncing)?  success,TResult Function( Failure failure,  List<TodoItemEntity> items)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoItemInitial() when initial != null:
return initial();case _TodoItemLoading() when loading != null:
return loading(_that.items);case TodoItemSuccess() when success != null:
return success(_that.items,_that.nextUrl,_that.isPaginating,_that.isSyncing);case _TodoItemFailure() when failure != null:
return failure(_that.failure,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<TodoItemEntity> items)  loading,required TResult Function( List<TodoItemEntity> items,  String? nextUrl,  bool isPaginating,  bool isSyncing)  success,required TResult Function( Failure failure,  List<TodoItemEntity> items)  failure,}) {final _that = this;
switch (_that) {
case _TodoItemInitial():
return initial();case _TodoItemLoading():
return loading(_that.items);case TodoItemSuccess():
return success(_that.items,_that.nextUrl,_that.isPaginating,_that.isSyncing);case _TodoItemFailure():
return failure(_that.failure,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<TodoItemEntity> items)?  loading,TResult? Function( List<TodoItemEntity> items,  String? nextUrl,  bool isPaginating,  bool isSyncing)?  success,TResult? Function( Failure failure,  List<TodoItemEntity> items)?  failure,}) {final _that = this;
switch (_that) {
case _TodoItemInitial() when initial != null:
return initial();case _TodoItemLoading() when loading != null:
return loading(_that.items);case TodoItemSuccess() when success != null:
return success(_that.items,_that.nextUrl,_that.isPaginating,_that.isSyncing);case _TodoItemFailure() when failure != null:
return failure(_that.failure,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _TodoItemInitial implements TodoItemState {
  const _TodoItemInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoItemInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoItemState.initial()';
}


}




/// @nodoc


class _TodoItemLoading implements TodoItemState {
  const _TodoItemLoading({final  List<TodoItemEntity> items = const []}): _items = items;
  

/// Items retained from the previous success state so the UI
/// doesn't flash empty while reloading.
 final  List<TodoItemEntity> _items;
/// Items retained from the previous success state so the UI
/// doesn't flash empty while reloading.
@JsonKey() List<TodoItemEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TodoItemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoItemLoadingCopyWith<_TodoItemLoading> get copyWith => __$TodoItemLoadingCopyWithImpl<_TodoItemLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoItemLoading&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'TodoItemState.loading(items: $items)';
}


}

/// @nodoc
abstract mixin class _$TodoItemLoadingCopyWith<$Res> implements $TodoItemStateCopyWith<$Res> {
  factory _$TodoItemLoadingCopyWith(_TodoItemLoading value, $Res Function(_TodoItemLoading) _then) = __$TodoItemLoadingCopyWithImpl;
@useResult
$Res call({
 List<TodoItemEntity> items
});




}
/// @nodoc
class __$TodoItemLoadingCopyWithImpl<$Res>
    implements _$TodoItemLoadingCopyWith<$Res> {
  __$TodoItemLoadingCopyWithImpl(this._self, this._then);

  final _TodoItemLoading _self;
  final $Res Function(_TodoItemLoading) _then;

/// Create a copy of TodoItemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_TodoItemLoading(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TodoItemEntity>,
  ));
}


}

/// @nodoc


class TodoItemSuccess implements TodoItemState {
  const TodoItemSuccess({required final  List<TodoItemEntity> items, this.nextUrl, this.isPaginating = false, this.isSyncing = false}): _items = items;
  

 final  List<TodoItemEntity> _items;
 List<TodoItemEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  String? nextUrl;
@JsonKey() final  bool isPaginating;
@JsonKey() final  bool isSyncing;

/// Create a copy of TodoItemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoItemSuccessCopyWith<TodoItemSuccess> get copyWith => _$TodoItemSuccessCopyWithImpl<TodoItemSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoItemSuccess&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextUrl, nextUrl) || other.nextUrl == nextUrl)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextUrl,isPaginating,isSyncing);

@override
String toString() {
  return 'TodoItemState.success(items: $items, nextUrl: $nextUrl, isPaginating: $isPaginating, isSyncing: $isSyncing)';
}


}

/// @nodoc
abstract mixin class $TodoItemSuccessCopyWith<$Res> implements $TodoItemStateCopyWith<$Res> {
  factory $TodoItemSuccessCopyWith(TodoItemSuccess value, $Res Function(TodoItemSuccess) _then) = _$TodoItemSuccessCopyWithImpl;
@useResult
$Res call({
 List<TodoItemEntity> items, String? nextUrl, bool isPaginating, bool isSyncing
});




}
/// @nodoc
class _$TodoItemSuccessCopyWithImpl<$Res>
    implements $TodoItemSuccessCopyWith<$Res> {
  _$TodoItemSuccessCopyWithImpl(this._self, this._then);

  final TodoItemSuccess _self;
  final $Res Function(TodoItemSuccess) _then;

/// Create a copy of TodoItemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextUrl = freezed,Object? isPaginating = null,Object? isSyncing = null,}) {
  return _then(TodoItemSuccess(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TodoItemEntity>,nextUrl: freezed == nextUrl ? _self.nextUrl : nextUrl // ignore: cast_nullable_to_non_nullable
as String?,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _TodoItemFailure implements TodoItemState {
  const _TodoItemFailure({required this.failure, final  List<TodoItemEntity> items = const []}): _items = items;
  

 final  Failure failure;
/// Items retained so the UI can still display stale data on error.
 final  List<TodoItemEntity> _items;
/// Items retained so the UI can still display stale data on error.
@JsonKey() List<TodoItemEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TodoItemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoItemFailureCopyWith<_TodoItemFailure> get copyWith => __$TodoItemFailureCopyWithImpl<_TodoItemFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoItemFailure&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,failure,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'TodoItemState.failure(failure: $failure, items: $items)';
}


}

/// @nodoc
abstract mixin class _$TodoItemFailureCopyWith<$Res> implements $TodoItemStateCopyWith<$Res> {
  factory _$TodoItemFailureCopyWith(_TodoItemFailure value, $Res Function(_TodoItemFailure) _then) = __$TodoItemFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure, List<TodoItemEntity> items
});




}
/// @nodoc
class __$TodoItemFailureCopyWithImpl<$Res>
    implements _$TodoItemFailureCopyWith<$Res> {
  __$TodoItemFailureCopyWithImpl(this._self, this._then);

  final _TodoItemFailure _self;
  final $Res Function(_TodoItemFailure) _then;

/// Create a copy of TodoItemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? items = null,}) {
  return _then(_TodoItemFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TodoItemEntity>,
  ));
}


}

// dart format on
