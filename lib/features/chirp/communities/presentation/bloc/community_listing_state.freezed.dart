// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_listing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityListingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityListingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityListingState()';
}


}

/// @nodoc
class $CommunityListingStateCopyWith<$Res>  {
$CommunityListingStateCopyWith(CommunityListingState _, $Res Function(CommunityListingState) __);
}


/// Adds pattern-matching-related methods to [CommunityListingState].
extension CommunityListingStatePatterns on CommunityListingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CommunityListingInitialState value)?  initial,TResult Function( CommunityListingLoadingState value)?  loading,TResult Function( CommunityListingErrorState value)?  error,TResult Function( CommunityListingLoadedState value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CommunityListingInitialState() when initial != null:
return initial(_that);case CommunityListingLoadingState() when loading != null:
return loading(_that);case CommunityListingErrorState() when error != null:
return error(_that);case CommunityListingLoadedState() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CommunityListingInitialState value)  initial,required TResult Function( CommunityListingLoadingState value)  loading,required TResult Function( CommunityListingErrorState value)  error,required TResult Function( CommunityListingLoadedState value)  loaded,}){
final _that = this;
switch (_that) {
case CommunityListingInitialState():
return initial(_that);case CommunityListingLoadingState():
return loading(_that);case CommunityListingErrorState():
return error(_that);case CommunityListingLoadedState():
return loaded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CommunityListingInitialState value)?  initial,TResult? Function( CommunityListingLoadingState value)?  loading,TResult? Function( CommunityListingErrorState value)?  error,TResult? Function( CommunityListingLoadedState value)?  loaded,}){
final _that = this;
switch (_that) {
case CommunityListingInitialState() when initial != null:
return initial(_that);case CommunityListingLoadingState() when loading != null:
return loading(_that);case CommunityListingErrorState() when error != null:
return error(_that);case CommunityListingLoadedState() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( List<Community> communities,  bool hasReachedMax,  bool isLoadingMore,  String? searchTerm)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CommunityListingInitialState() when initial != null:
return initial();case CommunityListingLoadingState() when loading != null:
return loading();case CommunityListingErrorState() when error != null:
return error(_that.message);case CommunityListingLoadedState() when loaded != null:
return loaded(_that.communities,_that.hasReachedMax,_that.isLoadingMore,_that.searchTerm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( List<Community> communities,  bool hasReachedMax,  bool isLoadingMore,  String? searchTerm)  loaded,}) {final _that = this;
switch (_that) {
case CommunityListingInitialState():
return initial();case CommunityListingLoadingState():
return loading();case CommunityListingErrorState():
return error(_that.message);case CommunityListingLoadedState():
return loaded(_that.communities,_that.hasReachedMax,_that.isLoadingMore,_that.searchTerm);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( List<Community> communities,  bool hasReachedMax,  bool isLoadingMore,  String? searchTerm)?  loaded,}) {final _that = this;
switch (_that) {
case CommunityListingInitialState() when initial != null:
return initial();case CommunityListingLoadingState() when loading != null:
return loading();case CommunityListingErrorState() when error != null:
return error(_that.message);case CommunityListingLoadedState() when loaded != null:
return loaded(_that.communities,_that.hasReachedMax,_that.isLoadingMore,_that.searchTerm);case _:
  return null;

}
}

}

/// @nodoc


class CommunityListingInitialState implements CommunityListingState {
  const CommunityListingInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityListingInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityListingState.initial()';
}


}




/// @nodoc


class CommunityListingLoadingState implements CommunityListingState {
  const CommunityListingLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityListingLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityListingState.loading()';
}


}




/// @nodoc


class CommunityListingErrorState implements CommunityListingState {
  const CommunityListingErrorState({required this.message});
  

 final  String message;

/// Create a copy of CommunityListingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityListingErrorStateCopyWith<CommunityListingErrorState> get copyWith => _$CommunityListingErrorStateCopyWithImpl<CommunityListingErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityListingErrorState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CommunityListingState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CommunityListingErrorStateCopyWith<$Res> implements $CommunityListingStateCopyWith<$Res> {
  factory $CommunityListingErrorStateCopyWith(CommunityListingErrorState value, $Res Function(CommunityListingErrorState) _then) = _$CommunityListingErrorStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CommunityListingErrorStateCopyWithImpl<$Res>
    implements $CommunityListingErrorStateCopyWith<$Res> {
  _$CommunityListingErrorStateCopyWithImpl(this._self, this._then);

  final CommunityListingErrorState _self;
  final $Res Function(CommunityListingErrorState) _then;

/// Create a copy of CommunityListingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CommunityListingErrorState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CommunityListingLoadedState implements CommunityListingState {
  const CommunityListingLoadedState({required final  List<Community> communities, this.hasReachedMax = false, this.isLoadingMore = false, this.searchTerm}): _communities = communities;
  

 final  List<Community> _communities;
 List<Community> get communities {
  if (_communities is EqualUnmodifiableListView) return _communities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communities);
}

@JsonKey() final  bool hasReachedMax;
@JsonKey() final  bool isLoadingMore;
 final  String? searchTerm;

/// Create a copy of CommunityListingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityListingLoadedStateCopyWith<CommunityListingLoadedState> get copyWith => _$CommunityListingLoadedStateCopyWithImpl<CommunityListingLoadedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityListingLoadedState&&const DeepCollectionEquality().equals(other._communities, _communities)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_communities),hasReachedMax,isLoadingMore,searchTerm);

@override
String toString() {
  return 'CommunityListingState.loaded(communities: $communities, hasReachedMax: $hasReachedMax, isLoadingMore: $isLoadingMore, searchTerm: $searchTerm)';
}


}

/// @nodoc
abstract mixin class $CommunityListingLoadedStateCopyWith<$Res> implements $CommunityListingStateCopyWith<$Res> {
  factory $CommunityListingLoadedStateCopyWith(CommunityListingLoadedState value, $Res Function(CommunityListingLoadedState) _then) = _$CommunityListingLoadedStateCopyWithImpl;
@useResult
$Res call({
 List<Community> communities, bool hasReachedMax, bool isLoadingMore, String? searchTerm
});




}
/// @nodoc
class _$CommunityListingLoadedStateCopyWithImpl<$Res>
    implements $CommunityListingLoadedStateCopyWith<$Res> {
  _$CommunityListingLoadedStateCopyWithImpl(this._self, this._then);

  final CommunityListingLoadedState _self;
  final $Res Function(CommunityListingLoadedState) _then;

/// Create a copy of CommunityListingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communities = null,Object? hasReachedMax = null,Object? isLoadingMore = null,Object? searchTerm = freezed,}) {
  return _then(CommunityListingLoadedState(
communities: null == communities ? _self._communities : communities // ignore: cast_nullable_to_non_nullable
as List<Community>,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,searchTerm: freezed == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
