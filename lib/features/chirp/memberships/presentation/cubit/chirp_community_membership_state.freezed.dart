// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chirp_community_membership_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChirpCommunityMembershipState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChirpCommunityMembershipState()';
}


}

/// @nodoc
class $ChirpCommunityMembershipStateCopyWith<$Res>  {
$ChirpCommunityMembershipStateCopyWith(ChirpCommunityMembershipState _, $Res Function(ChirpCommunityMembershipState) __);
}


/// Adds pattern-matching-related methods to [ChirpCommunityMembershipState].
extension ChirpCommunityMembershipStatePatterns on ChirpCommunityMembershipState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChirpCommunityMembershipInitialState value)?  initial,TResult Function( ChirpCommunityMembershipCommunityLeftState value)?  communityLeft,TResult Function( ChirpCommunityMembershipStateLoadingState value)?  loading,TResult Function( ChirpCommunityMembershipLoadedState value)?  loaded,TResult Function( ChirpCommunityMembershipErrorState value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChirpCommunityMembershipInitialState() when initial != null:
return initial(_that);case ChirpCommunityMembershipCommunityLeftState() when communityLeft != null:
return communityLeft(_that);case ChirpCommunityMembershipStateLoadingState() when loading != null:
return loading(_that);case ChirpCommunityMembershipLoadedState() when loaded != null:
return loaded(_that);case ChirpCommunityMembershipErrorState() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChirpCommunityMembershipInitialState value)  initial,required TResult Function( ChirpCommunityMembershipCommunityLeftState value)  communityLeft,required TResult Function( ChirpCommunityMembershipStateLoadingState value)  loading,required TResult Function( ChirpCommunityMembershipLoadedState value)  loaded,required TResult Function( ChirpCommunityMembershipErrorState value)  error,}){
final _that = this;
switch (_that) {
case ChirpCommunityMembershipInitialState():
return initial(_that);case ChirpCommunityMembershipCommunityLeftState():
return communityLeft(_that);case ChirpCommunityMembershipStateLoadingState():
return loading(_that);case ChirpCommunityMembershipLoadedState():
return loaded(_that);case ChirpCommunityMembershipErrorState():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChirpCommunityMembershipInitialState value)?  initial,TResult? Function( ChirpCommunityMembershipCommunityLeftState value)?  communityLeft,TResult? Function( ChirpCommunityMembershipStateLoadingState value)?  loading,TResult? Function( ChirpCommunityMembershipLoadedState value)?  loaded,TResult? Function( ChirpCommunityMembershipErrorState value)?  error,}){
final _that = this;
switch (_that) {
case ChirpCommunityMembershipInitialState() when initial != null:
return initial(_that);case ChirpCommunityMembershipCommunityLeftState() when communityLeft != null:
return communityLeft(_that);case ChirpCommunityMembershipStateLoadingState() when loading != null:
return loading(_that);case ChirpCommunityMembershipLoadedState() when loaded != null:
return loaded(_that);case ChirpCommunityMembershipErrorState() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( int communityID)?  communityLeft,TResult Function()?  loading,TResult Function( ChirpCommunityMembership membership)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChirpCommunityMembershipInitialState() when initial != null:
return initial();case ChirpCommunityMembershipCommunityLeftState() when communityLeft != null:
return communityLeft(_that.communityID);case ChirpCommunityMembershipStateLoadingState() when loading != null:
return loading();case ChirpCommunityMembershipLoadedState() when loaded != null:
return loaded(_that.membership);case ChirpCommunityMembershipErrorState() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( int communityID)  communityLeft,required TResult Function()  loading,required TResult Function( ChirpCommunityMembership membership)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case ChirpCommunityMembershipInitialState():
return initial();case ChirpCommunityMembershipCommunityLeftState():
return communityLeft(_that.communityID);case ChirpCommunityMembershipStateLoadingState():
return loading();case ChirpCommunityMembershipLoadedState():
return loaded(_that.membership);case ChirpCommunityMembershipErrorState():
return error(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( int communityID)?  communityLeft,TResult? Function()?  loading,TResult? Function( ChirpCommunityMembership membership)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case ChirpCommunityMembershipInitialState() when initial != null:
return initial();case ChirpCommunityMembershipCommunityLeftState() when communityLeft != null:
return communityLeft(_that.communityID);case ChirpCommunityMembershipStateLoadingState() when loading != null:
return loading();case ChirpCommunityMembershipLoadedState() when loaded != null:
return loaded(_that.membership);case ChirpCommunityMembershipErrorState() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class ChirpCommunityMembershipInitialState implements ChirpCommunityMembershipState {
  const ChirpCommunityMembershipInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChirpCommunityMembershipState.initial()';
}


}




/// @nodoc


class ChirpCommunityMembershipCommunityLeftState implements ChirpCommunityMembershipState {
  const ChirpCommunityMembershipCommunityLeftState({required this.communityID});
  

 final  int communityID;

/// Create a copy of ChirpCommunityMembershipState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChirpCommunityMembershipCommunityLeftStateCopyWith<ChirpCommunityMembershipCommunityLeftState> get copyWith => _$ChirpCommunityMembershipCommunityLeftStateCopyWithImpl<ChirpCommunityMembershipCommunityLeftState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipCommunityLeftState&&(identical(other.communityID, communityID) || other.communityID == communityID));
}


@override
int get hashCode => Object.hash(runtimeType,communityID);

@override
String toString() {
  return 'ChirpCommunityMembershipState.communityLeft(communityID: $communityID)';
}


}

/// @nodoc
abstract mixin class $ChirpCommunityMembershipCommunityLeftStateCopyWith<$Res> implements $ChirpCommunityMembershipStateCopyWith<$Res> {
  factory $ChirpCommunityMembershipCommunityLeftStateCopyWith(ChirpCommunityMembershipCommunityLeftState value, $Res Function(ChirpCommunityMembershipCommunityLeftState) _then) = _$ChirpCommunityMembershipCommunityLeftStateCopyWithImpl;
@useResult
$Res call({
 int communityID
});




}
/// @nodoc
class _$ChirpCommunityMembershipCommunityLeftStateCopyWithImpl<$Res>
    implements $ChirpCommunityMembershipCommunityLeftStateCopyWith<$Res> {
  _$ChirpCommunityMembershipCommunityLeftStateCopyWithImpl(this._self, this._then);

  final ChirpCommunityMembershipCommunityLeftState _self;
  final $Res Function(ChirpCommunityMembershipCommunityLeftState) _then;

/// Create a copy of ChirpCommunityMembershipState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityID = null,}) {
  return _then(ChirpCommunityMembershipCommunityLeftState(
communityID: null == communityID ? _self.communityID : communityID // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ChirpCommunityMembershipStateLoadingState implements ChirpCommunityMembershipState {
  const ChirpCommunityMembershipStateLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipStateLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChirpCommunityMembershipState.loading()';
}


}




/// @nodoc


class ChirpCommunityMembershipLoadedState implements ChirpCommunityMembershipState {
  const ChirpCommunityMembershipLoadedState({required this.membership});
  

 final  ChirpCommunityMembership membership;

/// Create a copy of ChirpCommunityMembershipState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChirpCommunityMembershipLoadedStateCopyWith<ChirpCommunityMembershipLoadedState> get copyWith => _$ChirpCommunityMembershipLoadedStateCopyWithImpl<ChirpCommunityMembershipLoadedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipLoadedState&&(identical(other.membership, membership) || other.membership == membership));
}


@override
int get hashCode => Object.hash(runtimeType,membership);

@override
String toString() {
  return 'ChirpCommunityMembershipState.loaded(membership: $membership)';
}


}

/// @nodoc
abstract mixin class $ChirpCommunityMembershipLoadedStateCopyWith<$Res> implements $ChirpCommunityMembershipStateCopyWith<$Res> {
  factory $ChirpCommunityMembershipLoadedStateCopyWith(ChirpCommunityMembershipLoadedState value, $Res Function(ChirpCommunityMembershipLoadedState) _then) = _$ChirpCommunityMembershipLoadedStateCopyWithImpl;
@useResult
$Res call({
 ChirpCommunityMembership membership
});


$ChirpCommunityMembershipCopyWith<$Res> get membership;

}
/// @nodoc
class _$ChirpCommunityMembershipLoadedStateCopyWithImpl<$Res>
    implements $ChirpCommunityMembershipLoadedStateCopyWith<$Res> {
  _$ChirpCommunityMembershipLoadedStateCopyWithImpl(this._self, this._then);

  final ChirpCommunityMembershipLoadedState _self;
  final $Res Function(ChirpCommunityMembershipLoadedState) _then;

/// Create a copy of ChirpCommunityMembershipState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? membership = null,}) {
  return _then(ChirpCommunityMembershipLoadedState(
membership: null == membership ? _self.membership : membership // ignore: cast_nullable_to_non_nullable
as ChirpCommunityMembership,
  ));
}

/// Create a copy of ChirpCommunityMembershipState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChirpCommunityMembershipCopyWith<$Res> get membership {
  
  return $ChirpCommunityMembershipCopyWith<$Res>(_self.membership, (value) {
    return _then(_self.copyWith(membership: value));
  });
}
}

/// @nodoc


class ChirpCommunityMembershipErrorState implements ChirpCommunityMembershipState {
  const ChirpCommunityMembershipErrorState({required this.error});
  

 final  String error;

/// Create a copy of ChirpCommunityMembershipState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChirpCommunityMembershipErrorStateCopyWith<ChirpCommunityMembershipErrorState> get copyWith => _$ChirpCommunityMembershipErrorStateCopyWithImpl<ChirpCommunityMembershipErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipErrorState&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ChirpCommunityMembershipState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ChirpCommunityMembershipErrorStateCopyWith<$Res> implements $ChirpCommunityMembershipStateCopyWith<$Res> {
  factory $ChirpCommunityMembershipErrorStateCopyWith(ChirpCommunityMembershipErrorState value, $Res Function(ChirpCommunityMembershipErrorState) _then) = _$ChirpCommunityMembershipErrorStateCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ChirpCommunityMembershipErrorStateCopyWithImpl<$Res>
    implements $ChirpCommunityMembershipErrorStateCopyWith<$Res> {
  _$ChirpCommunityMembershipErrorStateCopyWithImpl(this._self, this._then);

  final ChirpCommunityMembershipErrorState _self;
  final $Res Function(ChirpCommunityMembershipErrorState) _then;

/// Create a copy of ChirpCommunityMembershipState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ChirpCommunityMembershipErrorState(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
