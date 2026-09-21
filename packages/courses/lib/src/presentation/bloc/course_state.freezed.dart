// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CourseState {

 List<CourseEntity> get courses; CourseEntity? get selectedCourse; bool get isLoading; String? get error;
/// Create a copy of CourseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseStateCopyWith<CourseState> get copyWith => _$CourseStateCopyWithImpl<CourseState>(this as CourseState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CourseState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseState&&const DeepCollectionEquality().equals(other.courses, _this.courses)&&(identical(other.selectedCourse, _this.selectedCourse) || other.selectedCourse == _this.selectedCourse)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as CourseState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.courses),_this.selectedCourse,_this.isLoading,_this.error);
}

@override
String toString() {
  final _this = this as CourseState;
  return 'CourseState(courses: ${_this.courses}, selectedCourse: ${_this.selectedCourse}, isLoading: ${_this.isLoading}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $CourseStateCopyWith<$Res>  {
  factory $CourseStateCopyWith(CourseState value, $Res Function(CourseState) _then) = _$CourseStateCopyWithImpl;
@useResult
$Res call({
 List<CourseEntity> courses, CourseEntity? selectedCourse, bool isLoading, String? error
});


$CourseEntityCopyWith<$Res>? get selectedCourse;

}
/// @nodoc
class _$CourseStateCopyWithImpl<$Res>
    implements $CourseStateCopyWith<$Res> {
  _$CourseStateCopyWithImpl(this._self, this._then);

  final CourseState _self;
  final $Res Function(CourseState) _then;

/// Create a copy of CourseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courses = null,Object? selectedCourse = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(CourseState(
courses: null == courses ? _self.courses : courses // ignore: cast_nullable_to_non_nullable
as List<CourseEntity>,selectedCourse: freezed == selectedCourse ? _self.selectedCourse : selectedCourse // ignore: cast_nullable_to_non_nullable
as CourseEntity?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CourseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseEntityCopyWith<$Res>? get selectedCourse {
    if (_self.selectedCourse == null) {
    return null;
  }

  return $CourseEntityCopyWith<$Res>(_self.selectedCourse!, (value) {
    return _then(_self.copyWith(selectedCourse: value));
  });
}
}


/// Adds pattern-matching-related methods to [CourseState].
extension CourseStatePatterns on CourseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseState value)  $default,){
final _that = this;
switch (_that) {
case _CourseState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseState value)?  $default,){
final _that = this;
switch (_that) {
case _CourseState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CourseEntity> courses,  CourseEntity? selectedCourse,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseState() when $default != null:
return $default(_that.courses,_that.selectedCourse,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CourseEntity> courses,  CourseEntity? selectedCourse,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _CourseState():
return $default(_that.courses,_that.selectedCourse,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CourseEntity> courses,  CourseEntity? selectedCourse,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _CourseState() when $default != null:
return $default(_that.courses,_that.selectedCourse,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CourseState implements CourseState {
  const _CourseState({ List<CourseEntity> courses = const [], this.selectedCourse, this.isLoading = false, this.error}): _courses = courses;
  

 final  List<CourseEntity> _courses;
@override@JsonKey() List<CourseEntity> get courses {
  if (_courses is EqualUnmodifiableListView) return _courses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courses);
}

@override final  CourseEntity? selectedCourse;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of CourseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseStateCopyWith<_CourseState> get copyWith => __$CourseStateCopyWithImpl<_CourseState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseState&&const DeepCollectionEquality().equals(other.courses, _courses)&&(identical(other.selectedCourse, selectedCourse) || other.selectedCourse == selectedCourse)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_courses),selectedCourse,isLoading,error);
}

@override
String toString() {
    return 'CourseState(courses: $courses, selectedCourse: $selectedCourse, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$CourseStateCopyWith<$Res> implements $CourseStateCopyWith<$Res> {
  factory _$CourseStateCopyWith(_CourseState value, $Res Function(_CourseState) _then) = __$CourseStateCopyWithImpl;
@override @useResult
$Res call({
 List<CourseEntity> courses, CourseEntity? selectedCourse, bool isLoading, String? error
});


@override $CourseEntityCopyWith<$Res>? get selectedCourse;

}
/// @nodoc
class __$CourseStateCopyWithImpl<$Res>
    implements _$CourseStateCopyWith<$Res> {
  __$CourseStateCopyWithImpl(this._self, this._then);

  final _CourseState _self;
  final $Res Function(_CourseState) _then;

/// Create a copy of CourseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courses = null,Object? selectedCourse = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_CourseState(
courses: null == courses ? _self._courses : courses // ignore: cast_nullable_to_non_nullable
as List<CourseEntity>,selectedCourse: freezed == selectedCourse ? _self.selectedCourse : selectedCourse // ignore: cast_nullable_to_non_nullable
as CourseEntity?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CourseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseEntityCopyWith<$Res>? get selectedCourse {
    if (_self.selectedCourse == null) {
    return null;
  }

  return $CourseEntityCopyWith<$Res>(_self.selectedCourse!, (value) {
    return _then(_self.copyWith(selectedCourse: value));
  });
}
}

// dart format on
