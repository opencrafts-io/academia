// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_load_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudyLoadState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyLoadState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StudyLoadState()';
}


}

/// @nodoc
class $StudyLoadStateCopyWith<$Res>  {
$StudyLoadStateCopyWith(StudyLoadState _, $Res Function(StudyLoadState) __);
}


/// Adds pattern-matching-related methods to [StudyLoadState].
extension StudyLoadStatePatterns on StudyLoadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StudyLoadInitial value)?  initial,TResult Function( StudyLoadLoading value)?  loading,TResult Function( StudyLoadLoaded value)?  loaded,TResult Function( StudyLoadFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StudyLoadInitial() when initial != null:
return initial(_that);case StudyLoadLoading() when loading != null:
return loading(_that);case StudyLoadLoaded() when loaded != null:
return loaded(_that);case StudyLoadFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StudyLoadInitial value)  initial,required TResult Function( StudyLoadLoading value)  loading,required TResult Function( StudyLoadLoaded value)  loaded,required TResult Function( StudyLoadFailure value)  failure,}){
final _that = this;
switch (_that) {
case StudyLoadInitial():
return initial(_that);case StudyLoadLoading():
return loading(_that);case StudyLoadLoaded():
return loaded(_that);case StudyLoadFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StudyLoadInitial value)?  initial,TResult? Function( StudyLoadLoading value)?  loading,TResult? Function( StudyLoadLoaded value)?  loaded,TResult? Function( StudyLoadFailure value)?  failure,}){
final _that = this;
switch (_that) {
case StudyLoadInitial() when initial != null:
return initial(_that);case StudyLoadLoading() when loading != null:
return loading(_that);case StudyLoadLoaded() when loaded != null:
return loaded(_that);case StudyLoadFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  loaded,TResult Function( String message,  String? code)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StudyLoadInitial() when initial != null:
return initial();case StudyLoadLoading() when loading != null:
return loading();case StudyLoadLoaded() when loaded != null:
return loaded();case StudyLoadFailure() when failure != null:
return failure(_that.message,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  loaded,required TResult Function( String message,  String? code)  failure,}) {final _that = this;
switch (_that) {
case StudyLoadInitial():
return initial();case StudyLoadLoading():
return loading();case StudyLoadLoaded():
return loaded();case StudyLoadFailure():
return failure(_that.message,_that.code);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function( String message,  String? code)?  failure,}) {final _that = this;
switch (_that) {
case StudyLoadInitial() when initial != null:
return initial();case StudyLoadLoading() when loading != null:
return loading();case StudyLoadLoaded() when loaded != null:
return loaded();case StudyLoadFailure() when failure != null:
return failure(_that.message,_that.code);case _:
  return null;

}
}

}

/// @nodoc


class StudyLoadInitial implements StudyLoadState {
  const StudyLoadInitial();







@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyLoadInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StudyLoadState.initial()';
}


}




/// @nodoc


class StudyLoadLoading implements StudyLoadState {
  const StudyLoadLoading();







@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyLoadLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StudyLoadState.loading()';
}


}




/// @nodoc


class StudyLoadLoaded implements StudyLoadState {
  const StudyLoadLoaded();







@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyLoadLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'StudyLoadState.loaded()';
}


}




/// @nodoc


class StudyLoadFailure implements StudyLoadState {
  const StudyLoadFailure({required this.message, this.code});


 final  String message;
 final  String? code;

/// Create a copy of StudyLoadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyLoadFailureCopyWith<StudyLoadFailure> get copyWith => _$StudyLoadFailureCopyWithImpl<StudyLoadFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyLoadFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,code);
}

@override
String toString() {
    return 'StudyLoadState.failure(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $StudyLoadFailureCopyWith<$Res> implements $StudyLoadStateCopyWith<$Res> {
  factory $StudyLoadFailureCopyWith(StudyLoadFailure value, $Res Function(StudyLoadFailure) _then) = _$StudyLoadFailureCopyWithImpl;
@useResult
$Res call({
 String message, String? code
});




}
/// @nodoc
class _$StudyLoadFailureCopyWithImpl<$Res>
    implements $StudyLoadFailureCopyWith<$Res> {
  _$StudyLoadFailureCopyWithImpl(this._self, this._then);

  final StudyLoadFailure _self;
  final $Res Function(StudyLoadFailure) _then;

/// Create a copy of StudyLoadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = freezed,}) {
  return _then(StudyLoadFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
