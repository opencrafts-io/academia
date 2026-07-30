// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityHomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityHomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityHomeState()';
}


}

/// @nodoc
class $CommunityHomeStateCopyWith<$Res>  {
$CommunityHomeStateCopyWith(CommunityHomeState _, $Res Function(CommunityHomeState) __);
}


/// Adds pattern-matching-related methods to [CommunityHomeState].
extension CommunityHomeStatePatterns on CommunityHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CommunityHomeInitial value)?  initial,TResult Function( CommunityHomeLoading value)?  loading,TResult Function( CommunityHomeLoaded value)?  loaded,TResult Function( CommunityCriticalActionFailure value)?  criticalActionFailure,TResult Function( CommunityDeleted value)?  deleted,TResult Function( CommunityHomeFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CommunityHomeInitial() when initial != null:
return initial(_that);case CommunityHomeLoading() when loading != null:
return loading(_that);case CommunityHomeLoaded() when loaded != null:
return loaded(_that);case CommunityCriticalActionFailure() when criticalActionFailure != null:
return criticalActionFailure(_that);case CommunityDeleted() when deleted != null:
return deleted(_that);case CommunityHomeFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CommunityHomeInitial value)  initial,required TResult Function( CommunityHomeLoading value)  loading,required TResult Function( CommunityHomeLoaded value)  loaded,required TResult Function( CommunityCriticalActionFailure value)  criticalActionFailure,required TResult Function( CommunityDeleted value)  deleted,required TResult Function( CommunityHomeFailure value)  failure,}){
final _that = this;
switch (_that) {
case CommunityHomeInitial():
return initial(_that);case CommunityHomeLoading():
return loading(_that);case CommunityHomeLoaded():
return loaded(_that);case CommunityCriticalActionFailure():
return criticalActionFailure(_that);case CommunityDeleted():
return deleted(_that);case CommunityHomeFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CommunityHomeInitial value)?  initial,TResult? Function( CommunityHomeLoading value)?  loading,TResult? Function( CommunityHomeLoaded value)?  loaded,TResult? Function( CommunityCriticalActionFailure value)?  criticalActionFailure,TResult? Function( CommunityDeleted value)?  deleted,TResult? Function( CommunityHomeFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CommunityHomeInitial() when initial != null:
return initial(_that);case CommunityHomeLoading() when loading != null:
return loading(_that);case CommunityHomeLoaded() when loaded != null:
return loaded(_that);case CommunityCriticalActionFailure() when criticalActionFailure != null:
return criticalActionFailure(_that);case CommunityDeleted() when deleted != null:
return deleted(_that);case CommunityHomeFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Community community)?  loaded,TResult Function( String message)?  criticalActionFailure,TResult Function()?  deleted,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CommunityHomeInitial() when initial != null:
return initial();case CommunityHomeLoading() when loading != null:
return loading();case CommunityHomeLoaded() when loaded != null:
return loaded(_that.community);case CommunityCriticalActionFailure() when criticalActionFailure != null:
return criticalActionFailure(_that.message);case CommunityDeleted() when deleted != null:
return deleted();case CommunityHomeFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Community community)  loaded,required TResult Function( String message)  criticalActionFailure,required TResult Function()  deleted,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CommunityHomeInitial():
return initial();case CommunityHomeLoading():
return loading();case CommunityHomeLoaded():
return loaded(_that.community);case CommunityCriticalActionFailure():
return criticalActionFailure(_that.message);case CommunityDeleted():
return deleted();case CommunityHomeFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Community community)?  loaded,TResult? Function( String message)?  criticalActionFailure,TResult? Function()?  deleted,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CommunityHomeInitial() when initial != null:
return initial();case CommunityHomeLoading() when loading != null:
return loading();case CommunityHomeLoaded() when loaded != null:
return loaded(_that.community);case CommunityCriticalActionFailure() when criticalActionFailure != null:
return criticalActionFailure(_that.message);case CommunityDeleted() when deleted != null:
return deleted();case CommunityHomeFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CommunityHomeInitial implements CommunityHomeState {
  const CommunityHomeInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityHomeInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityHomeState.initial()';
}


}




/// @nodoc


class CommunityHomeLoading implements CommunityHomeState {
  const CommunityHomeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityHomeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityHomeState.loading()';
}


}




/// @nodoc


class CommunityHomeLoaded implements CommunityHomeState {
  const CommunityHomeLoaded(this.community);
  

 final  Community community;

/// Create a copy of CommunityHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityHomeLoadedCopyWith<CommunityHomeLoaded> get copyWith => _$CommunityHomeLoadedCopyWithImpl<CommunityHomeLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityHomeLoaded&&(identical(other.community, community) || other.community == community));
}


@override
int get hashCode => Object.hash(runtimeType,community);

@override
String toString() {
  return 'CommunityHomeState.loaded(community: $community)';
}


}

/// @nodoc
abstract mixin class $CommunityHomeLoadedCopyWith<$Res> implements $CommunityHomeStateCopyWith<$Res> {
  factory $CommunityHomeLoadedCopyWith(CommunityHomeLoaded value, $Res Function(CommunityHomeLoaded) _then) = _$CommunityHomeLoadedCopyWithImpl;
@useResult
$Res call({
 Community community
});


$CommunityCopyWith<$Res> get community;

}
/// @nodoc
class _$CommunityHomeLoadedCopyWithImpl<$Res>
    implements $CommunityHomeLoadedCopyWith<$Res> {
  _$CommunityHomeLoadedCopyWithImpl(this._self, this._then);

  final CommunityHomeLoaded _self;
  final $Res Function(CommunityHomeLoaded) _then;

/// Create a copy of CommunityHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? community = null,}) {
  return _then(CommunityHomeLoaded(
null == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as Community,
  ));
}

/// Create a copy of CommunityHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunityCopyWith<$Res> get community {
  
  return $CommunityCopyWith<$Res>(_self.community, (value) {
    return _then(_self.copyWith(community: value));
  });
}
}

/// @nodoc


class CommunityCriticalActionFailure implements CommunityHomeState {
  const CommunityCriticalActionFailure(this.message);
  

 final  String message;

/// Create a copy of CommunityHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityCriticalActionFailureCopyWith<CommunityCriticalActionFailure> get copyWith => _$CommunityCriticalActionFailureCopyWithImpl<CommunityCriticalActionFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityCriticalActionFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CommunityHomeState.criticalActionFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CommunityCriticalActionFailureCopyWith<$Res> implements $CommunityHomeStateCopyWith<$Res> {
  factory $CommunityCriticalActionFailureCopyWith(CommunityCriticalActionFailure value, $Res Function(CommunityCriticalActionFailure) _then) = _$CommunityCriticalActionFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CommunityCriticalActionFailureCopyWithImpl<$Res>
    implements $CommunityCriticalActionFailureCopyWith<$Res> {
  _$CommunityCriticalActionFailureCopyWithImpl(this._self, this._then);

  final CommunityCriticalActionFailure _self;
  final $Res Function(CommunityCriticalActionFailure) _then;

/// Create a copy of CommunityHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CommunityCriticalActionFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CommunityDeleted implements CommunityHomeState {
  const CommunityDeleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityDeleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityHomeState.deleted()';
}


}




/// @nodoc


class CommunityHomeFailure implements CommunityHomeState {
  const CommunityHomeFailure(this.message);
  

 final  String message;

/// Create a copy of CommunityHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityHomeFailureCopyWith<CommunityHomeFailure> get copyWith => _$CommunityHomeFailureCopyWithImpl<CommunityHomeFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityHomeFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CommunityHomeState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CommunityHomeFailureCopyWith<$Res> implements $CommunityHomeStateCopyWith<$Res> {
  factory $CommunityHomeFailureCopyWith(CommunityHomeFailure value, $Res Function(CommunityHomeFailure) _then) = _$CommunityHomeFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CommunityHomeFailureCopyWithImpl<$Res>
    implements $CommunityHomeFailureCopyWith<$Res> {
  _$CommunityHomeFailureCopyWithImpl(this._self, this._then);

  final CommunityHomeFailure _self;
  final $Res Function(CommunityHomeFailure) _then;

/// Create a copy of CommunityHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CommunityHomeFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
