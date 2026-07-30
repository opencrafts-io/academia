// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chirp_community_membership_listing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChirpCommunityMembershipListingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipListingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChirpCommunityMembershipListingState()';
}


}

/// @nodoc
class $ChirpCommunityMembershipListingStateCopyWith<$Res>  {
$ChirpCommunityMembershipListingStateCopyWith(ChirpCommunityMembershipListingState _, $Res Function(ChirpCommunityMembershipListingState) __);
}


/// Adds pattern-matching-related methods to [ChirpCommunityMembershipListingState].
extension ChirpCommunityMembershipListingStatePatterns on ChirpCommunityMembershipListingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChirpCommunityMembershipListingInitialState value)?  initial,TResult Function( ChirpCommunityMembershipListingLoadingState value)?  loading,TResult Function( ChirpCommunityMembershipListingErrorState value)?  error,TResult Function( ChirpCommunityMembershipListingLoadedState value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChirpCommunityMembershipListingInitialState() when initial != null:
return initial(_that);case ChirpCommunityMembershipListingLoadingState() when loading != null:
return loading(_that);case ChirpCommunityMembershipListingErrorState() when error != null:
return error(_that);case ChirpCommunityMembershipListingLoadedState() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChirpCommunityMembershipListingInitialState value)  initial,required TResult Function( ChirpCommunityMembershipListingLoadingState value)  loading,required TResult Function( ChirpCommunityMembershipListingErrorState value)  error,required TResult Function( ChirpCommunityMembershipListingLoadedState value)  loaded,}){
final _that = this;
switch (_that) {
case ChirpCommunityMembershipListingInitialState():
return initial(_that);case ChirpCommunityMembershipListingLoadingState():
return loading(_that);case ChirpCommunityMembershipListingErrorState():
return error(_that);case ChirpCommunityMembershipListingLoadedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChirpCommunityMembershipListingInitialState value)?  initial,TResult? Function( ChirpCommunityMembershipListingLoadingState value)?  loading,TResult? Function( ChirpCommunityMembershipListingErrorState value)?  error,TResult? Function( ChirpCommunityMembershipListingLoadedState value)?  loaded,}){
final _that = this;
switch (_that) {
case ChirpCommunityMembershipListingInitialState() when initial != null:
return initial(_that);case ChirpCommunityMembershipListingLoadingState() when loading != null:
return loading(_that);case ChirpCommunityMembershipListingErrorState() when error != null:
return error(_that);case ChirpCommunityMembershipListingLoadedState() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String error)?  error,TResult Function( List<ChirpCommunityMembership> memberships,  bool isLoading,  bool hasReachedMax)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChirpCommunityMembershipListingInitialState() when initial != null:
return initial();case ChirpCommunityMembershipListingLoadingState() when loading != null:
return loading();case ChirpCommunityMembershipListingErrorState() when error != null:
return error(_that.error);case ChirpCommunityMembershipListingLoadedState() when loaded != null:
return loaded(_that.memberships,_that.isLoading,_that.hasReachedMax);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String error)  error,required TResult Function( List<ChirpCommunityMembership> memberships,  bool isLoading,  bool hasReachedMax)  loaded,}) {final _that = this;
switch (_that) {
case ChirpCommunityMembershipListingInitialState():
return initial();case ChirpCommunityMembershipListingLoadingState():
return loading();case ChirpCommunityMembershipListingErrorState():
return error(_that.error);case ChirpCommunityMembershipListingLoadedState():
return loaded(_that.memberships,_that.isLoading,_that.hasReachedMax);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String error)?  error,TResult? Function( List<ChirpCommunityMembership> memberships,  bool isLoading,  bool hasReachedMax)?  loaded,}) {final _that = this;
switch (_that) {
case ChirpCommunityMembershipListingInitialState() when initial != null:
return initial();case ChirpCommunityMembershipListingLoadingState() when loading != null:
return loading();case ChirpCommunityMembershipListingErrorState() when error != null:
return error(_that.error);case ChirpCommunityMembershipListingLoadedState() when loaded != null:
return loaded(_that.memberships,_that.isLoading,_that.hasReachedMax);case _:
  return null;

}
}

}

/// @nodoc


class ChirpCommunityMembershipListingInitialState implements ChirpCommunityMembershipListingState {
  const ChirpCommunityMembershipListingInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipListingInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChirpCommunityMembershipListingState.initial()';
}


}




/// @nodoc


class ChirpCommunityMembershipListingLoadingState implements ChirpCommunityMembershipListingState {
  const ChirpCommunityMembershipListingLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipListingLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChirpCommunityMembershipListingState.loading()';
}


}




/// @nodoc


class ChirpCommunityMembershipListingErrorState implements ChirpCommunityMembershipListingState {
  const ChirpCommunityMembershipListingErrorState({required this.error});
  

 final  String error;

/// Create a copy of ChirpCommunityMembershipListingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChirpCommunityMembershipListingErrorStateCopyWith<ChirpCommunityMembershipListingErrorState> get copyWith => _$ChirpCommunityMembershipListingErrorStateCopyWithImpl<ChirpCommunityMembershipListingErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipListingErrorState&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ChirpCommunityMembershipListingState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ChirpCommunityMembershipListingErrorStateCopyWith<$Res> implements $ChirpCommunityMembershipListingStateCopyWith<$Res> {
  factory $ChirpCommunityMembershipListingErrorStateCopyWith(ChirpCommunityMembershipListingErrorState value, $Res Function(ChirpCommunityMembershipListingErrorState) _then) = _$ChirpCommunityMembershipListingErrorStateCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ChirpCommunityMembershipListingErrorStateCopyWithImpl<$Res>
    implements $ChirpCommunityMembershipListingErrorStateCopyWith<$Res> {
  _$ChirpCommunityMembershipListingErrorStateCopyWithImpl(this._self, this._then);

  final ChirpCommunityMembershipListingErrorState _self;
  final $Res Function(ChirpCommunityMembershipListingErrorState) _then;

/// Create a copy of ChirpCommunityMembershipListingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ChirpCommunityMembershipListingErrorState(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChirpCommunityMembershipListingLoadedState implements ChirpCommunityMembershipListingState {
  const ChirpCommunityMembershipListingLoadedState({required final  List<ChirpCommunityMembership> memberships, this.isLoading = false, this.hasReachedMax = true}): _memberships = memberships;
  

 final  List<ChirpCommunityMembership> _memberships;
 List<ChirpCommunityMembership> get memberships {
  if (_memberships is EqualUnmodifiableListView) return _memberships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberships);
}

@JsonKey() final  bool isLoading;
@JsonKey() final  bool hasReachedMax;

/// Create a copy of ChirpCommunityMembershipListingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChirpCommunityMembershipListingLoadedStateCopyWith<ChirpCommunityMembershipListingLoadedState> get copyWith => _$ChirpCommunityMembershipListingLoadedStateCopyWithImpl<ChirpCommunityMembershipListingLoadedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipListingLoadedState&&const DeepCollectionEquality().equals(other._memberships, _memberships)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_memberships),isLoading,hasReachedMax);

@override
String toString() {
  return 'ChirpCommunityMembershipListingState.loaded(memberships: $memberships, isLoading: $isLoading, hasReachedMax: $hasReachedMax)';
}


}

/// @nodoc
abstract mixin class $ChirpCommunityMembershipListingLoadedStateCopyWith<$Res> implements $ChirpCommunityMembershipListingStateCopyWith<$Res> {
  factory $ChirpCommunityMembershipListingLoadedStateCopyWith(ChirpCommunityMembershipListingLoadedState value, $Res Function(ChirpCommunityMembershipListingLoadedState) _then) = _$ChirpCommunityMembershipListingLoadedStateCopyWithImpl;
@useResult
$Res call({
 List<ChirpCommunityMembership> memberships, bool isLoading, bool hasReachedMax
});




}
/// @nodoc
class _$ChirpCommunityMembershipListingLoadedStateCopyWithImpl<$Res>
    implements $ChirpCommunityMembershipListingLoadedStateCopyWith<$Res> {
  _$ChirpCommunityMembershipListingLoadedStateCopyWithImpl(this._self, this._then);

  final ChirpCommunityMembershipListingLoadedState _self;
  final $Res Function(ChirpCommunityMembershipListingLoadedState) _then;

/// Create a copy of ChirpCommunityMembershipListingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? memberships = null,Object? isLoading = null,Object? hasReachedMax = null,}) {
  return _then(ChirpCommunityMembershipListingLoadedState(
memberships: null == memberships ? _self._memberships : memberships // ignore: cast_nullable_to_non_nullable
as List<ChirpCommunityMembership>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
