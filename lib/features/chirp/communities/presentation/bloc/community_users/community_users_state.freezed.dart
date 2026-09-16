// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_users_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityUsersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUsersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityUsersState()';
}


}

/// @nodoc
class $CommunityUsersStateCopyWith<$Res>  {
$CommunityUsersStateCopyWith(CommunityUsersState _, $Res Function(CommunityUsersState) __);
}


/// Adds pattern-matching-related methods to [CommunityUsersState].
extension CommunityUsersStatePatterns on CommunityUsersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CommunityUsersInitial value)?  initial,TResult Function( CommunityUsersLoading value)?  loading,TResult Function( CommunityUsersLoaded value)?  loaded,TResult Function( CommunityUsersFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CommunityUsersInitial() when initial != null:
return initial(_that);case CommunityUsersLoading() when loading != null:
return loading(_that);case CommunityUsersLoaded() when loaded != null:
return loaded(_that);case CommunityUsersFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CommunityUsersInitial value)  initial,required TResult Function( CommunityUsersLoading value)  loading,required TResult Function( CommunityUsersLoaded value)  loaded,required TResult Function( CommunityUsersFailure value)  failure,}){
final _that = this;
switch (_that) {
case CommunityUsersInitial():
return initial(_that);case CommunityUsersLoading():
return loading(_that);case CommunityUsersLoaded():
return loaded(_that);case CommunityUsersFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CommunityUsersInitial value)?  initial,TResult? Function( CommunityUsersLoading value)?  loading,TResult? Function( CommunityUsersLoaded value)?  loaded,TResult? Function( CommunityUsersFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CommunityUsersInitial() when initial != null:
return initial(_that);case CommunityUsersLoading() when loading != null:
return loading(_that);case CommunityUsersLoaded() when loaded != null:
return loaded(_that);case CommunityUsersFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( PaginatedResponse paginatedResponse)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CommunityUsersInitial() when initial != null:
return initial();case CommunityUsersLoading() when loading != null:
return loading();case CommunityUsersLoaded() when loaded != null:
return loaded(_that.paginatedResponse);case CommunityUsersFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( PaginatedResponse paginatedResponse)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CommunityUsersInitial():
return initial();case CommunityUsersLoading():
return loading();case CommunityUsersLoaded():
return loaded(_that.paginatedResponse);case CommunityUsersFailure():
return failure(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( PaginatedResponse paginatedResponse)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CommunityUsersInitial() when initial != null:
return initial();case CommunityUsersLoading() when loading != null:
return loading();case CommunityUsersLoaded() when loaded != null:
return loaded(_that.paginatedResponse);case CommunityUsersFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CommunityUsersInitial implements CommunityUsersState {
  const CommunityUsersInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUsersInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityUsersState.initial()';
}


}




/// @nodoc


class CommunityUsersLoading implements CommunityUsersState {
  const CommunityUsersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUsersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityUsersState.loading()';
}


}




/// @nodoc


class CommunityUsersLoaded implements CommunityUsersState {
  const CommunityUsersLoaded(this.paginatedResponse);
  

 final  PaginatedResponse paginatedResponse;

/// Create a copy of CommunityUsersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityUsersLoadedCopyWith<CommunityUsersLoaded> get copyWith => _$CommunityUsersLoadedCopyWithImpl<CommunityUsersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUsersLoaded&&(identical(other.paginatedResponse, paginatedResponse) || other.paginatedResponse == paginatedResponse));
}


@override
int get hashCode => Object.hash(runtimeType,paginatedResponse);

@override
String toString() {
  return 'CommunityUsersState.loaded(paginatedResponse: $paginatedResponse)';
}


}

/// @nodoc
abstract mixin class $CommunityUsersLoadedCopyWith<$Res> implements $CommunityUsersStateCopyWith<$Res> {
  factory $CommunityUsersLoadedCopyWith(CommunityUsersLoaded value, $Res Function(CommunityUsersLoaded) _then) = _$CommunityUsersLoadedCopyWithImpl;
@useResult
$Res call({
 PaginatedResponse paginatedResponse
});


$PaginatedResponseCopyWith<$Res> get paginatedResponse;

}
/// @nodoc
class _$CommunityUsersLoadedCopyWithImpl<$Res>
    implements $CommunityUsersLoadedCopyWith<$Res> {
  _$CommunityUsersLoadedCopyWithImpl(this._self, this._then);

  final CommunityUsersLoaded _self;
  final $Res Function(CommunityUsersLoaded) _then;

/// Create a copy of CommunityUsersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paginatedResponse = null,}) {
  return _then(CommunityUsersLoaded(
null == paginatedResponse ? _self.paginatedResponse : paginatedResponse // ignore: cast_nullable_to_non_nullable
as PaginatedResponse,
  ));
}

/// Create a copy of CommunityUsersState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginatedResponseCopyWith<$Res> get paginatedResponse {
  
  return $PaginatedResponseCopyWith<$Res>(_self.paginatedResponse, (value) {
    return _then(_self.copyWith(paginatedResponse: value));
  });
}
}

/// @nodoc


class CommunityUsersFailure implements CommunityUsersState {
  const CommunityUsersFailure(this.message);
  

 final  String message;

/// Create a copy of CommunityUsersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityUsersFailureCopyWith<CommunityUsersFailure> get copyWith => _$CommunityUsersFailureCopyWithImpl<CommunityUsersFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUsersFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CommunityUsersState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CommunityUsersFailureCopyWith<$Res> implements $CommunityUsersStateCopyWith<$Res> {
  factory $CommunityUsersFailureCopyWith(CommunityUsersFailure value, $Res Function(CommunityUsersFailure) _then) = _$CommunityUsersFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CommunityUsersFailureCopyWithImpl<$Res>
    implements $CommunityUsersFailureCopyWith<$Res> {
  _$CommunityUsersFailureCopyWithImpl(this._self, this._then);

  final CommunityUsersFailure _self;
  final $Res Function(CommunityUsersFailure) _then;

/// Create a copy of CommunityUsersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CommunityUsersFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
