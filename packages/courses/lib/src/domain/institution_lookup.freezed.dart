// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution_lookup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstitutionSummary {

 int get id; String get name;
/// Create a copy of InstitutionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstitutionSummaryCopyWith<InstitutionSummary> get copyWith => _$InstitutionSummaryCopyWithImpl<InstitutionSummary>(this as InstitutionSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InstitutionSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstitutionSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}


@override
int get hashCode {
  final _this = this as InstitutionSummary;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as InstitutionSummary;
  return 'InstitutionSummary(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $InstitutionSummaryCopyWith<$Res>  {
  factory $InstitutionSummaryCopyWith(InstitutionSummary value, $Res Function(InstitutionSummary) _then) = _$InstitutionSummaryCopyWithImpl;
@useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class _$InstitutionSummaryCopyWithImpl<$Res>
    implements $InstitutionSummaryCopyWith<$Res> {
  _$InstitutionSummaryCopyWithImpl(this._self, this._then);

  final InstitutionSummary _self;
  final $Res Function(InstitutionSummary) _then;

/// Create a copy of InstitutionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(InstitutionSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InstitutionSummary].
extension InstitutionSummaryPatterns on InstitutionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstitutionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstitutionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstitutionSummary value)  $default,){
final _that = this;
switch (_that) {
case _InstitutionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstitutionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _InstitutionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstitutionSummary() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name)  $default,) {final _that = this;
switch (_that) {
case _InstitutionSummary():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _InstitutionSummary() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _InstitutionSummary implements InstitutionSummary {
  const _InstitutionSummary({required this.id, required this.name});
  

@override final  int id;
@override final  String name;

/// Create a copy of InstitutionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstitutionSummaryCopyWith<_InstitutionSummary> get copyWith => __$InstitutionSummaryCopyWithImpl<_InstitutionSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstitutionSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'InstitutionSummary(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$InstitutionSummaryCopyWith<$Res> implements $InstitutionSummaryCopyWith<$Res> {
  factory _$InstitutionSummaryCopyWith(_InstitutionSummary value, $Res Function(_InstitutionSummary) _then) = __$InstitutionSummaryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class __$InstitutionSummaryCopyWithImpl<$Res>
    implements _$InstitutionSummaryCopyWith<$Res> {
  __$InstitutionSummaryCopyWithImpl(this._self, this._then);

  final _InstitutionSummary _self;
  final $Res Function(_InstitutionSummary) _then;

/// Create a copy of InstitutionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_InstitutionSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
