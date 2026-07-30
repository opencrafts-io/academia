// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_community_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateCommunityState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCommunityState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateCommunityState()';
}


}

/// @nodoc
class $CreateCommunityStateCopyWith<$Res>  {
$CreateCommunityStateCopyWith(CreateCommunityState _, $Res Function(CreateCommunityState) __);
}


/// Adds pattern-matching-related methods to [CreateCommunityState].
extension CreateCommunityStatePatterns on CreateCommunityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CreateCommunityInitial value)?  initial,TResult Function( CreateCommunityLoading value)?  loading,TResult Function( CreateCommunitySuccess value)?  success,TResult Function( CreateCommunityFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CreateCommunityInitial() when initial != null:
return initial(_that);case CreateCommunityLoading() when loading != null:
return loading(_that);case CreateCommunitySuccess() when success != null:
return success(_that);case CreateCommunityFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CreateCommunityInitial value)  initial,required TResult Function( CreateCommunityLoading value)  loading,required TResult Function( CreateCommunitySuccess value)  success,required TResult Function( CreateCommunityFailure value)  failure,}){
final _that = this;
switch (_that) {
case CreateCommunityInitial():
return initial(_that);case CreateCommunityLoading():
return loading(_that);case CreateCommunitySuccess():
return success(_that);case CreateCommunityFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CreateCommunityInitial value)?  initial,TResult? Function( CreateCommunityLoading value)?  loading,TResult? Function( CreateCommunitySuccess value)?  success,TResult? Function( CreateCommunityFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CreateCommunityInitial() when initial != null:
return initial(_that);case CreateCommunityLoading() when loading != null:
return loading(_that);case CreateCommunitySuccess() when success != null:
return success(_that);case CreateCommunityFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Community community)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CreateCommunityInitial() when initial != null:
return initial();case CreateCommunityLoading() when loading != null:
return loading();case CreateCommunitySuccess() when success != null:
return success(_that.community);case CreateCommunityFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Community community)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CreateCommunityInitial():
return initial();case CreateCommunityLoading():
return loading();case CreateCommunitySuccess():
return success(_that.community);case CreateCommunityFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Community community)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CreateCommunityInitial() when initial != null:
return initial();case CreateCommunityLoading() when loading != null:
return loading();case CreateCommunitySuccess() when success != null:
return success(_that.community);case CreateCommunityFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CreateCommunityInitial implements CreateCommunityState {
  const CreateCommunityInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCommunityInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateCommunityState.initial()';
}


}




/// @nodoc


class CreateCommunityLoading implements CreateCommunityState {
  const CreateCommunityLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCommunityLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateCommunityState.loading()';
}


}




/// @nodoc


class CreateCommunitySuccess implements CreateCommunityState {
  const CreateCommunitySuccess({required this.community});
  

 final  Community community;

/// Create a copy of CreateCommunityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateCommunitySuccessCopyWith<CreateCommunitySuccess> get copyWith => _$CreateCommunitySuccessCopyWithImpl<CreateCommunitySuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCommunitySuccess&&(identical(other.community, community) || other.community == community));
}


@override
int get hashCode => Object.hash(runtimeType,community);

@override
String toString() {
  return 'CreateCommunityState.success(community: $community)';
}


}

/// @nodoc
abstract mixin class $CreateCommunitySuccessCopyWith<$Res> implements $CreateCommunityStateCopyWith<$Res> {
  factory $CreateCommunitySuccessCopyWith(CreateCommunitySuccess value, $Res Function(CreateCommunitySuccess) _then) = _$CreateCommunitySuccessCopyWithImpl;
@useResult
$Res call({
 Community community
});


$CommunityCopyWith<$Res> get community;

}
/// @nodoc
class _$CreateCommunitySuccessCopyWithImpl<$Res>
    implements $CreateCommunitySuccessCopyWith<$Res> {
  _$CreateCommunitySuccessCopyWithImpl(this._self, this._then);

  final CreateCommunitySuccess _self;
  final $Res Function(CreateCommunitySuccess) _then;

/// Create a copy of CreateCommunityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? community = null,}) {
  return _then(CreateCommunitySuccess(
community: null == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as Community,
  ));
}

/// Create a copy of CreateCommunityState
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


class CreateCommunityFailure implements CreateCommunityState {
  const CreateCommunityFailure({required this.message});
  

 final  String message;

/// Create a copy of CreateCommunityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateCommunityFailureCopyWith<CreateCommunityFailure> get copyWith => _$CreateCommunityFailureCopyWithImpl<CreateCommunityFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCommunityFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CreateCommunityState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CreateCommunityFailureCopyWith<$Res> implements $CreateCommunityStateCopyWith<$Res> {
  factory $CreateCommunityFailureCopyWith(CreateCommunityFailure value, $Res Function(CreateCommunityFailure) _then) = _$CreateCommunityFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CreateCommunityFailureCopyWithImpl<$Res>
    implements $CreateCommunityFailureCopyWith<$Res> {
  _$CreateCommunityFailureCopyWithImpl(this._self, this._then);

  final CreateCommunityFailure _self;
  final $Res Function(CreateCommunityFailure) _then;

/// Create a copy of CreateCommunityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CreateCommunityFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
